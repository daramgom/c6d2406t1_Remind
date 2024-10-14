package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.OrdersVO;

public interface OrdersService {
	
	/* 발주 요청 정보 입력 */
	/* 발주 요청 시 정보 입력 직후 관리번호 생성 */
	public int insert(OrdersVO ordersVO);
	
	public List<OrdersVO> listOrder();
	
	public void updateOrder(OrdersVO ordersVO);
}
