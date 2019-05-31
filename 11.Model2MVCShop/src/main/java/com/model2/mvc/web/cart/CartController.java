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
import com.model2.mvc.service.domain.User;

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
		System.out.println(this.getClass().getName()+"������ ����!");
	}
	
	@RequestMapping(value="addCart", method=RequestMethod.POST ) // ��ٱ��Ͽ� add
	public String addCart(@ModelAttribute("cart") Cart cart,HttpSession session)
	{
		System.out.println("/cart/addCart");
		
		cartService.addCart(cart);
		
		return "";
	}

	
	@RequestMapping(value="getCartList", method=RequestMethod.GET)//��ٱ��� �ҷ����� userId�� ����
	public String getCartList(@RequestParam("userId") String userId,Model model)
	{
		System.out.println("/cart/getCartList");
		
		List<Cart> myCartList = cartService.getMyCartList(userId); // userId�� �ش��ϴ� ��ٱ��� ��ǰ�� �� �����´�.
		
		model.addAttribute("list", myCartList);
		
		return "forward:/user/myCartList.jsp";
	}
	//��ٱ��� ����
	
	@RequestMapping(value="deleteCart", method=RequestMethod.GET)
	public String deleteCart(@RequestParam("checkCartNo") String checkCartNo, HttpSession session
								,Model model)
	{
		System.out.println("/cart/deleteCart");
		
		User user = (User) session.getAttribute("user");
		
		String [] cartNos = checkCartNo.split(",");
		
		cartService.deleteCart(cartNos); //������ cartNo �迭 �Ѱ��ֱ� -> ����
		List<Cart> myCartList = cartService.getMyCartList(user.getUserId());
		model.addAttribute("list", myCartList);
		
		return "forward:/user/myCartList.jsp";
	}
	
}
