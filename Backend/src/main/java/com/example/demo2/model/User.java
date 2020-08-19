package com.example.demo2.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "user_data")
public class User {
	private long userId;
	private String userName;
	private String email;
	private double money;
	private String password;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public long getUserId() {
		return userId;
	}
	public User() {
		
	}
	public User(long userId, String userName, String email, double money,String password) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.email = email;
		this.money = money;
		this.password = password;
	}
	@Column(name="userName",nullable=false)
	public String getUserName() {
		return userName;
	}
	@Column(name="email",nullable=false)
	public String getEmail() {
		return email;
	}
	@Column(name="money",nullable=false)
	public double getMoney() {
		return money;
	}
	@Column(name="password",nullable=false)
	public String getPassword() {
		return password;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	public void setPassword(String password) {
		this.password=password;
	}

}
