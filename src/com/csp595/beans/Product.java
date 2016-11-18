package com.csp595.beans;

public class Product {
	
	private String  id;
	private String name;
	private String category;
	private double  price;
	private double discount;
	private String manufacturer;
	private String condition;
	private String description;
	private String image;
	
	public Product() {
	}
	
	public Product(String id, String name, String category, double price, double discount, String manufacturer,String condition, String description, String image) {
		this.id = id;
		this.name = name;
		this.category = category;
		this.price = price;
		this.discount = discount;
		this.manufacturer = manufacturer;
		this.condition = condition;
		this.description = description;
		this.image = image;
	}



	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getDiscount() {
		return discount;
	}
	public void setDiscount(double discount) {
		this.discount = discount;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
}
