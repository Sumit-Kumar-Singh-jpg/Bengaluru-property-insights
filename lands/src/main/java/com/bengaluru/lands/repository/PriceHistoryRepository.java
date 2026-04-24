package com.bengaluru.lands.repository;

import com.bengaluru.lands.entity.PriceHistory;
import com.bengaluru.lands.entity.Area;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PriceHistoryRepository extends JpaRepository<PriceHistory, Integer> {
    List<PriceHistory> findByAreaOrderByYearAsc(Area area);
}