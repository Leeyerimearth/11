package com.model2.mvc.web.cart;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;

@RestController
@RequestMapping("/cart/*")
public class CartRestController {

	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	public CartRestController() {
		
		System.out.println(this.getClass().getName()+"생성자 생성!");
	}
	
	
	@RequestMapping(value="json/addCart" , method=RequestMethod.POST ) // 장바구니에 add
	public void addCart(@RequestBody Map map ,HttpSession session)
	{
		System.out.println("/cart/json/addCart");
		System.out.println(map);
		System.out.println(map.get("prodNo"));
		
		Cart cart = new Cart();
		Product product = new Product();
		product.setProdNo(Integer.parseInt((String) map.get("prodNo")));	
		User user = (User) session.getAttribute("user");
		cart.setUserId(user.getUserId());
		cart.setCartProduct(product);
		
		cartService.addCart(cart);
	
		// 사실은 get해서 진짜 들어갔는지 data받아야한다. 
		//return map;
	}

}
