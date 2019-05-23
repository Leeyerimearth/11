package com.model2.mvc.service.review.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.review.ReviewDao;
import com.model2.mvc.service.review.ReviewService;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	@Qualifier("reviewDaoImpl")
	private ReviewDao reviewDao;
	
	public void setReviewDao(ReviewDao reviewDao) {
		this.reviewDao = reviewDao;
	}

	public ReviewServiceImpl() {
		
		System.out.println(this.getClass().getName() + "의 생성자 시작");
	}

	@Override
	public void addReview(Review review) {
		
		reviewDao.insertReview(review);
	}

	@Override
	public List<Review> getReviewList(int prodNo) {
		
		return reviewDao.getReviewList(prodNo);
	}

}
