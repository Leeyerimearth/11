package com.model2.mvc.web.purchase;

import java.util.Map;

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

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserDao;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired // point update
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public PurchaseController() {
		System.out.println(this.getClass()+"��Ʈ�ѷ� ������");
	}
	
	@RequestMapping(value="addPurchase",method=RequestMethod.POST)
	public String addPurchase(HttpSession session,@RequestParam("usePoint") int usePoint,
								@ModelAttribute("purchase") Purchase purchase,Model model) throws Exception
	{
		System.out.println("/purchase/addPurchase POST���");
		
		User user = (User) session.getAttribute("user");
		
		
		Product product = (Product) session.getAttribute("vo");
		
	
		//////////////////////////////////////////////////////////�������Ʈ����
		if(usePoint > 0) {
			
			int updatePoint = user.getUserPoint()-usePoint;
			System.out.println("updatePoint : "+updatePoint);
			user.setUserPoint(updatePoint); // ����Ʈ���
		
			userService.updateUser(user,"subPoint"); //user update//
		}
		////////////////////////////////////////////////////////////////////
		
		// �׷��� �� ������ �ݾ� -> ���߿� user table�� ��������.. �̰��� �󸶳� �����(��ۿϷ��ϸ�)
		// �׸��� transaction table�� ������? colum�߰��ؼ�. �׷��� ���߿� ����Ʈ ���϶�, �����ͼ� �ű⼭ 0.02���θ�������
		int resultPayMoney = purchase.getBuyQuantity()*product.getPrice() - usePoint;
		
		//�� ���Ű��� ������ userDB, addPurchaseTable.jsp����
		
		//product.setQuantity(quantity);
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		
		////////////////////////////////////////////////////
		purchase.setPayAmount(resultPayMoney); //purchase
		////////////////////////////////////////////////////
		
		model.addAttribute("requestPvo", product);
		purchaseService.addPurchase(purchase);
		
		
		return "forward:/purchase/addPurchaseTable.jsp";
	}
	
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public String addPurchase(@RequestParam(value="prodNo",required = false)int prodNo , HttpSession session) throws Exception
	{
		System.out.println("/purchase/addPurchase GET���");
		
		if(prodNo!=0) //������ prodNo �ʿ���� �׳� navigation, getProduct �ǳʶٰ� �Ѿ�� getProduct �ؾ��Ѵ�.
		{	
			Product product = productService.getProduct(prodNo);
			session.setAttribute("vo", product);
		}
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public String getPurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception
	{
		System.out.println("/purchase/getPurchase");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		System.out.println(purchase.getTranCode());
		return "forward:/purchase/getPurchase.jsp";
	}
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public String updatePurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception
	{
		System.out.println("/purchase/updatePurchase GET ���");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	@RequestMapping(value="updatePurchase", method = RequestMethod.POST)
	public String updatePurchase(@RequestParam("tranNo") int tranNo,
							@ModelAttribute("purchase") Purchase purchase,Model model) throws Exception
	{
		System.out.println("/purchase/updatePurchase POST ���");
		
		Purchase sqlPurchase = purchaseService.getPurchase(tranNo);
		sqlPurchase.setPaymentOption(purchase.getPaymentOption());
		sqlPurchase.setReceiverName(purchase.getReceiverName());
		sqlPurchase.setReceiverPhone(purchase.getReceiverPhone());
		sqlPurchase.setDivyAddr(purchase.getDivyAddr());
		sqlPurchase.setDivyRequest(purchase.getDivyRequest());
		sqlPurchase.setDivyDate(purchase.getDivyDate().substring(0, 10));
		
		purchaseService.updatePurcahse(sqlPurchase);
		sqlPurchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", sqlPurchase);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	@RequestMapping("listPurchase")
	public String listPurchase(HttpSession session,
								@ModelAttribute("search") Search search,Model model) throws Exception
	{
		
		System.out.println("/purchase/listPurchase");
		
		Map<String,Object> map = null;
		
		User user = (User) session.getAttribute("user");
		System.out.println(user);
		
		
		if(search.getCurrentPage()==0)
		{
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize); // �ϸ� start end rownum ����
		
		//String admin = "1";
		
		//if(user.getRole().equals("admin"))// admin�̸� null ������, transaction table �ٰ����� //�ٵ� admin�� ���������� �������ڳ�
			//map = purchaseService.getPurchaseList(search, admin);
		//else
			map = purchaseService.getPurchaseList(search, user.getUserId());
		
		Page resultPage = 
				new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(),pageUnit,pageSize);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("resultPage", resultPage);
		
		//return�� �ٸ��� �������
		
		if(user.getRole().equals("admin"))
			return "forward:/purchase/listPurchase.jsp";   // ���� new jsp
		else // �Ϲ� ����
			return "forward:/purchase/listUserPurchase.jsp"; 
	}
	
	@RequestMapping("listSale")
	public String listSale(@ModelAttribute("search") Search search, HttpSession session,
								@RequestParam("menu") String menu,Model model) throws Exception
	{
		System.out.println("/purchase/listSale");
		
		if(search.getCurrentPage()==0)
		{
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		Map<String,Object> map = purchaseService.getSaleList(search);
		session.setAttribute("menu", menu);
		
		Page resultPage = 
				new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(),pageUnit,pageSize);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("resultPage", resultPage);
		
		return "forward:/product/listProduct2.jsp";
	}
	
	@RequestMapping(value= "updateTranCode" , method= RequestMethod.GET)
	public String updateTranCode(@RequestParam("tranNo") int tranNo, HttpSession session,
								@RequestParam(value="tranCode",required = false) String tranCode) throws Exception
	{
		
		System.out.println("/purchase/updateTranCode");
		System.out.println("tranCode: " +tranCode);
		
		
		//Purchase purchase = purchaseService.getPurchase2(prodNo);
		User user = (User) session.getAttribute("user");
		Purchase purchase = purchaseService.getPurchase(tranNo); //tranNo�� ����
	
		
		if(tranCode.equals("005")) //��������϶�
		{
			
			purchase.setTranCode(tranCode); //������Ҵ� VO tranCode��  005�μ���
			purchase.setPayAmount(0);
			if(purchase.getPaymentOption().equals("ca"))
			{
				purchase.setPaymentOption("1");
			}
			else
				purchase.setPaymentOption("2");
			purchaseService.updatePurcahse(purchase); //��������ϸ� pay_amount�� 0�� ��������
		}
		
		purchaseService.updateTranCode(purchase);// tranCode set�� ���⼭
		
		////////////////////////////////////////////////////////////////////////////2%point����(��ۿϷ������)
		if( Integer.parseInt(purchase.getTranCode())==2) //002�����~~~> 003��ۿϷ� �ϸ�~
		{
			//��ۿϷ��̸�, getproduct�ؼ�, userPoint update
			Product product =productService.getProduct(purchase.getPurchaseProd().getProdNo());
			
			//���Ӱ� �߰��� ����Ʈ
			int newPoint = (int)(purchase.getBuyQuantity()*product.getPrice()*(0.02));
			System.out.println("userPoint!!! : "+newPoint);
			user.setUserPoint(newPoint);
			
			//transaction�� pay_amount�� user Table�� new user total_Payment�� �������� �����ش�.
			//�̰� ��Ʈ�ѷ����� ���ִ°� ������? ��Ʈ�ѷ��� ����  // userTotal payment  ��ۿϷ��϶� �ٲ۴�.
			user.setTotalPayment(user.getTotalPayment()+purchase.getPayAmount());
			// 						������ tatalPayment + ��ǰ������ ���� ������ ��
			
			userService.updateUser(user,"addPoint"); //updateUser�� ����ұ�? DB�����ϳ�??
			/////////////////////////////////////////////////////////////////////////
	
		}	
		//if(user.getUserId().equals("admin")) ���� �ֳĸ� user�� admin�̵� listPurchase.do�� �����ִ�.
			//return "forward:/listSale.do";
		//else
			return "forward:/purchase/listPurchase";
	}

	//@RequestMapping("/updateTranCodeByProd.do") �ƴ� ���ֳİ�?
	//public String updateTranCodeByProd()
	//{
		
	//}
}
