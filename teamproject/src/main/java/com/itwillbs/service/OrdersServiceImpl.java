package com.itwillbs.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.OrdersVO;
import com.itwillbs.persistence.OrdersDAO;

@Service
public class OrdersServiceImpl implements OrdersService{
	
	@Autowired
	private OrdersDAO odao;
	
	private static final Logger logger = LoggerFactory.getLogger(OrdersServiceImpl.class);
	
	
	
	
	
	
	@Override
	public int insert(OrdersVO ordersVO) {
		
		int result = odao.insert(ordersVO);
		
//		StringBuilder orderSb = new StringBuilder();
//		
//		LocalDateTime now = LocalDateTime.now();
//		
//		DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy");
//		
//		if(ordersVO.getOrd_count() == 0) {
//		orderSb.append("ord-").append(now.format(dateFormat)).append("-1");
//		} else {
//			orderSb.append("ord-").append(now.format(dateFormat)).append("-").append(ordersVO.getOrd_count());
//		}
//		
//		ordersVO.setOrd_number(orderSb.toString());
		
//		result = odao.insert(ordersVO);
		
		//orderSb.setLength(0);
		
		logger.debug("@@@@@@@@@@@@ordersVO.count:"+ordersVO.getOrd_count());
		logger.debug("@@@@@@@@@@@@ordersVO.number:"+ordersVO.getOrd_number());
		logger.debug("@@@@@@@@@@@@ordersVO.date:"+ordersVO.getOrd_date());
		logger.debug("@@@@@@@@@@@@ordersVO.prod_id:"+ordersVO.getProd_id());
		
		return result;
	}
	
	
	
	@Override
	public List<OrdersVO> listOrder() {
		
		return odao.listOrder();
	}
	
	@Override
	public List<OrdersVO> listOrder02() {
		
		return odao.listOrder02();
	}
	
	// 발주 정보 수정(재요청)
	@Override
	public void updateOrder(/* Map<String, Object> data, */ OrdersVO ordersVO) {
		odao.updateOrder(/* data, */ ordersVO);
	}
	
	// 발주 정보 삭제
	@Override
	public void deleteOrder(OrdersVO ordersVO) {
		odao.deleteOrder(ordersVO);
	}
	
	// 발주 승인
	@Override
	public void updateOrder03(OrdersVO ordersVO) {
		odao.updateOrder03(ordersVO);
	}
	
	// 발주 반려
	@Override
	public void updateOrder02(OrdersVO ordersVO) {
		odao.updateOrder02(ordersVO);
	}
	
	// 거래처 발주 처리
	@Override
	public void updateOrder05(OrdersVO ordersVO) {
		odao.updateOrder05(ordersVO);
	}
	
	// 거래처 발주 반려
	@Override
	public void updateOrder04(OrdersVO ordersVO) {
		odao.updateOrder04(ordersVO);
	}
	
	@Override
	public List<OrdersVO> listManager() {
		// TODO Auto-generated method stub
		return odao.listManager();
	}
	
	@Override
	public List<OrdersVO> listSupervisor() {
		// TODO Auto-generated method stub
		return odao.listSupervisor();
	}
	
	@Override
	public List<OrdersVO> listProd() {
		// TODO Auto-generated method stub
		return odao.listProd();
	}
	
	@Override
	public List<OrdersVO> listWarehouse() {
		// TODO Auto-generated method stub
		return odao.listWarehouse();
	}
	
}
