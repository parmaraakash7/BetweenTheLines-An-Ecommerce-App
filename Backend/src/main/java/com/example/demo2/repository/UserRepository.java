package com.example.demo2.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo2.model.User;

@Repository
public interface UserRepository extends JpaRepository<User,Long>{

	List<User> findAllByuserName(String userName);

}
