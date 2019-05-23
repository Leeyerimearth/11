package com.model2.mvc.web.review;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.review.ReviewService;

@RestController
@RequestMapping("/review/*")
public class ReviewRestController {

	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public ReviewRestController() {
		System.out.println(this.getClass().getName()+"������");
	}
	
	@RequestMapping(value="/json/addReview", method = RequestMethod.POST)
	public void addReview(@RequestBody Review review,HttpSession session) throws Exception
	{
		System.out.println("/json/addReview :: POST ���");
		System.out.println(review);
		
		User user = (User) session.getAttribute("user");
		review.setWriterId(user.getUserId());
		
		reviewService.addReview(review); //�����ۼ��� ���並 review ���̺� ���ϰ�,
		Purchase purchase = purchaseService.getPurchase(review.getTranNo());// �����ۼ��� ��ǰ������ tranNo����ǰ�� ��������
		purchase.setReviewCode("added"); //���䰡 ���� �ۼ��Ǿ����ϴ�.
		purchaseService.updateReviewCode(purchase);//transaction table�� review �ڵ带 'Y'�� ����
	}
	
	public void getReview()
	{
		System.out.println("/json/getReview ::");
	}

}
