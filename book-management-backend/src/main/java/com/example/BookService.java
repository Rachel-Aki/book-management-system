package com.example;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class BookService {
    @Autowired
    private BookRepository bookRepository;

    // CRUD methods
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    public Optional<Book> getBookById(Long id) {
        return bookRepository.findById(id);
    }

    public Book createBook(Book book) {
        return bookRepository.save(book);
    }

    public Book updateBook(Long id, Book updatedBook) {
        Optional<Book> book = bookRepository.findById(id);
        book.ifPresent(b -> {
            b.setTitle(updatedBook.getTitle());
            b.setAuthor(updatedBook.getAuthor());
            b.setPublicationYear(updatedBook.getPublicationYear());
            b.setIsbn(updatedBook.getIsbn());
        });
        return bookRepository.save(book.get());
    }

    public void deleteBook(Long id) {
        bookRepository.deleteById(id);
    }
}