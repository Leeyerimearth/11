package com.model2.mvc.web.cart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.model2.mvc.service.cart.CartService;

@Controller
@RequestMapping("/cart/*")
public class CartController {

	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	public CartController() {
		// TODO Auto-generated constructor stub
	}

}
