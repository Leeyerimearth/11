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
		System.out.println(this.getClass().getName()+"생성자");
	}
	
	@RequestMapping(value="/json/addReview", method = RequestMethod.POST)
	public void addReview(@RequestBody Review review,HttpSession session) throws Exception
	{
		System.out.println("/json/addReview :: POST 방식");
		System.out.println(review);
		
		User user = (User) session.getAttribute("user");
		review.setWriterId(user.getUserId());
		
		reviewService.addReview(review); //새로작성된 리뷰를 review 테이블에 더하고,
		Purchase purchase = purchaseService.getPurchase(review.getTranNo());// 리뷰작성한 제품에대한 tranNo의제품을 가져오고
		purchase.setReviewCode("added"); //리뷰가 새로 작성되었습니다.
		purchaseService.updateReviewCode(purchase);//transaction table의 review 코드를 'Y'로 변경
	}
	
	public void getReview()
	{
		System.out.println("/json/getReview ::");
	}

}
