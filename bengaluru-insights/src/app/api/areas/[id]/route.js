import pool from '@/lib/db';

export async function GET(request, { params }) {
  const { id } = await params;
  
  try {
    const connection = await pool.getConnection();

    // Fetch basic area info + metrics
    const [areaRows] = await connection.query(`
      SELECT 
        a.area_id, 
        a.name, 
        a.zone, 
        m.current_price, 
        m.avg_roi_pct, 
        m.growth_1yr, 
        m.growth_3yr, 
        m.growth_5yr
      FROM areas a 
      JOIN area_metrics m ON a.area_id = m.area_id
      WHERE a.area_id = ?
    `, [id]);

    if (areaRows.length === 0) {
      connection.release();
      return new Response(JSON.stringify({ error: 'Area not found' }), { status: 404 });
    }

    // Fetch price history
    const [historyRows] = await connection.query(`
      SELECT year, avg_price_sqft as price
      FROM price_history
      WHERE area_id = ?
      ORDER BY year ASC
    `, [id]);

    connection.release();

    const result = {
      ...areaRows[0],
      history: historyRows
    };

    return new Response(JSON.stringify(result), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (error) {
    console.error('Failed to load area data:', error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
}
