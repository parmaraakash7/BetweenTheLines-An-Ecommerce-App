package com.example.demo2.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo2.model.User;
import com.example.demo2.repository.UserRepository;

@RestController
public class UserController {

	@Autowired
	private UserRepository userRepository;
	
	@GetMapping("/users")
	public List<User> getAllUsers(){
		return userRepository.findAll();
	}
	
	@GetMapping("/users/{userId}")
	public User getUser(@PathVariable(value = "userId")Long userId )throws Exception {
		return userRepository.findById(userId).orElseThrow(()->new Exception());
	}
	
	@GetMapping("/users/verify/{uname}/{pass}")
	public User verify(@PathVariable(value = "uname")String userName,@PathVariable(value = "pass")String password) {
		List<User>users = userRepository.findAllByuserName(userName);
		for(User u:users) {
			if(u.getPassword().equals(password)) {
				return u;
			}
		}
		return null;
	}
	
	@PostMapping("/users")
	public User createUser(@Valid @RequestBody User user) {
		return userRepository.save(user);
	}
	
	@DeleteMapping("/users/{id}")
	public Map<String,Boolean> deleteUser(@PathVariable(value = "id")Long userid) throws Exception
	{
		User t1=userRepository.findById(userid).orElseThrow(()->new Exception());
		userRepository.delete(t1);
		Map<String, Boolean> response = new HashMap<>();
        response.put("deleted", Boolean.TRUE);
        return response;
	}
}
