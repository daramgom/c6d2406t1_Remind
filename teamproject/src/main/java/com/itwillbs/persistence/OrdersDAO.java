package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.OrdersVO;

public interface OrdersDAO {
	public int insert(OrdersVO ordersVO);
	
	public List<OrdersVO> listOrder();
	
	public List<OrdersVO> listOrder02();
	
	// 발주 정보 수정(재요청)
	void updateOrder(/* Map<String, Object> data, */ OrdersVO ordersVO);
	
	// 발주 정보 삭제
	void deleteOrder(OrdersVO ordersVO);
	
	// 발주 승인
	void updateOrder03(OrdersVO ordersVO);
	
	// 발주 반려
	void updateOrder02(OrdersVO ordersVO);
	
	// 거래처 발주 처리
	void updateOrder05(OrdersVO ordersVO);
	
	// 거래처 발주 반려
	void updateOrder04(OrdersVO ordersVO);
	
	public List<OrdersVO> listManager();
	
	public List<OrdersVO> listSupervisor();
	
	public List<OrdersVO> listProd();
	
	public List<OrdersVO> listWarehouse();
	
	
}
