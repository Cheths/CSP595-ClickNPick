package com.cheths.a1.main;

public class ProductReview {

	private String productReviewId;
	private String productModelName;
	private String category;
	private String retailerName;
	private String mfgName;
	private String productPrice;
	private String mfgRebate;

	private String zipCode;
	private String city;
	private String state;

	private String userName;
	private String userAge;
	private String userOccupation;

	private String rating;
	private String date;
	private String productOnSale;
	/*
	 * private String month; private String day; private String year;
	 */
	private String comments;

	public ProductReview(String productReviewId, String productModelName, String category, String retailerName, String mfgName, String productPrice, String mfgRebate,
			String zipCode, String city, String state,String userName, String userAge, String userOccupation,String rating, String date, String comments, String productOnSale) {
		this.productReviewId = productReviewId;
		this.productModelName = productModelName;
		this.category = category;
		this.retailerName = retailerName;
		this.mfgName = mfgName;
		this.productPrice = productPrice;
		this.mfgRebate = mfgRebate;
		this.zipCode = zipCode;
		this.city = city;
		this.state = state;
		this.userName = userName;
		this.userAge = userAge;
		this.userOccupation = userOccupation;
		this.rating = rating;
		this.date = date;
		this.comments = comments;
		this.productOnSale = productOnSale;
	}

	public String getProductReviewId() {
		return productReviewId;
	}

	public void setProductReviewId(String productReviewId) {
		this.productReviewId = productReviewId;
	}

	public String getProductModelName() {
		return productModelName;
	}

	public void setProductModelName(String productModelName) {
		this.productModelName = productModelName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getRetailerName() {
		return retailerName;
	}

	public void setRetailerName(String retailerName) {
		this.retailerName = retailerName;
	}

	public String getMfgName() {
		return mfgName;
	}

	public void setMfgName(String mfgName) {
		this.mfgName = mfgName;
	}

	public String getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(String productPrice) {
		this.productPrice = productPrice;
	}

	public String getMfgRebate() {
		return mfgRebate;
	}

	public void setMfgRebate(String mfgRebate) {
		this.mfgRebate = mfgRebate;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserAge() {
		return userAge;
	}

	public void setUserAge(String userAge) {
		this.userAge = userAge;
	}

	public String getUserOccupation() {
		return userOccupation;
	}

	public void setUserOccupation(String userOccupation) {
		this.userOccupation = userOccupation;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getProductOnSale() {
		return productOnSale;
	}

	public void setProductOnSale(String productOnSale) {
		this.productOnSale = productOnSale;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
	
	
}
