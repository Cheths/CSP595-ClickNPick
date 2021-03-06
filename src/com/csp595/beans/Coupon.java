package com.csp595.beans;

public class Coupon {

	private String couponCode;
	private String discount;
	private String userName;
	private String isUsed;
	public Coupon() {
	}

	public Coupon(String couponCode, String discount, String userName, String isUsed) {
		this.couponCode = couponCode;
		this.discount = discount;
		this.userName = userName;
		this.isUsed = isUsed;
	}

	public String getCouponCode() {
		return couponCode;
	}

	public void setCouponCode(String couponCode) {
		this.couponCode = couponCode;
	}

	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getIsUsed() {
		return isUsed;
	}

	public void setIsUsed(String isUsed) {
		this.isUsed = isUsed;
	}
	
}
