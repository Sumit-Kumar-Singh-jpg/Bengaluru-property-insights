package com.bengaluru.lands.controller;

import com.bengaluru.lands.entity.*;
import com.bengaluru.lands.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class AreaController {

    @Autowired 
    private AreaService service;

    @GetMapping("/areas")
    public List<Area> getAll() {
        return service.getAllAreas();
    }

    @GetMapping("/areas/{id}")
    public Area getById(@PathVariable Integer id) {
        return service.getAreaById(id);
    }

    @GetMapping("/areas/zone/{zone}")
    public List<Area> getByZone(@PathVariable String zone) {
        return service.getAreasByZone(zone);
    }

    @GetMapping("/areas/search")
    public List<Area> search(@RequestParam String q) {
        return service.searchAreas(q);
    }

    @GetMapping("/areas/{id}/history")
    public List<PriceHistory> getHistory(@PathVariable Integer id) {
        return service.getPriceHistory(id);
    }

    @GetMapping("/areas/{id}/roi")
    public String getRoi(@PathVariable Integer id) {
        return "ROI: " + service.calculateROI(id) + "%";
    }
    @GetMapping("/demo/threads")
public String demoThreads() {
    service.demoMultithreading();
    return "Check the terminal console for thread output. Two threads should have printed their names.";
}
}