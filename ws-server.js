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
        j.end_time
      FROM job_attendances ja
      JOIN jobs j ON j.id = ja.job_id
      LEFT JOIN job_attendances ja2
        ON ja2.job_id = ja.job_id
        AND ja2.application_id = ja.application_id
        AND ja2.type = 'checkout'
        AND DATE(ja2.created_at) = DATE(ja.created_at)
      WHERE ja.type = 'checkin'
      AND ja2.id IS NULL
      AND NOW() >= CONCAT(DATE(ja.created_at), ' ', j.end_time)
    `);

    for (const row of rows) {
      await db.query(`
        INSERT INTO job_attendances 
        (job_id, application_id, user_id, type, latitude, longitude, photo_path, device_info, created_at)
        VALUES (?, ?, ?, 'checkout', 0, 0, 'system-auto-checkout', 'AUTO SYSTEM', NOW())
      `, [
        row.job_id,
        row.application_id,
        row.user_id
      ]);

      console.log(`✅ Auto checkout job ${row.job_id} user ${row.user_id}`);

      // 🔥 Broadcast realtime
      broadcast({
        type: 'attendance_auto_checkout',
        job_id: row.job_id,
        user_id: row.user_id
      });
    }

  } catch (err) {
    console.error('❌ Auto checkout error:', err);
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
  setInterval(autoCheckout, 1 * 60 * 1000); // 10 menit
});
