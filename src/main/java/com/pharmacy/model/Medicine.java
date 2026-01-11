package com.pharmacy.model;

import java.sql.Timestamp;

public class Medicine {
    private int id;
    private String name;
    private String ingredient;
    private String efficacy;
    private String usage;
    private String precautions;
    private Timestamp createdAt;

    public Medicine() {}

    public Medicine(String name, String ingredient, String efficacy, String usage, String precautions) {
        this.name = name;
        this.ingredient = ingredient;
        this.efficacy = efficacy;
        this.usage = usage;
        this.precautions = precautions;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIngredient() {
        return ingredient;
    }

    public void setIngredient(String ingredient) {
        this.ingredient = ingredient;
    }

    public String getEfficacy() {
        return efficacy;
    }

    public void setEfficacy(String efficacy) {
        this.efficacy = efficacy;
    }

    public String getUsage() {
        return usage;
    }

    public void setUsage(String usage) {
        this.usage = usage;
    }

    public String getPrecautions() {
        return precautions;
    }

    public void setPrecautions(String precautions) {
        this.precautions = precautions;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
