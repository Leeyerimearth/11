package com.model2.mvc.web.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	public ProductRestController() {
		System.out.println(this.getClass().getName()+"productRestController생성자");
	}

	@RequestMapping(value="/json/addProduct", method = RequestMethod.POST) //2019.05.13 -> 아직못함 multifile
	public void addProduct(@RequestBody User user,
			@RequestPart("multifile") MultipartFile multipartFile) throws Exception
	{
		System.out.println("/product/json/addProduct");
		
		System.out.println(user.getUserId());
		
		//System.out.println(multipartFile.getName()); //attribute name의 값
		//System.out.println(multipartFile.getOriginalFilename());//파일의 name

		//product.setFileName(multipartFile.getOriginalFilename());

		//productService.addProduct(product);

	}
	
	@RequestMapping(value="/json/getProduct/{prodNo}", method=RequestMethod.GET) //2019.05.13
	public Product getProduct(@PathVariable String prodNo, HttpServletRequest request,
									HttpServletResponse response, HttpSession session) throws Exception
	{
		System.out.println("/product/json/getProduct");
		
		Product vo = productService.getProduct(Integer.parseInt(prodNo));
		System.out.println(vo);
		String cookieString = this.addCookie(prodNo,request, response);
		
		System.out.println(cookieString);
		
		session.setAttribute("vo", vo);
	
		return vo;
	}
	
	@RequestMapping(value="/json/updateProduct", method=RequestMethod.POST)//2019.05.14 multipart
	public Product updateProduct(HttpSession session, @RequestBody Product product,
								@RequestParam("multifile") MultipartFile multipartFile) throws Exception
	{
		System.out.println("/product/json/updateProduct");
		
		Product sessionProduct = (Product) session.getAttribute("vo");
		
		product.setProdNo(sessionProduct.getProdNo());		
		product.setRegDate(sessionProduct.getRegDate());
		product.setFileName(multipartFile.getOriginalFilename());
		
		productService.updateProduct(product);
		
		return product;
	}
	
	@RequestMapping(value = "/json/listProduct", method=RequestMethod.GET) // 2019.05.14
	public Map listProduct(HttpSession session, @RequestParam("menu") String menu) throws Exception
	{
		System.out.println("/product/json/listProduct");
		
		Search search = new Search();
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String,Object> returnMap = productService.getProductList2(search);
		Page resultPage	= 
				new Page( search.getCurrentPage(), ((Integer)returnMap.get("totalCount")).intValue(), pageUnit, pageSize);
		
		Map map = new HashMap();
		
		map.put("list", returnMap.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		session.setAttribute("menu", menu);
		
		return map;
	}
	
	
	@RequestMapping(value = "/json/listProduct", method=RequestMethod.POST) // 2019.05.14
	public Map listProduct(HttpSession session, @RequestParam("menu") String menu,
							@RequestBody Search search) throws Exception
	{
		System.out.println("/product/json/listProduct");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String,Object> returnMap = productService.getProductList2(search);
		Page resultPage	= 
				new Page( search.getCurrentPage(), ((Integer)returnMap.get("totalCount")).intValue(), pageUnit, pageSize);
		
		Map map = new HashMap();
		
		map.put("list", returnMap.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		//session.setAttribute("menu", menu);
		
		return map;
	}
	
	@RequestMapping(value="/json/listProduct2/{menu}", method=RequestMethod.GET)//2019.05.15
	public Map listProduct2(HttpSession session,@PathVariable("menu") String menu) throws Exception
	{
		System.out.println("/product/json/listProduct2");
		
		Search search = new Search();
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String,Object> returnMap = productService.getProductList(search);
		Page resultPage	= 
				new Page( search.getCurrentPage(), ((Integer)returnMap.get("totalCount")).intValue(), pageUnit, pageSize);

		Map map = new HashMap();
		
		map.put("list", returnMap.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		//model.addAttribute("list", map.get("list"));
		//model.addAttribute("resultPage", resultPage);
		//model.addAttribute("search", search);

		session.setAttribute("menu", menu);

		return map;
	}
	
	@RequestMapping(value="/json/listProduct2/{menu}", method=RequestMethod.POST) // 2019.05.15
	public Map listProduct2(HttpSession session,@RequestBody Search search
						,@PathVariable("menu") String menu) throws Exception
	{
		System.out.println("/product/json/listProduct2");
		
		//Search search = new Search();
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String,Object> returnMap = productService.getProductList(search);
		Page resultPage	= 
				new Page( search.getCurrentPage(), ((Integer)returnMap.get("totalCount")).intValue(), pageUnit, pageSize);

		Map map = new HashMap();
		
		map.put("list", returnMap.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);

		//session.setAttribute("menu", menu);

		return map;
	}

	@RequestMapping(value="/json/bestSellerList/{menu}", method= RequestMethod.GET) //2019.05.15
	public Map bestSellerList(@PathVariable("menu") String menu, HttpSession session)
	{
		session.setAttribute("menu", menu);
		
		System.out.println("/product/bestSellerList");
		
		// search 필요없다.페이지는 무조건 1개로 놓을거기 때문에.
		
		List<Product> list = productService.getBestSellerList();
		
		Map map = new HashMap();
		map.put("list", list);
		
		return map;
	}
	
	
	private String addCookie(String prodNo,HttpServletRequest request,HttpServletResponse response)
	{
		String cookieString = "";
		int count=0;
		
		if(request.getCookies()!=null) // cookie가 널이 아닐때 하면안된다. cookie는 null이 아니다.
		{
			Cookie[] cookieJar = request.getCookies();
			for(int i=0 ; i<cookieJar.length; i++)
			{
				Cookie cookie = cookieJar[i];
				if(cookie.getName().equals("history")) // history cookie가 있을때,
					cookieString = cookie.getValue()+","+prodNo;	
				else // cookie는 있지만, history cookie가 없을때.
 					count++;
			}
			if(count==cookieJar.length)
				cookieString =prodNo;
			
		}
		else // history는 물론 아예 쿠키가 0일때.
		{
			cookieString = prodNo; // cookieString에다가 첫 prodNo를 더한다.
		}
		Cookie cookie = new Cookie("history",cookieString);
		cookie.setMaxAge(-1);
		cookie.setPath("/"); //전체 경로에 저장.
		response.addCookie(cookie);
		
		return cookieString;
	}

}
