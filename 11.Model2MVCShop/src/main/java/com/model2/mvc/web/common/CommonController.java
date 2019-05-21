package com.model2.mvc.web.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/common/*")
public class CommonController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	public CommonController() {
		System.out.println(this.getClass().getName()+"의 생성자 실행..");
	}
	
	@RequestMapping(value="autocomplete" , method = RequestMethod.POST)
	public String autocomplete()
	{
		return null;
	}

}
