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
	public List<OrdersVO> listOrder02() {
		return sqlSession.selectList(NAMESPACE+".listOrder02");
	}
	
	// 발주 정보 수정(재요청)
	@Override
	public void updateOrder(/* Map<String, Object> data, */ OrdersVO ordersVO) {
		sqlSession.update(NAMESPACE+".updateOrder", ordersVO/*data*/);
	}
	
	// 발주 정보 삭제
	@Override
	public void deleteOrder(OrdersVO ordersVO) {
		
		sqlSession.update(NAMESPACE+".deleteOrder", ordersVO);
	}
	
	// 발주 승인
	@Override
	public void updateOrder03(OrdersVO ordersVO) {
		sqlSession.update(NAMESPACE+".updateOrder03", ordersVO);
	}
	
	// 발주 반려
	@Override
	public void updateOrder02(OrdersVO ordersVO) {
		sqlSession.update(NAMESPACE+".updateOrder02", ordersVO);
	}
	
	// 거래처 발주 처리
	@Override
	public void updateOrder05(OrdersVO ordersVO) {
		sqlSession.update(NAMESPACE+".updateOrder05", ordersVO);
	}
	
	// 거래처 발주 반려
	@Override
	public void updateOrder04(OrdersVO ordersVO) {
		sqlSession.update(NAMESPACE+".updateOrder04", ordersVO);
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
