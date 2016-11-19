package com.ratchitech.trainook.models;

public class Entertainment {

    private String description;
    //TODO: enum
    private String category;
    private Double score;

    public Entertainment(String description, String category, Double score) {
        this.description = description;
        this.category = category;
        this.score = score;
    }

}
