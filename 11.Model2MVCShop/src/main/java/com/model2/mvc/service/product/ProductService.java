package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductService {
	
	public void addProduct(Product product,List<MultipartFile> multipartFile) throws Exception;

	public Product getProduct(int prodNo) throws Exception;

	public Map<String,Object> getProductList2(Search search) throws Exception;

	public void updateProduct(Product product) throws Exception;
	
	public Map<String,Object> getProductList(Search search)throws Exception; // ±×³É productlist
	
	public List<Product> getBestSellerList();
	
	public List getAllProductList(Search search);
	
}
