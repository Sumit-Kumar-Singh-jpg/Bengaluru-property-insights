const fs = require('fs');

let sql = fs.readFileSync('updated_bengaluru_lands_data.sql', 'utf8');

const regex = /JOIN \(VALUES\s*([\s\S]*?)\)\s*AS\s*v\(name,\s*current_price,\s*growth_1yr\)/i;
const match = sql.match(regex);

if (match) {
    const valuesContent = match[1];
    // Split by lines and parse
    const rows = valuesContent.match(/\(([^)]+)\)/g);
    
    let unionQuery = rows.map((row, index) => {
        let clean = row.replace(/^\(|\)$/g, ''); // -> '1st Block Rajajinagar', 25200, 24.00
        if (index === 0) {
            // First row needs column aliases
            let parts = clean.split(',').map(s => s.trim());
            // Need to handle quotes carefully, but they are single quotes
            let name = parts.slice(0, parts.length - 2).join(',');
            let current_price = parts[parts.length - 2];
            let growth_1yr = parts[parts.length - 1];
            return "  SELECT " + name + " AS name, " + current_price + " AS current_price, " + growth_1yr + " AS growth_1yr";
        } else {
            return "  SELECT " + clean;
        }
    }).join(" UNION ALL\n");

    const newSql = sql.replace(regex, "JOIN (\n" + unionQuery + "\n) AS v");
    fs.writeFileSync('updated_bengaluru_lands_data.sql', newSql, 'utf8');
    console.log("SQL file fixed successfully.");
} else {
    console.log("Could not find the VALUES block to fix.");
}
