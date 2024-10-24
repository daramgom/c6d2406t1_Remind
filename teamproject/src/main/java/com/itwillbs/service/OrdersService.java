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
	
	public List<OrdersVO> listOrder02();
	
	// 발주 정보 수정(재요청)
	public void updateOrder(/* Map<String, Object> data, */ OrdersVO ordersVO);
	
	// 발주 정보 삭제
	public void deleteOrder(OrdersVO ordersVO);

	// 발주 승인
	public void updateOrder03(OrdersVO ordersVO);
	
	// 발주 반려
	public void updateOrder02(OrdersVO ordersVO);
	
	// 거래처 발주 처리
	public void updateOrder05(OrdersVO ordersVO);
	
	// 거래처 발주 반려
	public void updateOrder04(OrdersVO ordersVO);
	
	public List<OrdersVO> listManager();
	
	public List<OrdersVO> listSupervisor();
	
	public List<OrdersVO> listProd();
	
	public List<OrdersVO> listWarehouse();
	
}
