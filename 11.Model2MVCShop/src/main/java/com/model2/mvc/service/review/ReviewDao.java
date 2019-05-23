package com.model2.mvc.service.review;

import java.util.List;

import com.model2.mvc.service.domain.Review;

public interface ReviewDao {

	public void insertReview(Review review);
	
	public List<Review> getReviewList(int prodNo);
}
