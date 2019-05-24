package com.model2.mvc.service.cart;

import java.util.List;

import com.model2.mvc.service.domain.Cart;

public interface CartDao {
	
	public void insertCart(Cart cart);
	
	public List<Cart> getMyCartList(String userId);
}
