package com.course.servicemesh.books.courseservicemeshbooks.services;

import com.course.servicemesh.books.courseservicemeshbooks.models.Book;
import org.springframework.stereotype.Component;
import java.util.Collection;
import java.util.HashMap;

@Component
public class BookService {
    private final HashMap<Integer, Book> books;

    public BookService() {
        books = new HashMap<Integer, Book>();
        books.put(1, new Book(1).withTitle("Service MESH: Course Introduction").withPages(326).withAuthorId(1));
        books.put(2, new Book(2).withTitle("The Loosening Skin").withPages(132).withAuthorId(1));
        books.put(3, new Book(3).withTitle("Ninefox Gambit").withPages(384).withAuthorId(2));
        books.put(4, new Book(4).withTitle("Raven Stratagem").withPages(400).withAuthorId(3));
        books.put(5, new Book(5).withTitle("Revenant Gun").withPages(466).withAuthorId(3));
    }

    public Collection<Book> getBooks() {
        return this.books.values();
    }

    public Book findById(int id) {
        return this.books.get(id);
    }
}
