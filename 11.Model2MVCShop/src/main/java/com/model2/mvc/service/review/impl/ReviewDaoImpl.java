package com.model2.mvc.service.review.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.review.ReviewDao;

@Service("reviewDaoImpl")
public class ReviewDaoImpl implements ReviewDao{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public ReviewDaoImpl() {
		
		System.out.println(this.getClass().getName()+"의 생성자 시작");
	}

	@Override
	public void insertReview(Review review) {
		sqlSession.insert("ReviewMapper.addReview", review);
		
	}

	@Override
	public List<Review> getReviewList(int prodNo) {
		
		return sqlSession.selectList("ReviewMapper.getReviewList",prodNo);
	}

}
