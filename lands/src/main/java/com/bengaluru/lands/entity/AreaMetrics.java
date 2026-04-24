package com.bengaluru.lands.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "area_metrics")
public class AreaMetrics {
    @Id
    @Column(name = "area_id")
    private Integer areaId;
    
    @OneToOne
    @MapsId
    @JoinColumn(name = "area_id")
    @JsonIgnore
    private Area area;
    
    private BigDecimal currentPrice;
    private BigDecimal growth1yr;
    private BigDecimal growth3yr;
    private BigDecimal growth5yr;
    private BigDecimal avgRoiPct;
    
    // Getters and setters
    public Integer getAreaId() { return areaId; }
    public void setAreaId(Integer areaId) { this.areaId = areaId; }
    public Area getArea() { return area; }
    public void setArea(Area area) { this.area = area; }
    public BigDecimal getCurrentPrice() { return currentPrice; }
    public void setCurrentPrice(BigDecimal currentPrice) { this.currentPrice = currentPrice; }
    public BigDecimal getGrowth1yr() { return growth1yr; }
    public void setGrowth1yr(BigDecimal growth1yr) { this.growth1yr = growth1yr; }
    public BigDecimal getGrowth3yr() { return growth3yr; }
    public void setGrowth3yr(BigDecimal growth3yr) { this.growth3yr = growth3yr; }
    public BigDecimal getGrowth5yr() { return growth5yr; }
    public void setGrowth5yr(BigDecimal growth5yr) { this.growth5yr = growth5yr; }
    public BigDecimal getAvgRoiPct() { return avgRoiPct; }
    public void setAvgRoiPct(BigDecimal avgRoiPct) { this.avgRoiPct = avgRoiPct; }
}