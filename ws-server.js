const WebSocket = require('ws');
const express = require('express');
const mysql = require('mysql2/promise');

const db = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'Salam123!',
  database: 'heywork',
  waitForConnections: true,
  connectionLimit: 10
});

//local FPP
// const db = mysql.createPool({
//   host: 'localhost',
//   user: 'root',
//   password: '',
//   database: 'heywork',
//   waitForConnections: true,
//   connectionLimit: 10
// });

const app = express();
app.use(express.json());

const wss = new WebSocket.Server({
  port: 3004,
  host: '0.0.0.0'
});

console.log('WebSocket server running on port 3004');

/**
 * =========================
 * BROADCAST HELPER
 * =========================
 */
function broadcast(payload) {
  const message = JSON.stringify(payload);

  wss.clients.forEach(client => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(message);
    }
  });
}

async function autoCheckout() {

  try {

    console.log('⏱ Running auto checkout job...');

    /*
    ==========================
    SHIFT AUTO CHECKOUT
    ==========================
    */

    const [shiftRows] = await db.query(`
      SELECT 
          ja.job_id,
          ja.application_id,
          ja.user_id,
          ja.created_at,

          CASE
              WHEN ss.end_time < ss.start_time
              THEN TIMESTAMP(DATE_ADD(d.shift_date, INTERVAL 1 DAY), ss.end_time)
              ELSE TIMESTAMP(d.shift_date, ss.end_time)
          END AS shift_end

      FROM job_attendances ja

      JOIN schedule_shifts ss
        ON ss.job_id = ja.job_id
        AND ss.user_id = ja.user_id

      JOIN schedule_days d
        ON d.id = ss.schedule_day_id

      LEFT JOIN job_attendances ja2
        ON ja2.job_id = ja.job_id
        AND ja2.application_id = ja.application_id
        AND ja2.type = 'checkout'
        AND ja2.created_at =
          CASE
              WHEN ss.end_time < ss.start_time
              THEN TIMESTAMP(DATE_ADD(d.shift_date, INTERVAL 1 DAY), ss.end_time)
              ELSE TIMESTAMP(d.shift_date, ss.end_time)
          END

      WHERE ja.type = 'checkin'
      AND DATE(ja.created_at) = d.shift_date
      AND ja2.id IS NULL

      AND NOW() >=
      CASE
          WHEN ss.end_time < ss.start_time
          THEN TIMESTAMP(DATE_ADD(d.shift_date, INTERVAL 1 DAY), ss.end_time)
          ELSE TIMESTAMP(d.shift_date, ss.end_time)
      END
    `);

    console.log("AUTO SHIFT CHECKOUT:", shiftRows.length);

    for (const row of shiftRows) {

      await db.query(`
        INSERT INTO job_attendances
        (job_id, application_id, user_id, type, latitude, longitude, photo_path, device_info, created_at)
        VALUES (?, ?, ?, 'checkout', 0, 0, 'system-auto-checkout', 'AUTO SYSTEM', ?)
      `, [
        row.job_id,
        row.application_id,
        row.user_id,
        row.shift_end
      ]);

      console.log(`✅ Auto checkout job ${row.job_id} user ${row.user_id}`);

      broadcast({
        type: 'attendance_auto_checkout',
        job_id: row.job_id,
        user_id: row.user_id,
        checkout_time: row.shift_end
      });

    }


    /*
    ==========================
    TRAINING AUTO CHECKOUT
    ==========================
    */

    const [trainingRows] = await db.query(`
      SELECT
          ja.training_shift_id,
          ja.user_id,
          td.training_date,
          ts.end_time,

          TIMESTAMP(td.training_date, ts.end_time) AS training_end

      FROM job_attendances ja

      JOIN training_shifts ts
        ON ts.id = ja.training_shift_id

      JOIN training_days td
        ON td.id = ts.training_day_id

      LEFT JOIN job_attendances ja2
        ON ja2.training_shift_id = ja.training_shift_id
        AND ja2.user_id = ja.user_id
        AND ja2.type = 'checkout'
        AND ja2.created_at = TIMESTAMP(td.training_date, ts.end_time)

      WHERE ja.type = 'checkin'
      AND ja.training_shift_id IS NOT NULL
      AND ja2.id IS NULL

      AND NOW() >= TIMESTAMP(td.training_date, ts.end_time)
    `);

    console.log("AUTO TRAINING CHECKOUT:", trainingRows.length);

    for (const row of trainingRows) {

      await db.query(`
        INSERT INTO job_attendances
        (training_shift_id, user_id, type, latitude, longitude, photo_path, device_info, created_at, created_by)
        VALUES (?, ?, 'checkout', 0, 0, 'system-auto-checkout', 'AUTO SYSTEM', ?, ?)
      `, [
        row.training_shift_id,
        row.user_id,
        row.training_end,
        row.user_id
      ]);

      console.log(`🎓 Auto checkout training ${row.training_shift_id} user ${row.user_id}`);

      broadcast({
        type: 'attendance_training_auto_checkout',
        training_shift_id: row.training_shift_id,
        user_id: row.user_id,
        checkout_time: row.training_end
      });

    }

  } catch (err) {

    console.error('❌ Auto checkout error:', err);

  }

}

