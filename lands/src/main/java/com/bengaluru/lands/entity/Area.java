package com.bengaluru.lands.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "areas")
public class Area {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "area_id")
    private Integer areaId;
    
    private String name;
    private String zone;
    private Double latitude;
    private Double longitude;
    
    @OneToMany(mappedBy = "area")
    private List<PriceHistory> priceHistories;
    
    @OneToOne(mappedBy = "area")
    private AreaMetrics metrics;
    
    // Getters and setters (right-click → Source Action → Generate Getters and Setters)
    public Integer getAreaId() { return areaId; }
    public void setAreaId(Integer areaId) { this.areaId = areaId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getZone() { return zone; }
    public void setZone(String zone) { this.zone = zone; }
    public Double getLatitude() { return latitude; }
    public void setLatitude(Double latitude) { this.latitude = latitude; }
    public Double getLongitude() { return longitude; }
    public void setLongitude(Double longitude) { this.longitude = longitude; }
    public List<PriceHistory> getPriceHistories() { return priceHistories; }
    public void setPriceHistories(List<PriceHistory> priceHistories) { this.priceHistories = priceHistories; }
    public AreaMetrics getMetrics() { return metrics; }
    public void setMetrics(AreaMetrics metrics) { this.metrics = metrics; }
}