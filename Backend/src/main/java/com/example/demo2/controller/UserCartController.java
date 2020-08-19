package com.example.demo2.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo2.model.Book;
import com.example.demo2.model.UserCart;
import com.example.demo2.model.UserWishlist;
import com.example.demo2.repository.BookRepository;
import com.example.demo2.repository.UserCartRepository;
import com.example.demo2.repository.UserWishlistRepository;

@RestController
public class UserCartController {
	@Autowired
	private UserCartRepository uwr;
	@Autowired
	private BookRepository bookRepository;
	
	@GetMapping("/cart")
	public List<UserCart> getAll(){
		return uwr.findAll();	
	}
	
	@GetMapping("/cart/{userId}")
	public List<Book> getCartFromUserId(@PathVariable(value = "userId")Long userId){
		List<UserCart> bookids=uwr.findAllByuserId(userId);
		List<Long> ids = new ArrayList<Long>();
		
		for(UserCart u:bookids) {
			ids.add(u.getBookId());
		}
		
		return bookRepository.findAllById(ids);
	}
	
	@PostMapping("/cart")
	public UserCart craete(@Valid @RequestBody UserCart u ) {
		return uwr.save(u);
	}
	
	@DeleteMapping("/cart/{userId}/{bookId}")
	public Boolean delete(@PathVariable(value = "userId")Long userId,@PathVariable(value = "bookId")Long bookId) 
	{
		List<UserCart> t1=uwr.findAllBybookId(bookId);
		for(UserCart u:t1)
		{
			if(u.getUserId()==userId)
			{
				uwr.delete(u);
				return true;
			}
		}
		return false;
		
	}
	
	

}
