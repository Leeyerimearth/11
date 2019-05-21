package com.model2.mvc.service.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductDao {
	
	public Product findProduct(int prodNo);
	
	public List<Product> getProductList2(Search search);
	
	public List<Product> getProductList(Search search);
	
	public void insertProduct(Product product);
	
	public void updateQuantity(Product product,int buyQuantity);
	
	public void updateProduct(Product product);
	
	public void updateSaleQuantity(Product product, int saleQuantity);
	
	public int getTotalCount(Search search) throws Exception ;
	
	public List<Product> getBestSellerList();
	
	public List getAllProductList(Search search);
}
