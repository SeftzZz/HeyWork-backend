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

    const [rows] = await db.query(`
      SELECT 
        ja.job_id,
        ja.application_id,
        ja.user_id,
        DATE(ja.created_at) as job_date,
        j.end_time,
        TIMESTAMP(DATE(ja.created_at), j.end_time) as checkout_time
      FROM job_attendances ja
      JOIN jobs j ON j.id = ja.job_id

      LEFT JOIN job_attendances ja2
        ON ja2.job_id = ja.job_id
        AND ja2.application_id = ja.application_id
        AND ja2.type = 'checkout'
        AND DATE(ja2.created_at) = DATE(ja.created_at)

      WHERE ja.type = 'checkin'
        AND ja2.id IS NULL
        AND NOW() >= TIMESTAMP(DATE(ja.created_at), j.end_time)
    `);

    for (const row of rows) {

      await db.query(`
        INSERT INTO job_attendances 
        (job_id, application_id, user_id, type, latitude, longitude, photo_path, device_info, created_at)
        VALUES (?, ?, ?, 'checkout', 0, 0, 'system-auto-checkout', 'AUTO SYSTEM', ?)
      `, [
        row.job_id,
        row.application_id,
        row.user_id,
        row.checkout_time  // 🔥 sudah format: 2026-02-25 18:10:45
      ]);

      console.log(`✅ Auto checkout job ${row.job_id} user ${row.user_id} at ${row.checkout_time}`);

      broadcast({
        type: 'attendance_auto_checkout',
        job_id: row.job_id,
        user_id: row.user_id,
        checkout_time: row.checkout_time
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
        j.job_date_end,
        j.end_time,
        MAX(att.created_at) AS last_attendance,
        MAX(CASE WHEN att.type = 'checkout' THEN 1 ELSE 0 END) AS has_checkout
      FROM job_applications ja
      JOIN jobs j ON j.id = ja.job_id
      JOIN job_attendances att 
        ON att.application_id = ja.id
      WHERE ja.status != 'completed'
        AND j.job_date_end <= CURDATE()
      GROUP BY ja.id
      HAVING has_checkout = 1
        AND NOW() >= TIMESTAMP(j.job_date_end, j.end_time)
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
  }, 1 * 60 * 1000);
});
