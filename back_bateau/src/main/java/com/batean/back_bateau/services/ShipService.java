package com.batean.back_bateau.services;

import com.batean.back_bateau.model.Ship;
import com.batean.back_bateau.model.ShipFilters;
import com.batean.back_bateau.repositories.ShipRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

        int pageIndex = page - 1;
        pageIndex = Math.max(pageIndex, 0);

        int startIndex = pageIndex * limit;
        int length = filteredShips.size();

        startIndex = startIndex >= length ? length - limit : startIndex;
        int endIndex = startIndex + limit;
        endIndex = startIndex >= length ? length - 1 : endIndex;

        return filteredShips.subList(startIndex, endIndex);
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
