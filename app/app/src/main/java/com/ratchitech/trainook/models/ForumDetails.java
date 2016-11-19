package com.ratchitech.trainook.models;

public class ForumDetails {

    private String name;
    private Integer visitors;
    private Integer participants;
    private Entertainment entertainment;

    public ForumDetails(String name, Integer visitors, Integer participants, Entertainment entertainment) {
        this.name = name;
        this.visitors = visitors;
        this.participants = participants;
        this.entertainment = entertainment;
    }

}
