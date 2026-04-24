package com.bengaluru.lands.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.Year;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "price_history")
public class PriceHistory {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer historyId;
    
    @ManyToOne
    @JoinColumn(name = "area_id")
    @JsonIgnore 
    private Area area;
    
    private Year year;
    private BigDecimal avgPriceSqft;
    private Integer numTransactions;
    
    // Getters and setters
    public Integer getHistoryId() { return historyId; }
    public void setHistoryId(Integer historyId) { this.historyId = historyId; }
    public Area getArea() { return area; }
    public void setArea(Area area) { this.area = area; }
    public Year getYear() { return year; }
    public void setYear(Year year) { this.year = year; }
    public BigDecimal getAvgPriceSqft() { return avgPriceSqft; }
    public void setAvgPriceSqft(BigDecimal avgPriceSqft) { this.avgPriceSqft = avgPriceSqft; }
    public Integer getNumTransactions() { return numTransactions; }
    public void setNumTransactions(Integer numTransactions) { this.numTransactions = numTransactions; }
}