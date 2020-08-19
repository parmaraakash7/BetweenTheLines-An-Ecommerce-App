package com.example.demo2.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="user_wishlist")
public class UserWishlist {
	private long userId;
	private long bookId;
	private long id;
	public UserWishlist(long id,long userId, long bookId) {
		super();
		this.id=id;
		this.userId = userId;
		this.bookId = bookId;
	}
	
	public UserWishlist() {}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public long getId() {
		return id;
	}
	
	public void setId(long id) {
		this.id = id;
	}

	@Column(name="userId",nullable=false)
	public long getUserId() {
		return userId;
	}
	@Column(name="bookId",nullable=false)
	public long getBookId() {
		return bookId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public void setBookId(long bookId) {
		this.bookId = bookId;
	}
	
	

}
