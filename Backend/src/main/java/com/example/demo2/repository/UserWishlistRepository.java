package com.example.demo2.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo2.model.User;
import com.example.demo2.model.UserWishlist;

@Repository
public interface UserWishlistRepository extends JpaRepository<UserWishlist,Long>{
	List<UserWishlist> findAllByuserId(Long userId);
	List<UserWishlist> findAllBybookId(Long bookId);
}
