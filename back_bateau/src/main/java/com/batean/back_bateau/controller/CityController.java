package com.batean.back_bateau.controller;

import com.batean.back_bateau.model.City;
import com.batean.back_bateau.services.CityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/city")
public class CityController {
    @Autowired
    private CityService cityService;

    @GetMapping("/getAll")
    public List<City> getAll() {
        return cityService.getAll();
    }
}
