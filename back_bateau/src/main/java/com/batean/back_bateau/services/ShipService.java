package com.batean.back_bateau.services;

import com.batean.back_bateau.model.Ship;
import com.batean.back_bateau.model.ShipFilters;
import com.batean.back_bateau.repositories.ShipRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Stream;

@Service
public class ShipService {
    @Autowired
    private ShipRepository shipRepository;

    public List<Ship> getAll() {
        return shipRepository.getAllShips();
    }

    public List<Ship> get(int page, int limit, ShipFilters shipFilters) {
        List<Ship> filteredShips = buildWithFilter(shipFilters);

        int pageIndex = Math.max(page - 1, 0);

        int startIndex = pageIndex * limit;
        int length = filteredShips.size();

        startIndex = startIndex >= length ? Math.max(length - limit, 0) : startIndex;
        int endIndex = Math.min(startIndex + limit, length - 1);

        if (length == 0 || endIndex == 0 || startIndex == endIndex) {
            System.out.printf("shipRepository.get-return-empty -- %s\n", LocalDateTime.now());
            return new ArrayList<>();
        } else {
            System.out.printf("shipRepository.get-return-(%d-%d) -- %s\n", startIndex, endIndex, LocalDateTime.now());
            return filteredShips.subList(startIndex, endIndex);
        }
    }

    private List<Ship> buildWithFilter(ShipFilters shipFilters) {
        List<Ship> allShips = shipRepository.getAllShips();
        if (shipFilters.isNull()) return allShips;

        Stream<Ship> shipStream = allShips.stream();
        if (shipFilters.hasNbPeopleMax()) {
            shipStream = shipStream.filter(elt -> elt.getNbPeopleMax() <= shipFilters.getNbPeopleMax());
        }
        if (shipFilters.hasPower()) {
            shipStream = shipStream.filter(elt -> elt.getPower() <= shipFilters.getPower());
        }
        if (shipFilters.hasMarketPlace()) {
            shipStream = shipStream.filter(elt -> Objects.equals(elt.getMarketPlace(), shipFilters.getMarketPlace()));
        }
        return shipStream.toList();
    }
}
