package com.batean.back_bateau.model;

public class ShipFilters {
    private Integer power;
    private String marketPlace;
    private Integer nbPeopleMax;

    public ShipFilters(Integer power, String marketPlace, Integer nbPeopleMax) {
        this.power = power;
        this.marketPlace = marketPlace;
        this.nbPeopleMax = nbPeopleMax;
    }

    public int getPower() {
        return power;
    }

    public void setPower(int power) {
        this.power = power;
    }

    public String getMarketPlace() {
        return marketPlace;
    }

    public void setMarketPlace(String marketPlace) {
        this.marketPlace = marketPlace;
    }

    public int getNbPeopleMax() {
        return nbPeopleMax;
    }

    public void setNbPeopleMax(int nbPeopleMax) {
        this.nbPeopleMax = nbPeopleMax;
    }

    public boolean isNull() {
        return !hasPower() && !hasMarketPlace() && !hasNbPeopleMax();
    }

    public boolean hasPower() {
        return !(power == null || power == 0);
    }

    public boolean hasMarketPlace() {
        return !(marketPlace == null || marketPlace.trim().isEmpty());
    }

    public boolean hasNbPeopleMax() {
        return!(nbPeopleMax == null || nbPeopleMax == 0);
    }
}
