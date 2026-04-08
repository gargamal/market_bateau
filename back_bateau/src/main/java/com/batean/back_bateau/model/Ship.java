package com.batean.back_bateau.model;

import java.math.BigDecimal;

public class Ship {
    private String name;
    private int power;
    private int nbHourOfAutonomy;
    private int nbPeopleMax;
    private String marketPlace;
    private BigDecimal price;

    public Ship(String name, int power, int nbHourOfAutonomy, int nbPeopleMax, String marketPlace, BigDecimal price) {
        this.name = name;
        this.power = power;
        this.nbHourOfAutonomy = nbHourOfAutonomy;
        this.nbPeopleMax = nbPeopleMax;
        this.marketPlace = marketPlace;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getPower() {
        return power;
    }

    public void setPower(int power) {
        this.power = power;
    }

    public int getNbHourOfAutonomy() {
        return nbHourOfAutonomy;
    }

    public void setNbHourOfAutonomy(int nbHourOfAutonomy) {
        this.nbHourOfAutonomy = nbHourOfAutonomy;
    }

    public int getNbPeopleMax() {
        return nbPeopleMax;
    }

    public void setNbPeopleMax(int nbPeopleMax) {
        this.nbPeopleMax = nbPeopleMax;
    }

    public String getMarketPlace() {
        return marketPlace;
    }

    public void setMarketPlace(String marketPlace) {
        this.marketPlace = marketPlace;
    }
}
