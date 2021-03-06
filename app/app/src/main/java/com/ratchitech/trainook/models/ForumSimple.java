package com.ratchitech.trainook.models;

public class ForumSimple {

    private Integer id;
    private String name;
    private String category;
    private Double valoration;

    public ForumSimple(Integer id, String name, String category, Double valoration) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.valoration = valoration;
    }

    public Integer getId() {
        return id;
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
