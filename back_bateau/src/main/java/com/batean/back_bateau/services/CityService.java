package com.batean.back_bateau.services;

import com.batean.back_bateau.model.Ship;
import com.batean.back_bateau.repositories.ShipRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CityService {
    @Autowired
    private ShipRepository shipRepository;

    public List<String> getAll(){
        return shipRepository.getAllShips().stream().map(Ship::getMarketPlace).distinct().collect(Collectors.toList());
    }
}
