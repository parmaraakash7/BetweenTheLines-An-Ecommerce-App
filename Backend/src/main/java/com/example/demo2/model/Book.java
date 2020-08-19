package com.example.demo2.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="books")
public class Book {
	
	private long bookId;
	private String coverImage;
	private String title;
	private long price;
	private long pages;
	private String authorName;
	private String category;
	private String description;
	private int quantity;
	private int currentQuantity;
	@Column(name="current_quantity",nullable=true)
	public int getCurrentQuantity() {
		return currentQuantity;
	}
	public void setCurrentQuantity(int currentQuantity) {
		this.currentQuantity = currentQuantity;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public long getBookId() {
		return bookId;
	}
	@Column(name="coverImage",nullable=false)
	public String getCoverImage() {
		return coverImage;
	}
	@Column(name="title",nullable=false)
	public String getTitle() {
		return title;
	}
	@Column(name="price",nullable=false)
	public long getPrice() {
		return price;
	}
	@Column(name="pages",nullable=false)
	public long getPages() {
		return pages;
	}
	@Column(name="author",nullable=false)
	public String getAuthorName() {
		return authorName;
	}
	@Column(name="category",nullable=false)
	public String getCategory() {
		return category;
	}
	@Column(name="description",nullable=false)
	public String getDescription() {
		return description;
	}
	@Column(name="quantity",nullable=true)
	public int getQuantity() {
		return quantity;
	}
	public void setBookId(long bookId) {
		this.bookId = bookId;
	}
	public void setCoverImage(String coverImage) {
		this.coverImage = coverImage;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setPrice(long price) {
		this.price = price;
	}
	public void setPages(long pages) {
		this.pages = pages;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public Book(long bookId, String coverImage, String title, long price, long pages, String authorName,
			String category, String description,int quantity) {
		super();
		this.bookId = bookId;
		this.coverImage = coverImage;
		this.title = title;
		this.price = price;
		this.pages = pages;
		this.authorName = authorName;
		this.category = category;
		this.description = description;
		this.quantity = quantity;
	}
	
	public Book() {
		
	}
	
	

}
