package com.course.servicemesh.authors.courseservicemeshauthors.controlles;

import com.course.servicemesh.authors.courseservicemeshauthors.models.Author;
import com.course.servicemesh.authors.courseservicemeshauthors.services.AuthorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collection;

@RestController
@RequestMapping("api/v1/authors")
public class AuthorController {
    private final static Logger logger = LoggerFactory.getLogger(AuthorController.class);
    private final AuthorService authorService;
    public AuthorController(AuthorService authorService) {
        this.authorService = authorService;
    }

    @GetMapping()
    public Collection<Author> getAuthors() {
        logger.info("Get authors");
        return this.authorService.getAuthors();
    }

    @GetMapping("/{id}")
    public Author getById(@PathVariable int id) {
        logger.info(String.format("Find authors by %s", id));
        return this.authorService.findById(id);
    }
}
