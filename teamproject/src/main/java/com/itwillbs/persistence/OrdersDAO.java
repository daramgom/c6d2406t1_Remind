package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.OrdersVO;

public interface OrdersDAO {
	public int insert(OrdersVO ordersVO);
	
	public List<OrdersVO> listOrder();
	
	void updateOrder(/* Map<String, Object> data, */ OrdersVO ordersVO);
	
	public Integer deleteOrder(OrdersVO ordersVO);
}
