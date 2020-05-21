package com.course.servicemesh.books.courseservicemeshbooks.controlles;

import com.course.servicemesh.books.courseservicemeshbooks.models.Book;
import com.course.servicemesh.books.courseservicemeshbooks.services.BookService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Collection;

@RestController
@RequestMapping("api/v1/books")
public class BookController {

    private final static Logger logger = LoggerFactory.getLogger(BookController.class);
    private final BookService bookService;
    public BookController(BookService bookService) {
        this.bookService = bookService;
    }


    @GetMapping()
    public Collection<Book> getBooks() {
        logger.info("Get book list");
        return this.bookService.getBooks();
    }

    @GetMapping("/{id}")
    public Book getById(@PathVariable int id) {
        logger.info(String.format("Find book by id %s", id));
        return this.bookService.findById(id);
    }
}
