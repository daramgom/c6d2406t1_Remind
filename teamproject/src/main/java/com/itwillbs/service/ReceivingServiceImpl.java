package com.itwillbs.service;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.itwillbs.domain.ReceivingVO;
import com.itwillbs.persistence.ReceivingDAO;

public class ReceivingServiceImpl implements ReceivingService  {

	// ReceivingDAO 객체 주입
	
	@Autowired 
	ReceivingDAO receivingDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(ReceivingServiceImpl.class);
	
	@Override
	public void rcvRQ(ReceivingVO VO) {
		logger.debug("컨트롤러->서비스");
		logger.debug("입고요청 메서드  rcvRQ(ReceivingVO VO) 실행 ");
		
		logger.debug("서비스->DAO");
		receivingDAO.insertRcv(VO);
		logger.debug("DAO->서비스");
		logger.debug("서비스->컨트롤러");
	
		
	}

}
