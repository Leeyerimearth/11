package com.model2.mvc.web.cart;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;

@Controller
@RequestMapping("/cart/*")
public class CartController {

	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public CartController() {
		System.out.println(this.getClass().getName()+"생성자 생성!");
	}
	
	@RequestMapping(value="addCart", method=RequestMethod.POST ) // 장바구니에 add
	public String addCart(@ModelAttribute("cart") Cart cart,HttpSession session)
	{
		System.out.println("/cart/addCart");
		
		cartService.addCart(cart);
		
		return "";
	}

	
	@RequestMapping(value="getCartList", method=RequestMethod.GET)//장바구니 불러오기 userId에 따라서
	public String getCartList(@RequestParam("userId") String userId,Model model)
	{
		System.out.println("/cart/getCartList");
		
		List<Cart> myCartList = cartService.getMyCartList(userId); // userId에 해당하는 장바구니 상품을 다 가져온다.
		
		model.addAttribute("list", myCartList);
		
		return "forward:/user/myCartList.jsp";
	}
	//장바구니 삭제
}
