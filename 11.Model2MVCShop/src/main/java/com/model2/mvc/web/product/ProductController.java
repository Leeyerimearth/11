package com.model2.mvc.web.product;

import java.io.File;
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
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.review.ReviewService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{commonProperties['fileDirectory']}")
	String fileDirectory;
	
	public ProductController() {
		System.out.println(this.getClass().getName()+"컨트롤러 생성자");
	}

	@RequestMapping(value="addProduct", method=RequestMethod.POST) // 항상 post로만 등록가능
	public String addProduct(@ModelAttribute("product") Product product,
					@RequestParam("multifile") List<MultipartFile> multipartFile) throws Exception
	{
		System.out.println("/product/addProduct");
		//System.out.println("multipartFile :_"+multipartFile+"_");
		//System.out.println(multipartFile.get(1).getOriginalFilename());
		//System.out.println(multipartFile.size());
		//String [] fileName = new String[3];
		
		String fileName= null;
		
		for(int i=0;i <multipartFile.size(); i++)
		{
			if(i==0) //이게 최선의 방법일까
			{
				
				System.out.println("0");
				fileName = multipartFile.get(0).getOriginalFilename();
				multipartFile.get(0).transferTo(new File(fileDirectory+fileName));
				product.setFileName1(fileName);
				
			}
			if(i==1) //
			{
				System.out.println("1");
				fileName = multipartFile.get(1).getOriginalFilename();
				product.setFileName2(fileName);
				multipartFile.get(1).transferTo(new File(fileDirectory+fileName));

			}
			if(i==2) //
			{
				System.out.println("2");
				fileName = multipartFile.get(2).getOriginalFilename();
				product.setFileName3(fileName);
				multipartFile.get(2).transferTo(new File(fileDirectory+fileName));
			}
		}
		//System.out.println(multipartFile.getName()); //attribute name의 값
		//System.out.println(multipartFile.getOriginalFilename());//파일의 name
		
		//product.setFileName(multipartFile.getOriginalFilename());
		
		productService.addProduct(product); // 그럼 product만 보내줘도 된다.
		
		//productService.addImages(product.getProdNo(),multipartFile); //도 사실은  service단에 있으면 안되는데,트랜젝션처리가 service단위
		
		return "forward:/product/addProductResultView.jsp";
	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct(@RequestParam("prodNo") String prodNo,HttpSession session,HttpServletRequest request,
									HttpServletResponse response,Model model) throws Exception
	{
		System.out.println("/product/getProduct");
		
		Product vo = productService.getProduct(Integer.parseInt(prodNo));

		String cookieString =this.addCookie(prodNo, request, response); // addCookie method화
		
		System.out.println(cookieString);
		
		session.setAttribute("vo", vo);
		/////////////////////////////////////////////////review
		List<Review> reviewList = reviewService.getReviewList(Integer.parseInt(prodNo));
		System.out.println("reviewList:"+reviewList);
		
		String menu = (String) session.getAttribute("menu");
		model.addAttribute("list", reviewList);
		
		System.out.println(menu);
		
		if(menu.equals("manage"))
			return "forward:/product/updateProduct"; // 이렇게 들어오면 ----
		else
			return "forward:/product/readProduct.jsp";
		
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET) // 위에서 getProduct가 get방식. forward하면 유지
	public String updateProduct()
	{
		System.out.println("/product/updateProductView 실행");
		
		return "forward:/product/updateProductView.jsp";
	}
	
	@RequestMapping(value="updateProduct",method=RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product, HttpSession session,
						Model model,@RequestParam("multifile") MultipartFile multipartFile) throws Exception
	{
		System.out.println("/product/updateProduct 실행 했다리!");
		
		Product sessionProduct = (Product) session.getAttribute("vo");
		
		product.setProdNo(sessionProduct.getProdNo());
		product.setRegDate(sessionProduct.getRegDate());
		//product.setFileName(multipartFile.getOriginalFilename());
		
		productService.updateProduct(product);
		
		model.addAttribute("vo", product);
		
		return "forward:/product/readProduct2.jsp";
	}
	
	@RequestMapping("listProduct") //기존 listProduct trancode때문인것같은데 필요없댜
	public String listProduct(@ModelAttribute("search") Search search,Model model,HttpSession session,
									@RequestParam("menu") String menu) throws Exception
	{
		System.out.println("/product/listProduct");
		System.out.println(search);
		System.out.println(search.getOrderCondition());
		if(search.getOrderCondition()== null)
		{
			search.setOrderCondition("0"); //원래 처음 정렬(prod_no)  1 높은가격순 2 낮은가격순
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
		//model.addAttribute("search", search);
		//System.out.println(search);
		session.setAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping("listProduct2") //수정 listProduct
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

			return "forward:/product/listProduct2.jsp"; //판매상품관리로 forward
	}
	
	@RequestMapping(value="bestSellerList", method = RequestMethod.GET)
	public String bestSellerList(Model model,@RequestParam("menu") String menu,
									HttpSession session)
	{
		session.setAttribute("menu", menu);
		
		System.out.println("/product/bestSellerList");
		
		// search 필요없다.페이지는 무조건 1개로 놓을거기 때문에.
		
		List<Product> list = productService.getBestSellerList();
		
		model.addAttribute("list", list);
		
		return "forward:/product/bestSellerList.jsp";
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
