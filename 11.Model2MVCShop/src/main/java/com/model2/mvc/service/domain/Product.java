package com.model2.mvc.service.domain;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;


public class Product {
	
	//private String [] fileName = new String[3];
	private String fileName1;
	private String fileName2;
	private String fileName3;
	private String manuDate;
	private int price;
	private String prodDetail;
	private String prodName;
	private int prodNo;
	private Date regDate;
	private String proTranCode;
	private int quantity;
	private int saleQuantity;
	
	public Product(){
	}
	/*
	public Product(String fileName1, String fileName2, String fileName3){ //이렇게 하는게 맞을까?ㅠㅠ
		
		this.fileName[0] = fileName1;
		this.fileName[1] = fileName2;
		this.fileName[2] = fileName3;
	}
	
	
	public String[] getFileName() {
		return fileName;
	}

	public void setFileName(String[] fileName) {
		this.fileName = fileName;
	}
	*/
	

	public String getFileName1() {
		return fileName1;
	}


	public void setFileName1(String fileName1) {
		this.fileName1 = fileName1;
	}


	public String getFileName2() {
		return fileName2;
	}


	public void setFileName2(String fileName2) {
		this.fileName2 = fileName2;
	}


	public String getFileName3() {
		return fileName3;
	}


	public void setFileName3(String fileName3) {
		this.fileName3 = fileName3;
	}


	//////////////////////////////////////////////////////////제품 총 판매 개수 추가	
	public int getSaleQuantity() {
		return saleQuantity;
	}

	public void setSaleQuantity(int saleQuantity) {
		this.saleQuantity = saleQuantity;
	}
///////////////////////////////////////////////////////////////////

	
	public int getQuantity()
	{
		return quantity;
	}
	public void setQuantity(int quantity)
	{
		this.quantity = quantity;
	}
	public String getProTranCode() {
		return proTranCode;
	}
	public void setProTranCode(String proTranCode) {
		this.proTranCode = proTranCode;
	}
	
	////////////////////////////////////////////////////////////	

	
	
///////////////////////////////////////////////////////////////////////////////////
	public String getManuDate() {
		
		return manuDate;
	}
	public void setManuDate(String manuDate) {
		String splitDate="";
		System.out.println(manuDate);
		for(int i=0; i<manuDate.length();i++)
		{
			if(manuDate.charAt(i)!='-'&&manuDate.charAt(i)!='/')
			{
				splitDate += manuDate.charAt(i);
			}
		}
		System.out.println(splitDate);
		this.manuDate = splitDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProdDetail() {
		return prodDetail;
	}
	public void setProdDetail(String prodDetail) {
		this.prodDetail = prodDetail;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getProdNo() {
		return prodNo;
	}
	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	// Override
	public String toString() {
		return "ProductVO :"
				+ "[manuDate]" + manuDate+ "[price]" + price + "[prodDetail]" + prodDetail
				+ "[prodName]" + prodName + "[prodNo]" + prodNo + "[quantity]"+ quantity;
	}	
}