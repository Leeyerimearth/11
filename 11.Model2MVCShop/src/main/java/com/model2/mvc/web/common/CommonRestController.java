package com.model2.mvc.web.common;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;

@RestController
@RequestMapping("/common/*")
public class CommonRestController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	public CommonRestController() {
		System.out.println(this.getClass().getName()+"의 생성자 실행..");
	}
	
	@RequestMapping(value="json/autocomplete" , method = RequestMethod.POST,
			produces = "application/json; charset=utf8"
)
	public List autocomplete(@RequestBody String jsonQuery) throws Exception // 어느 table로 갈건지 정한다.
	{
		System.out.println("json/autocomplete POST 방식");
		System.out.println(jsonQuery);
		
		Search search = new Search();
		//List<User> userList = null;
		List<String> list = new ArrayList();
		List noDupleList = null;
		JSONObject jsonobj = (JSONObject) JSONValue.parse(jsonQuery);
		
		String table = (String) jsonobj.get("table"); // 어느 mapper로 갈것인지?
		System.out.println(table);
		
		search.setSearchKeyword((String) jsonobj.get("searchKeyword"));
		search.setSearchCondition((String)jsonobj.get("searchCondition"));
		
		if(table.equals("user")) // userMapper 간다
		{
			list = userService.getAllUserList(search);
		}
		else if(table.equals("product")) // productMapper 간다
		{
			list = productService.getAllProductList(search);
			System.out.println(list.get(1).getClass());
		}
		
		noDupleList = new ArrayList(new LinkedHashSet(list)); //list 중복제거
		
		return noDupleList;
	}

}

