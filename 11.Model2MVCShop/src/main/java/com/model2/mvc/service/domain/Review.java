package com.model2.mvc.service.domain;

import java.sql.Date;

public class Review {

	int reviewNo;
	int tranNo;
	int prodNo;
	String writerId;
	String reviewContext;
	Date writeDate;
	
	
	public Review() {
		// TODO Auto-generated constructor stub
	}


	public int getReviewNo() {
		return reviewNo;
	}


	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}


	public int getTranNo() {
		return tranNo;
	}


	public void setTranNo(int tranNo) {
		this.tranNo = tranNo;
	}


	public int getProdNo() {
		return prodNo;
	}


	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}


	public String getWriterId() {
		return writerId;
	}


	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}


	public String getReviewContext() {
		return reviewContext;
	}


	public void setReviewContext(String reviewContext) {
		this.reviewContext = reviewContext;
	}


	public Date getWriteDate() {
		return writeDate;
	}


	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	@Override
	public String toString()
	{
		
		return "Review [ reviewNo=" + reviewNo + ", tranNo=" + tranNo
				+ ", prodNo=" + prodNo + ", writerId=" + writerId
				+ ", reviewContext=" + reviewContext + ", writeDate="
				+ writeDate +"]";
	}
}