async function autoCompleteApplications() {
  try {
    console.log('🔎 Checking completed job applications...');

    const [rows] = await db.query(`
      SELECT 
        ja.id AS application_id,
        ja.user_id,
        j.id AS job_id,
        j.category,

        wc.end_date,

        MAX(d.shift_date) AS last_shift_day

      FROM job_applications ja

      JOIN jobs j 
        ON j.id = ja.job_id

      LEFT JOIN worker_contracts wc
        ON wc.user_id = ja.user_id

      LEFT JOIN schedule_shifts ss
        ON ss.application_id = ja.id

      LEFT JOIN schedule_days d
        ON d.id = ss.schedule_day_id

      WHERE ja.status != 'completed'

      GROUP BY ja.id

      HAVING
        (
          j.category = 'corporate'
          AND wc.end_date IS NOT NULL
          AND NOW() >= wc.end_date
        )
        OR
        (
          j.category IN ('daily_worker','casual')
          AND last_shift_day IS NOT NULL
          AND CURDATE() > last_shift_day
        )
    `);

    for (const row of rows) {

      await db.query(`
        UPDATE job_applications
        SET status = 'completed'
        WHERE id = ?
      `, [row.application_id]);

      console.log(`✅ Auto completed application ${row.application_id}`);

      broadcast({
        type: 'job_completed',
        application_id: row.application_id,
        user_id: row.user_id,
        job_id: row.job_id
      });
    }

  } catch (err) {
    console.error('❌ Auto complete error:', err);
  }
}

async function autoCloseJobs() {
  try {
    console.log('Checking expired jobs...');

    const [rows] = await db.query(`
      SELECT id, job_date_end
      FROM jobs
      WHERE status = 'open'
      AND deleted_at IS NULL
      AND job_date_end < CURDATE()
    `);

    console.log("AUTO CLOSE JOBS:", rows.length);

    for (const row of rows) {
      await db.query(`
        UPDATE jobs
        SET status = 'closed',
            updated_at = NOW()
        WHERE id = ?
      `, [row.id]);

      console.log(`Auto closed job ${row.id}`);

      // broadcast ke client (optional tapi bagus untuk realtime UI)
      broadcast({
        type: 'job_auto_closed',
        job_id: row.id,
        job_date_end: row.job_date_end
      });

    }

  } catch (err) {
    console.error('Auto close jobs error:', err);
  }
}

/**
 * =========================
 * WS CONNECTION
 * =========================
 */
wss.on('connection', (ws, req) => {
  ws.send(JSON.stringify({
    type: 'connected',
    message: 'WS connected'
  }));
});

/**
 * =========================
 * HTTP ENDPOINT (FROM CI4)
 * =========================
 */
app.post('/emit', (req, res) => {
  const payload = req.body;

  if (!payload || !payload.type) {
    return res.status(400).json({ message: 'Invalid payload' });
  }

  broadcast(payload);

  return res.json({ success: true });
});

/**
 * HTTP server (PORT 3005)
 */
app.listen(3005, () => {
  console.log('WS HTTP bridge running on port 3005');
  setInterval(() => {
    autoCheckout();
    autoCompleteApplications();
    autoCloseJobs();
  }, 1 * 60 * 1000);
});
