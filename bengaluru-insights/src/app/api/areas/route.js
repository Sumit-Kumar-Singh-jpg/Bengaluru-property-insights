import pool from '@/lib/db';

export async function GET() {
  try {
    const connection = await pool.getConnection();
    const [rows] = await connection.query(`
      SELECT 
        a.area_id, 
        a.name, 
        a.zone, 
        a.latitude,
        a.longitude,
        m.current_price, 
        m.avg_roi_pct, 
        m.growth_1yr, 
        m.growth_3yr, 
        m.growth_5yr
      FROM areas a 
      JOIN area_metrics m ON a.area_id = m.area_id
      ORDER BY m.current_price DESC
    `);
    connection.release();
    return new Response(JSON.stringify(rows), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (error) {
    console.error('Database connection failed:', error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
}
