package com.model2.mvc.service.domain;

import java.sql.Date;

public class Cart {
	
	private int cartNo;
	private int prodNo;
	private String userId;
	private Date addDate;
	
	public Cart() {
		// TODO Auto-generated constructor stub
	}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public int getProdNo() {
		return prodNo;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
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
	
	@Override
	public String toString()
	{
		return "CartVO : [cartNo]" + cartNo
		+ "[prodNo]" + prodNo+ "[userId]" + userId + "[addDate]" + addDate;
	}

}
