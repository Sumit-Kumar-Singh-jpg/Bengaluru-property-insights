const fs = require('fs');

const sql = fs.readFileSync('updated_bengaluru_lands_data.sql', 'utf8');

const areas = [];
const metrics = [];

// Parse areas
const areasMatch = sql.match(/INSERT INTO areas \([^)]+\) VALUES\s*([\s\S]*?);/);
if (areasMatch) {
    const valuesPart = areasMatch[1];
    const rows = valuesPart.match(/\(([^)]+)\)/g);
    rows.forEach((row, index) => {
        const parts = row.replace(/[()']/g, '').split(',').map(s => s.trim());
        areas.push({
            area_id: index + 1, // Auto increment starts at 1
            name: parts[0],
            zone: parts[1],
            latitude: parseFloat(parts[2]),
            longitude: parseFloat(parts[3])
        });
    });
}

// Parse metrics
const metricsMatch = sql.match(/SELECT a\.area_id, v\.current_price, v\.growth_1yr\s*FROM areas a\s*JOIN \(VALUES\s*([\s\S]*?)\) AS v/i);
if (metricsMatch) {
    const valuesPart = metricsMatch[1];
    const rows = valuesPart.match(/\(([^)]+)\)/g);
    
    rows.forEach(row => {
        // e.g., ('1st Block Rajajinagar', 25200, 24.00)
        let cleanRow = row.replace(/^\(|\)$/g, ''); // remove outer parens
        // Split by comma outside quotes
        // Simple split is fine since there are no commas in the names (we assume)
        let parts = [];
        let inQuotes = false;
        let buf = "";
        for(let i=0; i<cleanRow.length; i++){
            let c = cleanRow[i];
            if(c === "'") inQuotes = !inQuotes;
            else if(c === "," && !inQuotes){
                parts.push(buf.trim());
                buf = "";
            } else {
                buf += c;
            }
        }
        parts.push(buf.trim());
        
        let pointName = parts[0].replace(/^'|'$/g, '');
        let current_price = parseFloat(parts[1]);
        let growth_1yr = parseFloat(parts[2]);
        
        let area = areas.find(a => a.name === pointName);
        if (area) {
            let growth_3yr = parseFloat((growth_1yr * 2.8).toFixed(2));
            let growth_5yr = parseFloat((growth_1yr * 4.5).toFixed(2));
            let avg_roi_pct = parseFloat((growth_1yr * 0.85).toFixed(2));
            
            metrics.push({
                area_id: area.area_id,
                current_price,
                growth_1yr,
                growth_3yr,
                growth_5yr,
                avg_roi_pct
            });
        }
    });
}

// Combine for the API
const joinedData = areas.map(a => {
    const m = metrics.find(met => met.area_id === a.area_id);
    return {
        ...a,
        ...(m || {})
    };
}).sort((a,b) => (b.avg_roi_pct || 0) - (a.avg_roi_pct || 0));

fs.writeFileSync('bengaluru-insights/src/lib/data.json', JSON.stringify(joinedData, null, 2));
console.log('Extraction complete. Data written to data.json');
