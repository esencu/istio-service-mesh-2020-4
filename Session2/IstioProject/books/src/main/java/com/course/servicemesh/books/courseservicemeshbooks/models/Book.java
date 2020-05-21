package com.course.servicemesh.books.courseservicemeshbooks.models;

public class Book {
    private int id;
    private String title;
    private int pages;
    private int authorId;

    public Book(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int autorId) {
        this.authorId = autorId;
    }

    public Book withTitle(String title) {
        this.setTitle(title);
        return this;
    }

    public Book withAuthorId(int author) {
        this.setAuthorId(author);
        return this;
    }

    public Book withPages(int pages) {
        this.setPages(pages);
        return this;
    }
}
