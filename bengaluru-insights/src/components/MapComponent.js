"use client";

import { MapContainer, TileLayer, CircleMarker, Tooltip } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import { useRouter } from 'next/navigation';

export default function MapComponent({ areas }) {
  const router = useRouter();
  
  // Center roughly on Bangalore
  const center = [12.9716, 77.5946];
  
  const getBudgetColor = (price) => {
    if (price >= 8000) return '#d85c5c';
    if (price >= 5000) return '#e8b339';
    return '#5cd882';
  };

  return (
    <MapContainer 
      center={center} 
      zoom={11} 
      style={{ height: '100%', width: '100%', zIndex: 0 }}
      zoomControl={false}
    >
      <TileLayer
        url="https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png"
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; CARTO'
      />
      
      {areas.map((area) => (
        <CircleMarker
          key={area.area_id}
          center={[area.latitude, area.longitude]}
          radius={7}
          fillColor={getBudgetColor(area.current_price)}
          fillOpacity={0.9}
          color="#ffffff"
          weight={2}
          eventHandlers={{
            click: () => {
              router.push(`/area/${area.area_id}`);
            },
          }}
        >
          <Tooltip direction="top" offset={[0, -5]} opacity={1}>
            <div style={{ color: '#002743', fontWeight: 'bold', fontFamily: 'sans-serif' }}>
               {area.name} <br/>
               <span style={{ fontWeight: 'normal' }}>₹{area.current_price} / sqft</span>
            </div>
          </Tooltip>
        </CircleMarker>
      ))}
    </MapContainer>
  );
}
