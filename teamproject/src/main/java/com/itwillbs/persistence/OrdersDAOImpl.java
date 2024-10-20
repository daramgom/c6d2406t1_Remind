package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.OrdersVO;

@Repository
public class OrdersDAOImpl implements OrdersDAO{
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.OrderMapper";
	
	/*
	 * @Override public void insertOrders(OrdersVO vo) { int result =
	 * sqlSession.insert(NAMESPACE + ".insertOrder", vo); }
	 */
	
	@Override
	public int insert(OrdersVO ordersVO) {
		int result = sqlSession.insert(NAMESPACE+".insert", ordersVO);
		
		System.out.println("result = "+result);
		
		return result;
	}
	
	@Override
	public List<OrdersVO> listOrder() {
		
		return sqlSession.selectList(NAMESPACE+".listOrder");
	}
	
	@Override
	public void updateOrder(/* Map<String, Object> data, */ OrdersVO ordersVO) {
		sqlSession.update(NAMESPACE+".updateOrder", ordersVO/*data*/);
	}
	
	@Override
	public void deleteOrder(OrdersVO ordersVO) {
		
		sqlSession.update(NAMESPACE+".deleteOrder", ordersVO);
	}
	
	@Override
	public void updateOrder03(OrdersVO ordersVO) {
		sqlSession.update(NAMESPACE+".updateOrder03", ordersVO);
	}
	
	@Override
	public void updateOrder02(OrdersVO ordersVO) {
		sqlSession.update(NAMESPACE+".updateOrder02", ordersVO);
	}
	
	@Override
	public List<OrdersVO> listManager() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE+".listManager");
	}
	
	@Override
	public List<OrdersVO> listSupervisor() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE+".listSupervisor");
	}
	
	@Override
	public List<OrdersVO> listProd() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE+".listProd");
	}
	
	@Override
	public List<OrdersVO> listWarehouse() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE+".listWarehouse");
	}
	
}
