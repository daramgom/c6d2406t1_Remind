package com.itwillbs.service;

import com.itwillbs.domain.ReceivingVO;

public interface ReceivingService {
	
	//사용자의 입고 요청 처리 로직을 구현
	
	//입고요청 동작
	public void rcvRQ(ReceivingVO VO);

}
