package com.example.demo2.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo2.model.Book;
import com.example.demo2.model.User;
import com.example.demo2.repository.BookRepository;

@RestController
public class BookController {
	@Autowired
	private BookRepository bookRepository;
	
	@GetMapping("/books")
	public List<Book> getAllBooks(){
		return bookRepository.findAll();
		//return userRepository.findAll();
	}
	
	@GetMapping("/books/{bookId}")
	public Book getBook(@PathVariable(value = "bookId")Long bookId )throws Exception {
		return bookRepository.findById(bookId).orElseThrow(()->new Exception());
	}
	
	@GetMapping("/books/category/{category}")
	public List<Book> getBookByCategoryName(@PathVariable(value = "category")String category){
		System.out.println("helllo");
		return bookRepository.findAllBycategory(category);
	}
	
	@GetMapping("/books/find/{bookname}")
	public Book getBookByBookName(@PathVariable(value = "bookname")String bookname){
		System.out.println("helllo");
		return bookRepository.findAllBytitle(bookname);
	}
	
	@PutMapping("/books")
	public Book updateBook(@Valid @RequestBody Book book) {
		return bookRepository.save(book);
	}
	
	@PostMapping("/books")
	public Book createBook(@Valid @RequestBody Book book) {
		return bookRepository.save(book);
	}
	
	@DeleteMapping("/books/{id}")
	public Map<String,Boolean> deleteUser(@PathVariable(value = "id")Long bookid) throws Exception
	{
		Book t1=bookRepository.findById(bookid).orElseThrow(()->new Exception());
		bookRepository.delete(t1);
		Map<String, Boolean> response = new HashMap<>();
        response.put("deleted", Boolean.TRUE);
        return response;
	}
}

