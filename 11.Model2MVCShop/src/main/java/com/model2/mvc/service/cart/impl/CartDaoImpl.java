package com.model2.mvc.service.cart.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.cart.CartDao;
import com.model2.mvc.service.domain.Cart;

@Service("cartDaoImpl")
public class CartDaoImpl implements CartDao{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public CartDaoImpl() {
		System.out.println(this.getClass().getName()+"������ �Դϴ�.");
	}

	@Override
	public void insertCart(Cart cart) {
		
		sqlSession.insert("CartMapper.insertCart", cart);
	}

}