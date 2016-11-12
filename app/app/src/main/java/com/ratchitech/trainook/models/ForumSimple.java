package com.ratchitech.trainook.models;

public class ForumSimple {

    private String name;
    private String category;
    private Double valoration;

    public ForumSimple(String name, String category, Double valoration) {
        this.name = name;
        this.category = category;
        this.valoration = valoration;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Double getValoration() {
        return valoration;
    }

    public void setValoration(Double valoration) {
        this.valoration = valoration;
    }
}
