import pool from '@/lib/db';

export async function GET(request) {
  const { searchParams } = new URL(request.url);
  const idsParam = searchParams.get('ids');

  if (!idsParam) {
    return new Response(JSON.stringify({ error: 'Missing ids parameter' }), { status: 400 });
  }

  const ids = idsParam.split(',').filter(id => !isNaN(parseInt(id, 10)));
  if (ids.length === 0 || ids.length > 3) {
    return new Response(JSON.stringify({ error: 'Provide 1 to 3 valid valid area ids' }), { status: 400 });
  }

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
      WHERE a.area_id IN (?)
    `, [ids]);

    if (areaRows.length === 0) {
      connection.release();
      return new Response(JSON.stringify({ error: 'Areas not found' }), { status: 404 });
    }

    // Fetch price history
    const [historyRows] = await connection.query(`
      SELECT area_id, year, avg_price_sqft as price
      FROM price_history
      WHERE area_id IN (?)
      ORDER BY year ASC
    `, [ids]);

    connection.release();

    // Reconstruct data
    const result = areaRows.map(area => ({
      ...area,
      history: historyRows.filter(h => h.area_id === area.area_id)
    }));

    return new Response(JSON.stringify(result), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (error) {
    console.error('Failed to load comparison data:', error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
}
