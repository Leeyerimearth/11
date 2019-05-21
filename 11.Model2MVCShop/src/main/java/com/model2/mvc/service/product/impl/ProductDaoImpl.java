package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;


@Repository("productDaoImpl") // �� ���� �Ѵ� . ���ص� ����Ʈ!
public class ProductDaoImpl implements ProductDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession)
	{
		this.sqlSession = sqlSession;
	}
	
	public ProductDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Product findProduct(int prodNo) {
		// TODO Auto-generated method stub
		
		return sqlSession.selectOne("ProductMapper.findProduct", prodNo);
	}

	@Override
	public List<Product> getProductList2(Search search) {
		// TODO Auto-generated method stub
		System.out.println("�갡 ��� ���ٿ��°� ����.");
		return null;
	}

	@Override
	public List<Product> getProductList(Search search) {
		// TODO Auto-generated method stub
		//search.setSearchKeyword("%"+search.getSearchKeyword()+"%");
		return sqlSession.selectList("ProductMapper.getProductList", search);
	}

	@Override
	public void insertProduct(Product product) {
		// TODO Auto-generated method stub
		System.out.println(product +"productDAOIMPL");
		sqlSession.insert("ProductMapper.insertProduct",product);
	}

	@Override
	public void updateQuantity(Product product,int buyQuantity) { // HashMap map) {
		
		Product getProduct=this.findProduct(product.getProdNo());
		int prodQuantity = getProduct.getQuantity() - buyQuantity;//product.getQuantity();
		
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("prodQuantity", prodQuantity);
		map.put("prodNo", product.getProdNo());
		// TODO Auto-generated method stub
		// ���⼭ findProduct�θ��� map���� ������ ����. product�� ,prodQuantity -> serviceImlp���� �Ѵ���
		//product��꿡 Hashmap�� ���޹ް� �װ� �ٽ� �����Ѵ�. Hashmap����, findProduct�� �ҷ� ���� product��,quantity�� string�� ����Ǿ��ִ�.
		sqlSession.update("ProductMapper.updateQuantity", map); //purchase�Ҷ� ���ȴ�.
															//map
	}

	@Override
	public void updateProduct(Product product) {
		// TODO Auto-generated method stub
		sqlSession.update("ProductMapper.updateProduct", product);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		//search.setSearchKeyword("%"+search.getSearchKeyword()+"%");
		return sqlSession.selectOne("ProductMapper.getTotalCount",search);
	}

	@Override
	public void updateSaleQuantity(Product product,int saleQuantity) {
		// TODO Auto-generated method stub
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("saleQuantity",saleQuantity);
		map.put("prodNo", product.getProdNo());
		sqlSession.update("ProductMapper.updateSaleQuantity",map);
	}

	@Override
	public List<Product> getBestSellerList() {
		// TODO Auto-generated method stub
		
		return sqlSession.selectList("ProductMapper.getBestSellerList");
	}

	@Override
	public List<String> getAllProductList(Search search) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ProductMapper.getAllProductList", search);
	}

}
