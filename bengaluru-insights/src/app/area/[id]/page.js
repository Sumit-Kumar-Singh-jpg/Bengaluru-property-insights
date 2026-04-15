"use client";

import { useEffect, useState, use } from "react";
import Link from 'next/link';
import { LineChart, Line, XAxis, YAxis, Tooltip, ResponsiveContainer } from 'recharts';

export default function AreaDetail({ params }) {
  const unwrappedParams = use(params);
  const id = unwrappedParams.id;
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);
  
  const [investment, setInvestment] = useState(5000000); // 50L Default
  const [years, setYears] = useState(5);

  useEffect(() => {
    fetch(`/api/areas/${id}`)
      .then(res => {
        if (!res.ok) throw new Error("API failed");
        return res.json();
      })
      .then(d => {
        setData(d);
        setLoading(false);
      })
      .catch(err => {
        console.error(err);
        setError(true);
        setLoading(false);
      });
  }, [id]);

  if (loading) return <div className="max-w-4xl mx-auto px-6 py-12 text-center text-on-surface-variant font-medium">Loading area details...</div>;
  if (error || !data || data.error) return <div className="max-w-4xl mx-auto px-6 py-12 text-center text-error font-bold">Failed to load area data or Area not found. Ensure MySQL is running.</div>;

  const estimatedFutureValue = Math.round(investment * Math.pow(1 + (data.avg_roi_pct / 100), years));

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
        <div className="mb-10">
          <h1 className="text-4xl md:text-5xl font-extrabold text-primary mb-2 font-headline">{data.name}</h1>
          <div className="text-on-surface-variant font-medium text-lg flex items-center gap-2">
            <span className="material-symbols-outlined text-sm">location_on</span>
            {data.zone} Bangalore &middot; ₹{formatCurrency(data.current_price)} per sq ft
          </div>
        </div>

        {/* Top 3 Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
          <div className="bg-surface-container-lowest border border-outline-variant/30 rounded-3xl p-6 shadow-sm">
            <div className="text-on-surface-variant text-sm font-bold uppercase tracking-widest font-label mb-2">1 Year Growth</div>
            <div className={`text-4xl font-extrabold ${data.growth_1yr >= 0 ? 'text-secondary' : 'text-error'}`}>
              {data.growth_1yr > 0 ? '+' : ''}{data.growth_1yr}%
            </div>
          </div>
          <div className="bg-surface-container-lowest border border-outline-variant/30 rounded-3xl p-6 shadow-sm">
            <div className="text-on-surface-variant text-sm font-bold uppercase tracking-widest font-label mb-2">3 Year Growth</div>
            <div className={`text-4xl font-extrabold ${data.growth_3yr >= 0 ? 'text-secondary' : 'text-error'}`}>
              {data.growth_3yr > 0 ? '+' : ''}{data.growth_3yr}%
            </div>
          </div>
          <div className="bg-primary-container text-on-primary-container rounded-3xl p-6 shadow-sm">
            <div className="text-primary-fixed-dim text-sm font-bold uppercase tracking-widest font-label mb-2">Est. Annual ROI</div>
            <div className="text-4xl font-extrabold text-white">
              {data.avg_roi_pct}%
            </div>
          </div>
        </div>

        {/* Chart Section */}
        <div className="bg-surface-container-lowest border border-outline-variant/30 rounded-3xl p-8 mb-12 shadow-sm">
          <div className="text-on-surface-variant text-sm font-bold uppercase tracking-widest font-label mb-6">
            Price History (₹ / sqft)
          </div>
          <div style={{ height: '350px', width: '100%' }}>
            <ResponsiveContainer width="100%" height="100%">
              <LineChart data={data.history} margin={{ top: 5, right: 10, left: 10, bottom: 5 }}>
                <XAxis dataKey="year" stroke="var(--color-outline)" tickLine={false} axisLine={false} />
                <YAxis hide domain={['dataMin', 'dataMax']} />
                <Tooltip 
                  contentStyle={{ backgroundColor: 'var(--color-surface)', border: '1px solid var(--color-outline-variant)', borderRadius: '0.75rem', color: 'var(--color-on-surface)' }}
                  itemStyle={{ color: 'var(--color-primary)', fontWeight: 'bold' }}
                />
                <Line type="monotone" dataKey="price" stroke="var(--color-primary)" strokeWidth={4} dot={{ r: 5, fill: 'var(--color-primary-container)' }} />
              </LineChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* ROI Calculator */}
        <div className="bg-secondary-container text-on-secondary-container rounded-3xl p-8 shadow-sm">
          <div className="font-bold text-lg mb-6 flex items-center gap-2">
            <span className="material-symbols-outlined">calculate</span>
            Investment Calculator
          </div>
          <div className="flex flex-col md:flex-row justify-between items-center gap-6">
            <div className="flex flex-wrap gap-4 w-full md:w-auto">
              <div className="flex items-center bg-surface-container-lowest border border-outline-variant/30 rounded-xl px-4 flex-1">
                <span className="text-outline font-bold">₹</span>
                <input 
                  type="number" 
                  value={investment} 
                  onChange={e => setInvestment(Number(e.target.value))}
                  className="bg-transparent border-none text-on-surface font-bold py-3 px-2 outline-none w-full min-w-[120px]"
                />
              </div>
              
              <div className="flex items-center bg-surface-container-lowest border border-outline-variant/30 rounded-xl px-4 w-32">
                <input 
                  type="number" 
                  value={years} 
                  onChange={e => setYears(Number(e.target.value))}
                  className="bg-transparent border-none text-on-surface font-bold py-3 px-2 outline-none w-full"
                />
                <span className="text-outline font-bold text-sm uppercase">Yrs</span>
              </div>
            </div>
            
            <div className="text-2xl font-extrabold text-on-secondary-fixed-variant bg-secondary-fixed px-6 py-3 rounded-2xl w-full md:w-auto text-center">
              ₹ {formatCurrency(estimatedFutureValue)} ext. value
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}
