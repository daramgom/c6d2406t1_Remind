package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.OrdersVO;

public interface OrdersDAO {
	public int insert(OrdersVO ordersVO);
	
	public List<OrdersVO> listOrder();
	
	void updateOrder(OrdersVO ordersVO);
}
