package com.model2.mvc.service.domain;

import java.sql.Date;

public class Cart {
	
	private int cartNo;
	private String userId;
	private Date addDate;
	private Product cartProduct;
	
	public Cart() {
		// TODO Auto-generated constructor stub
	}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getAddDate() {
		return addDate;
	}

	public void setAddDate(Date addDate) {
		this.addDate = addDate;
	}
	
	public Product getCartProduct() {
		return cartProduct;
	}

	public void setCartProduct(Product cartProduct) {
		this.cartProduct = cartProduct;
	}

	@Override
	public String toString()
	{
		return "CartVO : [cartNo]" + cartNo
		+  "[userId]" + userId + "[addDate]" + addDate+"[cartProduct]"+ cartProduct ;
	}

}
