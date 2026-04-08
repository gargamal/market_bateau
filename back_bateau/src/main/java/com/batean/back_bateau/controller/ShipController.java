package com.batean.back_bateau.controller;

import com.batean.back_bateau.model.Ship;
import com.batean.back_bateau.services.ShipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ShipController {

    @Autowired
    private ShipService shipService;

    @GetMapping("/getAll")
    public List<Ship> getAll() {
        // Simulation d'une base de données avec une liste statique
        return shipService.getAll();
    }

    @GetMapping("/get")
    public List<Ship> get(@RequestParam("page") int page, @RequestParam("limit") int limit) {
        // Simulation d'une base de données avec une liste statique
        return shipService.get(page, limit);
    }
}
