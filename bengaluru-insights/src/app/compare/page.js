"use client";

import { useEffect, useState, Suspense } from "react";
import Link from 'next/link';
import { useSearchParams } from 'next/navigation';
import { LineChart, Line, XAxis, YAxis, Tooltip, ResponsiveContainer, Legend } from 'recharts';

function CompareContent() {
  const searchParams = useSearchParams();
  const ids = searchParams.get('ids');
  
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  useEffect(() => {
    if (!ids) return;

    fetch(`/api/compare?ids=${ids}`)
      .then(res => {
        if (!res.ok) throw new Error("API failed");
        return res.json();
      })
      .then(d => {
        if (Array.isArray(d)) {
          setData(d);
        } else {
          setError(true);
        }
        setLoading(false);
      })
      .catch(err => {
        console.error(err);
        setError(true);
        setLoading(false);
      });
  }, [ids]);

  if (!ids) return <div className="max-w-4xl mx-auto px-6 py-12 text-center text-on-surface-variant font-medium">No areas selected for comparison.</div>;
  if (loading) return <div className="max-w-4xl mx-auto px-6 py-12 text-center text-on-surface-variant font-medium">Analyzing areas...</div>;
  if (error || data.length === 0) return <div className="max-w-4xl mx-auto px-6 py-12 text-center text-error font-bold">Failed to load comparison data.</div>;

  // Process data for charts
  const years = [2018, 2019, 2020, 2021, 2022, 2023, 2024];
  const chartData = years.map(year => {
    let point = { year };
    data.forEach((area, i) => {
      const h = area.history.find(x => x.year === year);
      if (h) point[`area_${i}`] = h.price;
    });
    return point;
  });

  // Green, Blue, Red
  const colors = ['#3b6934', '#002743', '#ba1a1a'];
  const formatCurrency = (val) => new Intl.NumberFormat('en-IN').format(val);

  return (
    <div className="bg-background text-on-surface min-h-screen pb-24 md:pb-12">
      <header className="bg-surface/80 backdrop-blur-xl sticky w-full top-0 z-50 shadow-sm border-b border-outline-variant/30 px-6 py-4">
        <div className="max-w-screen-2xl mx-auto flex justify-between items-center">
          <Link href="/" className="logo text-primary font-bold text-xl flex items-center gap-2 font-headline">
            <span className="material-symbols-outlined text-primary" data-icon="map">map</span>
            BengaluruLands
          </Link>
          <Link href="/" className="text-on-surface-variant hover:text-primary transition-all text-sm font-label font-bold">&larr; BACK TO EXPLORE</Link>
        </div>
      </header>

      <main className="max-w-5xl mx-auto px-6 py-12">
        {/* Title Section */}
        <div className="mb-10 text-center">
          <h1 className="text-3xl md:text-5xl font-extrabold text-primary mb-4 font-headline">Comparing {data.length} Areas</h1>
          <div className="text-on-surface-variant font-medium text-lg flex gap-4 justify-center items-center flex-wrap">
            {data.map((a, i) => (
              <span key={a.area_id} style={{color: colors[i]}} className="font-bold flex items-center gap-1 bg-surface-container-low px-4 py-1 rounded-full shadow-sm border border-outline-variant/10">
                <span className="w-3 h-3 rounded-full" style={{backgroundColor: colors[i]}}></span>
                {a.name}
              </span>
            ))}
          </div>
        </div>

        {/* Comparison Table */}
        <div className="bg-surface-container-lowest border border-outline-variant/30 rounded-3xl p-8 mb-12 shadow-sm overflow-x-auto">
          <table className="w-full border-collapse text-left min-w-[600px]">
            <thead>
              <tr>
                <th className="p-4 text-outline font-bold uppercase tracking-widest font-label border-b border-outline-variant/30">Metric</th>
                {data.map((a, i) => (
                  <th key={a.area_id} className="p-4 font-extrabold text-xl border-b border-outline-variant/30" style={{color: colors[i]}}>
                    <Link href={`/area/${a.area_id}`} className="hover:underline">{a.name}</Link>
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              <tr className="border-b border-outline-variant/20 hover:bg-surface-container-low/50 transition-colors">
                <td className="p-4 text-on-surface-variant font-medium">Current Price</td>
                {data.map(a => <td key={a.area_id} className="p-4 font-bold text-lg">₹{formatCurrency(a.current_price)}/sqft</td>)}
              </tr>
              <tr className="border-b border-outline-variant/20 hover:bg-surface-container-low/50 transition-colors">
                <td className="p-4 text-on-surface-variant font-medium">1 Year Growth</td>
                {data.map(a => (
                  <td key={a.area_id} className={`p-4 font-bold text-lg ${a.growth_1yr >= 0 ? 'text-secondary' : 'text-error'}`}>
                    {a.growth_1yr > 0 ? '+' : ''}{a.growth_1yr}%
                  </td>
                ))}
              </tr>
              <tr className="border-b border-outline-variant/20 hover:bg-surface-container-low/50 transition-colors">
                <td className="p-4 text-on-surface-variant font-medium">3 Year Growth</td>
                {data.map(a => (
                  <td key={a.area_id} className={`p-4 font-bold text-lg ${a.growth_3yr >= 0 ? 'text-secondary' : 'text-error'}`}>
                    {a.growth_3yr > 0 ? '+' : ''}{a.growth_3yr}%
                  </td>
                ))}
              </tr>
              <tr className="border-b border-outline-variant/20 hover:bg-surface-container-low/50 transition-colors">
                <td className="p-4 text-on-surface-variant font-medium">Est. Ann. ROI</td>
                {data.map(a => <td key={a.area_id} className="p-4 font-extrabold text-primary text-xl">{a.avg_roi_pct}%</td>)}
              </tr>
              <tr className="hover:bg-surface-container-low/50 transition-colors">
                <td className="p-4 text-on-surface-variant font-medium">Zone</td>
                {data.map(a => (
                  <td key={a.area_id} className="p-4">
                    <span className="text-xs font-bold uppercase tracking-widest font-label bg-secondary-container text-on-secondary-container px-3 py-1 rounded-lg">
                      {a.zone}
                    </span>
                  </td>
                ))}
              </tr>
            </tbody>
          </table>
        </div>

        {/* Chart Section */}
        <div className="bg-surface-container-lowest border border-outline-variant/30 rounded-3xl p-8 shadow-sm">
          <div className="text-on-surface-variant text-sm font-bold uppercase tracking-widest font-label mb-6 text-center">
            Historical Trajectory Comparison (₹ per sqft)
          </div>
          <div style={{ height: '400px', width: '100%' }}>
            <ResponsiveContainer width="100%" height={400}>
              <LineChart data={chartData} margin={{ top: 5, right: 10, left: 10, bottom: 5 }}>
                <XAxis dataKey="year" stroke="var(--color-outline)" tickLine={false} axisLine={false} />
                <YAxis hide domain={['dataMin', 'dataMax']} />
                <Tooltip 
                  contentStyle={{ backgroundColor: 'var(--color-surface)', border: '1px solid var(--color-outline-variant)', borderRadius: '0.75rem', color: 'var(--color-on-surface)' }}
                  itemStyle={{ fontWeight: 'bold' }}
                />
                <Legend verticalAlign="top" height={36}/>
                {data.map((a, i) => (
                  <Line 
                    key={a.area_id} 
                    type="monotone" 
                    dataKey={`area_${i}`} 
                    name={a.name} 
                    stroke={colors[i]} 
                    strokeWidth={4} 
                    dot={{ r: 5, fill: colors[i] }} 
                  />
                ))}
              </LineChart>
            </ResponsiveContainer>
          </div>
        </div>
      </main>
    </div>
  );
}

export default function Compare() {
  return (
    <Suspense fallback={<div className="max-w-4xl mx-auto px-6 py-12 text-center text-on-surface-variant font-medium">Loading Compare...</div>}>
      <CompareContent />
    </Suspense>
  );
}
