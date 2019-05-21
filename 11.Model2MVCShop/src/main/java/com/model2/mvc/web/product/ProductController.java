package com.model2.mvc.web.product;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public ProductController() {
		System.out.println(this.getClass().getName()+"��Ʈ�ѷ� ������");
	}

	@RequestMapping(value="addProduct", method=RequestMethod.POST) // �׻� post�θ� ��ϰ���
	public String addProduct(@ModelAttribute("product") Product product,
					@RequestParam("multifile") MultipartFile multipartFile) throws Exception
	{
		System.out.println("/product/addProduct");
		System.out.println("multipartFile :_"+multipartFile+"_");
		System.out.println(multipartFile.getName()); //attribute name�� ��
		System.out.println(multipartFile.getOriginalFilename());//������ name
		
		product.setFileName(multipartFile.getOriginalFilename());
		
		productService.addProduct(product);
		
		return "forward:/product/addProductResultView.jsp";
	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct(@RequestParam("prodNo") String prodNo,HttpSession session,HttpServletRequest request,
									HttpServletResponse response) throws Exception
	{
		System.out.println("/product/getProduct");
		
		Product vo = productService.getProduct(Integer.parseInt(prodNo));

		String cookieString =this.addCookie(prodNo, request, response); // addCookie methodȭ
		
		System.out.println(cookieString);
		
		session.setAttribute("vo", vo);
		
		
		String menu = (String) session.getAttribute("menu");
		System.out.println(menu);
		
		if(menu.equals("manage"))
			return "forward:/product/updateProduct"; // �̷��� ������ ----
		else
			return "forward:/product/readProduct.jsp";
		
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET) // ������ getProduct�� get���. forward�ϸ� ����
	public String updateProduct()
	{
		System.out.println("/product/updateProductView ����");
		
		return "forward:/product/updateProductView.jsp";
	}
	
	@RequestMapping(value="updateProduct",method=RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product, HttpSession session,
						Model model,@RequestParam("multifile") MultipartFile multipartFile) throws Exception
	{
		System.out.println("/product/updateProduct ���� �ߴٸ�!");
		
		Product sessionProduct = (Product) session.getAttribute("vo");
		
		product.setProdNo(sessionProduct.getProdNo());
		product.setRegDate(sessionProduct.getRegDate());
		product.setFileName(multipartFile.getOriginalFilename());
		
		productService.updateProduct(product);
		
		model.addAttribute("vo", product);
		
		return "forward:/product/readProduct2.jsp";
	}
	
	@RequestMapping("listProduct") //���� listProduct trancode�����ΰͰ����� �ʿ����
	public String listProduct(@ModelAttribute("search") Search search,Model model,HttpSession session,
									@RequestParam("menu") String menu) throws Exception
	{
		System.out.println("/product/listProduct");
		System.out.println(search.getOrderCondition());
		if(search.getOrderCondition()== null)
		{
			search.setOrderCondition("100"); //���� ó�� ����(prod_no)  1 �������ݼ� 2 �������ݼ�
		}
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String,Object> map = productService.getProductList2(search);
		Page resultPage	= 
				new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		session.setAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping("listProduct2") //���� listProduct
	public String listProduct2(@ModelAttribute("search") Search search,Model model,HttpSession session,
			@RequestParam("menu") String menu) throws Exception
	{
			System.out.println("/product/listProduct2");

			if(search.getCurrentPage() ==0 ){
				search.setCurrentPage(1);
			}
			search.setPageSize(pageSize);

			Map<String,Object> map = productService.getProductList(search);
			Page resultPage	= 
					new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);

			model.addAttribute("list", map.get("list"));
			model.addAttribute("resultPage", resultPage);
			model.addAttribute("search", search);

			session.setAttribute("menu", menu);

			return "forward:/product/listProduct2.jsp"; //�ǸŻ�ǰ������ forward
	}
	
	@RequestMapping(value="bestSellerList", method = RequestMethod.GET)
	public String bestSellerList(Model model,@RequestParam("menu") String menu,
									HttpSession session)
	{
		session.setAttribute("menu", menu);
		
		System.out.println("/product/bestSellerList");
		
		// search �ʿ����.�������� ������ 1���� �����ű� ������.
		
		List<Product> list = productService.getBestSellerList();
		
		model.addAttribute("list", list);
		
		return "forward:/product/bestSellerList.jsp";
	}
	
	
	private String addCookie(String prodNo,HttpServletRequest request,HttpServletResponse response)
	{
		String cookieString = "";
		int count=0;
		
		if(request.getCookies()!=null) // cookie�� ���� �ƴҶ� �ϸ�ȵȴ�. cookie�� null�� �ƴϴ�.
		{
			Cookie[] cookieJar = request.getCookies();
			for(int i=0 ; i<cookieJar.length; i++)
			{
				Cookie cookie = cookieJar[i];
				if(cookie.getName().equals("history")) // history cookie�� ������,
					cookieString = cookie.getValue()+","+prodNo;	
				else // cookie�� ������, history cookie�� ������.
 					count++;
			}
			if(count==cookieJar.length)
				cookieString =prodNo;
			
		}
		else // history�� ���� �ƿ� ��Ű�� 0�϶�.
		{
			cookieString = prodNo; // cookieString���ٰ� ù prodNo�� ���Ѵ�.
		}
		Cookie cookie = new Cookie("history",cookieString);
		cookie.setMaxAge(-1);
		cookie.setPath("/"); //��ü ��ο� ����.
		response.addCookie(cookie);
		
		return cookieString;
	}
	
	
}
