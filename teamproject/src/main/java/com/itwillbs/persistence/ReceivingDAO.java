package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.OrdersVO;
import com.itwillbs.domain.ReceivingVO;

public interface ReceivingDAO {
	public void insertRcv(ReceivingVO VO);//요청
	
    public OrdersVO getReceivingByOrderNumber(String ord_number); // 발주 관리번호로 제품 식별 코드 가져오기

    public List<ReceivingVO> getAllReceivingRequests(); // 입고 상세정보 출력 (입고)
    
    public List<OrdersVO> getAllOrderRequests(); // 출고 상세정보 출력 (출고)
 
    void updateReceiving(ReceivingVO receiving); // 승인
    
    public void rejectReceiving(String rcv_number); // 반려
    
    void editReceiving(ReceivingVO receiving); // 수정
    
    void deleteReceiving(String rcv_number); //삭제
    
    void insertIntoStock(ReceivingVO receiving); //재고
    
    public List<ReceivingVO> getReceivingByStatus(String rcv_status); // 검색!
    
    public OrdersVO getOrdersName(String ord_number);
    
    public List<OrdersVO> getOrders(); // 전체 발주목록
    
    public List<OrdersVO>getRcvSupervisorInfo();
    
    
    
    }


    


