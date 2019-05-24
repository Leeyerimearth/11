package com.model2.mvc.service.domain;

import java.util.List;

public class ProductImage {

	int prodNo;
	List<String> ImageName;
	
	public ProductImage() {
		// TODO Auto-generated constructor stub
	}

	public int getProdNo() {
		return prodNo;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	public List<String> getImageName() {
		return ImageName;
	}

	public void setImageName(List<String> imageName) {
		ImageName = imageName;
	}

}
