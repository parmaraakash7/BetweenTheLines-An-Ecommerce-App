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
import com.example.demo2.model.UserWishlist;
import com.example.demo2.repository.BookRepository;
import com.example.demo2.repository.UserWishlistRepository;

@RestController
public class UserWishlistController {
	@Autowired
	private UserWishlistRepository uwr;
	@Autowired
	private BookRepository bookRepository;
	
	@GetMapping("/wishlist")
	public List<UserWishlist> getAll(){
		return uwr.findAll();	
	}
	
	@GetMapping("/wishlist/{userId}")
	public List<Book> getWishlistFromUserId(@PathVariable(value = "userId")Long userId){
		List<UserWishlist> bookids=uwr.findAllByuserId(userId);
		List<Long> ids = new ArrayList<Long>();
		
		for(UserWishlist u:bookids) {
			ids.add(u.getBookId());
		}
		System.out.println(ids);
		
		return bookRepository.findAllById(ids);
	}
	
	@PostMapping("/wishlist")
	public UserWishlist craete(@Valid @RequestBody UserWishlist u ) {
		return uwr.save(u);
	}
	
	@DeleteMapping("/wishlist/{userId}/{bookId}")
	public Boolean delete(@PathVariable(value = "userId")Long userId,@PathVariable(value = "bookId")Long bookId) 
	{
		List<UserWishlist> t1=uwr.findAllBybookId(bookId);
		for(UserWishlist u:t1)
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
