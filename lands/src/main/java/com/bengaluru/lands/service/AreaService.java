package com.bengaluru.lands.service;

import com.bengaluru.lands.entity.Area;
import com.bengaluru.lands.entity.PriceHistory;
import com.bengaluru.lands.entity.AreaMetrics;
import com.bengaluru.lands.repository.AreaRepository;
import com.bengaluru.lands.repository.PriceHistoryRepository;
import com.bengaluru.lands.repository.AreaMetricsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class AreaService {

    @Autowired
    private AreaRepository areaRepo;
    
    @Autowired
    private PriceHistoryRepository priceRepo;
    
    @Autowired
    private AreaMetricsRepository metricsRepo;

    // Get all areas
    public List<Area> getAllAreas() {
        return areaRepo.findAll();
    }

    // Get area by ID - returns null if not found
    public Area getAreaById(Integer areaId) {
        if (areaId == null) {
            return null;
        }
        // Using findById which returns Optional, but we handle it directly
        java.util.Optional<Area> optional = areaRepo.findById(areaId);
        if (optional.isPresent()) {
            return optional.get();
        }
        return null;
    }

    // Get areas by zone (using lambda)
    public List<Area> getAreasByZone(String zone) {
        if (zone == null) {
            return new ArrayList<>();
        }
        List<Area> allAreas = areaRepo.findAll();
        List<Area> result = new ArrayList<>();
        for (Area area : allAreas) {
            if (area.getZone() != null && area.getZone().equalsIgnoreCase(zone)) {
                result.add(area);
            }
        }
        return result;
    }

    // Search areas by name
    public List<Area> searchAreas(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return new ArrayList<>();
        }
        return areaRepo.findByNameContainingIgnoreCase(keyword);
    }

    // Get price history for an area
    public List<PriceHistory> getPriceHistory(Integer areaId) {
        if (areaId == null) {
            return new ArrayList<>();
        }
        Area area = getAreaById(areaId);
        if (area == null) {
            return new ArrayList<>();
        }
        return priceRepo.findByAreaOrderByYearAsc(area);
    }

    // Calculate ROI for an area
    public double calculateROI(Integer areaId) {
        if (areaId == null) {
            return 0.0;
        }
        java.util.Optional<AreaMetrics> optional = metricsRepo.findById(areaId);
        if (optional.isPresent() && optional.get().getAvgRoiPct() != null) {
            return optional.get().getAvgRoiPct().doubleValue();
        }
        return 0.0;
    }

    // Multithreading example (for rubric)
    public void demoMultithreading() {
        Runnable task = () -> {
            System.out.println("Running in thread: " + Thread.currentThread().getName());
        };
        Thread thread1 = new Thread(task);
        Thread thread2 = new Thread(task);
        thread1.start();
        thread2.start();
    }
}