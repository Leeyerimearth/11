package com.model2.mvc.service.cart.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.service.cart.CartDao;
import com.model2.mvc.service.domain.Cart;

@Repository("cartDaoImpl")
public class CartDaoImpl implements CartDao{


	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession)
	{
		this.sqlSession = sqlSession;
	}

	public CartDaoImpl() {
		System.out.println(this.getClass().getName()+"생성자 입니다!!!!!!!!!!!!!!");
	}

	@Override
	public void insertCart(Cart cart) {
		
		sqlSession.insert("CartMapper.insertCart", cart);
	}

	@Override
	public List<Cart> getMyCartList(String userId) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CartMapper.getMyCartList", userId);
	}

}
