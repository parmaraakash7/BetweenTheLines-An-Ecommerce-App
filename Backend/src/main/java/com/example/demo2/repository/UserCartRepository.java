package com.example.demo2.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo2.model.UserCart;
import com.example.demo2.model.UserWishlist;

@Repository
public interface UserCartRepository extends JpaRepository<UserCart,Long>{
	List<UserCart> findAllByuserId(Long userId);
	List<UserCart> findAllBybookId(Long bookId);
}
