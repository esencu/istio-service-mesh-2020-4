package com.course.servicemesh.authors.courseservicemeshauthors.models;

public class Author {
    private int id;
    private String firstName;
    private String lastName;
    private int version = 2;

    public Author(int id) {
        this.id = id;
    }

    public int getVersion() {
        return version;
    }

    public int getId() {
        return id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Author withFirstName(String firstName) {
        this.setFirstName(firstName);
        return this;
    }

    public Author withLastName(String lastName) {
        this.setLastName(lastName);
        return this;
    }
}
