package com.model2.mvc.service.cart.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.cart.CartDao;
import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;

@Service("cartServiceImpl")
public class CartServiceImpl implements CartService{

	@Autowired
	@Qualifier("cartDaoImpl")
	private CartDao cartDao;
	
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	public void setCartDao(CartDao cartDao) {
		this.cartDao = cartDao;
	}

	public CartServiceImpl() {
		System.out.println(this.getClass().getName()+"������ �����̿����!");
	}

	@Override
	public void addCart(Cart cart) {
		
		cartDao.insertCart(cart);
	}

	@Override
	public List<Cart> getMyCartList(String userId) { // ���DB���� ����� �ϴ°Ͱ����� ��.
			
		List<Cart> myCartList = cartDao.getMyCartList(userId);
		for(int i=0;i < myCartList.size(); i++)
		{
			Cart cart = myCartList.get(i);
			Product product = productDao.findProduct(cart.getCartProduct().getProdNo());
			//list�� �� �� product�� prodNo�� ������ product ��ü�� ������ �����´�.
			cart.setCartProduct(product); // product�� set���ְ�
			myCartList.set(i, cart); // list�� �ٽ� ����.
		}
		
		return myCartList;
	}

	@Override
	public void deleteCart(String[] cartNos) {
	
		cartDao.deleteCart(cartNos);
	}

}
