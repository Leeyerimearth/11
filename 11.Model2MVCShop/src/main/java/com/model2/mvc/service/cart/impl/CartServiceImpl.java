package com.model2.mvc.service.cart.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.cart.CartDao;
import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;

@Service("cartServiceImpl")
public class CartServiceImpl implements CartService{

	@Autowired
	@Qualifier("cartDaoImpl")
	private CartDao cartDao;
	
	public void setCartDao(CartDao cartDao) {
		this.cartDao = cartDao;
	}

	public CartServiceImpl() {
		System.out.println(this.getClass().getName()+"»ý¼ºÀÚ ½ÃÀÛÀÌ¿ê¿êÀÌ!");
	}

	@Override
	public void addCart(Cart cart) {
		
		cartDao.insertCart(cart);
	}

}
