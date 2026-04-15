"use client";

import { useEffect, useState } from "react";
import Link from 'next/link';
import dynamic from 'next/dynamic';

const DynamicMap = dynamic(() => import('@/components/MapComponent'), {
  ssr: false,
  loading: () => <div className="flex items-center justify-center w-full h-full bg-surface-container-low text-primary">Loading Cartography...</div>
});

export default function Home() {
  const [areas, setAreas] = useState([]);
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);
  const [selectedIds, setSelectedIds] = useState([]);

  const toggleSelection = (id) => {
    if (selectedIds.includes(id)) {
      setSelectedIds(selectedIds.filter(selId => selId !== id));
    } else {
      if (selectedIds.length < 3) setSelectedIds([...selectedIds, id]);
    }
  };

  useEffect(() => {
    fetch("/api/areas")
      .then((res) => res.json())
      .then((data) => {
        if (Array.isArray(data)) setAreas(data);
        setLoading(false);
      })
      .catch((err) => {
        console.error("Failed to fetch areas:", err);
        setLoading(false);
      });
  }, []);

  const filteredAreas = areas.filter((a) =>
    a.name.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="bg-background text-on-surface min-h-screen pb-24 md:pb-12">
      {/* TopAppBar */}
      <header className="bg-surface/80 backdrop-blur-xl sticky w-full top-0 z-50 shadow-sm border-b border-outline-variant/30">
        <div className="flex justify-between items-center px-6 py-4 w-full max-w-screen-2xl mx-auto">
          <div className="flex items-center gap-3">
            <span className="material-symbols-outlined text-primary" data-icon="map">map</span>
            <h1 className="text-xl font-bold tracking-tight text-primary font-headline">BENGALURU INSIGHT</h1>
          </div>
          <nav className="hidden md:flex gap-8 items-center">
            <Link className="text-primary font-bold text-sm tracking-wide uppercase font-label" href="/">Explore</Link>
            <Link className="text-on-surface-variant hover:bg-surface-container-high transition-all text-sm tracking-wide uppercase font-label px-3 py-1 rounded-lg" href="/compare">Compare</Link>
          </nav>
        </div>
      </header>

      <main>
        {/* Hero Section: Interactive Map */}
        <section className="relative w-full h-[530px] md:h-[618px] bg-surface-container-low overflow-hidden">
          <div className="absolute inset-0 z-0">
            {/* The Dynamic Leaflet Map Component takes over this wrapper */}
            {areas.length > 0 && <DynamicMap areas={areas} />}
          </div>

          {/* Urban Editorial Overlay (Bottom Left) */}
          <div className="absolute bottom-12 left-12 z-20 max-w-md hidden md:block pointer-events-none">
            <h2 className="text-4xl font-extrabold text-primary leading-tight drop-shadow-md">The Future of Bengaluru Land Is Here.</h2>
            <p className="mt-4 text-on-surface-variant font-medium leading-relaxed bg-surface/50 backdrop-blur-md p-2 rounded">
              Navigate institutional-grade land acquisition data with precision and clarity.
            </p>
          </div>
        </section>

        {/* Search & Quick Navigation Container */}
        <div className="max-w-screen-xl mx-auto px-6 -mt-10 relative z-30">
          
          {/* Search Bar */}
          <div className="bg-surface-container-lowest shadow-xl rounded-full p-2 flex items-center gap-4 transition-all focus-within:ring-2 focus-within:ring-primary/20">
            <div className="pl-6 flex items-center text-primary">
              <span className="material-symbols-outlined" data-icon="search">search</span>
            </div>
            <input 
              className="w-full bg-transparent border-none focus:ring-0 text-on-surface placeholder:text-outline py-4 text-lg font-medium outline-none" 
              placeholder="Search by Zone, Locality, or Plot ID..." 
              type="text"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
            />
            <button className="bg-primary hover:bg-primary-container text-on-primary px-8 py-4 rounded-full font-bold transition-all flex items-center gap-2 group">
              <span>Analyze</span>
            </button>
          </div>

          {/* Grid Layout for Content */}
          <div className="mt-12 grid grid-cols-1 lg:grid-cols-12 gap-8">
            
            {/* Vertical Navigation Menu */}
            <aside className="lg:col-span-4 flex flex-col gap-4">
              <h4 className="text-xs font-bold text-outline-variant uppercase tracking-[0.2em] px-4 font-label">Strategic Tools</h4>
              <Link 
                className="flex items-center justify-between p-6 rounded-2xl bg-surface-container-lowest hover:bg-primary-fixed transition-all group shadow-sm border border-outline-variant/10" 
                href={selectedIds.length > 0 ? `/compare?ids=${selectedIds.join(',')}` : "#"}
                onClick={(e) => {
                  if (selectedIds.length === 0) {
                    e.preventDefault();
                    alert("Please select up to 3 areas using the checkboxes on the right first!");
                  }
                }}
              >
                <div className="flex items-center gap-5">
                  <div className="p-3 bg-primary-fixed-dim rounded-xl text-primary group-hover:scale-110 transition-transform">
                    <span className="material-symbols-outlined" data-icon="compare_arrows">compare_arrows</span>
                  </div>
                  <span className="text-lg font-bold text-primary">Compare Lands</span>
                </div>
                <span className="material-symbols-outlined text-outline" data-icon="chevron_right">chevron_right</span>
              </Link>
            </aside>

            {/* Featured Insights list mapping areas */}
            <div className="lg:col-span-8 flex flex-col gap-4">
              <h4 className="text-xs font-bold text-outline-variant uppercase tracking-[0.2em] font-label mb-2">Select to view Details</h4>
              
              {loading ? (
                <div className="p-6 bg-surface-container-lowest rounded-2xl">Loading Area Database...</div>
              ) : (
                <div className="flex flex-col gap-4 max-h-[800px] overflow-y-auto pr-2">
                  {filteredAreas.slice(0, 15).map(area => (
                    <div key={area.area_id} className="relative bg-surface-container-lowest p-6 rounded-3xl shadow-sm hover:shadow-md transition-shadow border border-outline-variant/20">
                      
                      {/* Checkbox Overlay (z-20) */}
                      <div className="absolute top-6 left-6 z-20 flex items-center justify-center">
                        <input 
                          type="checkbox" 
                          checked={selectedIds.includes(area.area_id)}
                          onChange={() => toggleSelection(area.area_id)}
                          className="w-5 h-5 rounded cursor-pointer accent-primary"
                        />
                      </div>

                      {/* Main Clickable Card Area (z-10) */}
                      <Link href={`/area/${area.area_id}`} className="block pl-10 pr-2 relative z-10 w-full h-full">
                        <div className="flex justify-between items-start">
                          <div>
                            <span className="text-secondary-fixed-variant text-xs font-bold uppercase tracking-widest font-label bg-secondary-container px-2 py-1 rounded-lg">
                              {area.zone} Bangalore
                            </span>
                            <h3 className="text-2xl font-bold text-primary mt-2">{area.name}</h3>
                          </div>
                          <div className="text-right">
                            <h4 className="text-xl font-extrabold text-primary">₹{area.current_price.toLocaleString('en-IN')}</h4>
                            <p className={`text-sm mt-1 font-bold ${area.growth_1yr > 0 ? 'text-secondary' : 'text-error'}`}>
                              {area.growth_1yr > 0 ? '+' : ''}{area.growth_1yr}% (1yr)
                            </p>
                          </div>
                        </div>
                      </Link>
                    </div>
                  ))}
                  {filteredAreas.length > 15 && (
                    <div className="text-center p-4 text-on-surface-variant font-medium text-sm">
                      + {filteredAreas.length - 15} more areas found. Try narrowing your search!
                    </div>
                  )}
                </div>
              )}
            </div>

          </div>
        </div>
      </main>

      {/* Floating Action Bar */}
      {selectedIds.length > 0 && (
        <div className="fixed bottom-10 right-10 bg-surface-container-highest border border-outline-variant rounded-2xl p-4 flex items-center justify-between gap-6 shadow-2xl z-50">
          <span className="text-on-surface-variant font-bold text-sm tracking-wide">
            <span className="text-primary font-black text-lg">{selectedIds.length}</span> / 3 Areas Selected
          </span>
          <Link href={`/compare?ids=${selectedIds.join(',')}`} className="bg-primary text-on-primary px-6 py-2 rounded-xl font-bold hover:bg-primary-container transition-colors shadow-sm">
            Compare Selected &rarr;
          </Link>
        </div>
      )}

    </div>
  );
}
