package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.OrdersVO;

public interface OrdersService {
	
	/* 발주 요청 정보 입력 */
	/* 발주 요청 시 정보 입력 직후 관리번호 생성 */
	public int insert(OrdersVO ordersVO);
	
	public List<OrdersVO> listOrder();
	
	public void updateOrder(/* Map<String, Object> data, */ OrdersVO ordersVO);
	
	public void deleteOrder(OrdersVO ordersVO);
	
	public void updateOrder03(OrdersVO ordersVO);
	
	public void updateOrder02(OrdersVO ordersVO);
	
	
}
