/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package javajedik.main.model;

public class CollectionData {
    private int collectionId;
    private String collectionName;
    private String language;
    private int answerId;
    private String type;
    private String name;
    private int nthAnswer;

    public CollectionData(int collectionId, String collectionName, String language, int answerId, String type, String name, int nthAnswer) {
        this.collectionId = collectionId;
        this.collectionName = collectionName;
        this.language = language;
        this.answerId = answerId;
        this.type = type;
        this.name = name;
        this.nthAnswer = nthAnswer;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public int getAnswerId() {
        return answerId;
    }

    public int getCollectionId() {
        return collectionId;
    }

    public void setCollectionId(int collectionId) {
        this.collectionId = collectionId;
    }

    public String getCollectionName() {
        return collectionName;
    }

    public void setCollectionName(String collectionName) {
        this.collectionName = collectionName;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getNthAnswer() {
        return nthAnswer;
    }

    public void setNthAnswer(int nthAnswer) {
        this.nthAnswer = nthAnswer;
    }
}
