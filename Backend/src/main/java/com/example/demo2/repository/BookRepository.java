package com.example.demo2.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo2.model.Book;
import com.example.demo2.model.User;

public interface BookRepository extends JpaRepository<Book,Long> {
	List<Book> findAllBycategory(String category);
	Book findAllBytitle(String title);
}
