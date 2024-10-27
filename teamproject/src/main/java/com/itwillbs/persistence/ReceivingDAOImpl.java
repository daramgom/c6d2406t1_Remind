package com.itwillbs.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.OrdersVO;
import com.itwillbs.domain.ReceivingVO;
import com.itwillbs.web.RcvController;

@Repository
public class ReceivingDAOImpl implements ReceivingDAO {
	 private static final Logger logger = LoggerFactory.getLogger(RcvController.class);

    @Autowired
    private SqlSession sqlSession;
    
    private static final String NAMESPACE = "com.itwillbs.mapper.ReceivingMapper";

    @Override
    public void insertRcv(ReceivingVO VO) {
        int result = sqlSession.insert(NAMESPACE + ".insertRcv", VO);
        
        System.out.println("Dao: " + result);
        System.out.println("Dao: 입고 요청 정보 디비 등록!");
    }
    
    @Override
    public OrdersVO getReceivingByOrderNumber(String ord_number) {
    	
        OrdersVO orders = sqlSession.selectOne(NAMESPACE + ".getReceivingByOrderNumber", ord_number);
        
        logger.debug("Fetched OrdersVO: {}", orders); // 이 시점에서 orders 객체가 정의됨
        return orders; // 반환
    }

    public List<ReceivingVO> getAllReceivingRequests() {
        List<ReceivingVO> receivingList = sqlSession.selectList(NAMESPACE + ".getAllReceivingRequests");
        logger.info("입고 목록 조회 완료! 총 개수: {}", receivingList.size());
        return receivingList;
}
    
    @Override
    public List<OrdersVO> getAllOrderRequests() {
    	List<OrdersVO> ordersList = sqlSession.selectList(NAMESPACE + ".getAllOrderRequests");
        logger.info("발주 목록 조회 완료! 총 개수: {}", ordersList.size());
        return ordersList;
    }

    @Override
    public void updateReceiving(ReceivingVO receiving) {
        int result = sqlSession.update(NAMESPACE + ".updateReceiving", receiving);
        logger.info("입고 요청 정보 업데이트 완료! 결과: {}", result);
    }
    
    @Override
    public void rejectReceiving(String rcv_count) {
        int result = sqlSession.update(NAMESPACE + ".rejectReceiving", rcv_count);
        logger.info("입고 요청이 반려되었습니다! rcv_count: {}, 결과: {}", rcv_count, result);
    }

    @Override
    public void insertIntoStock(ReceivingVO receiving) {
        int result = sqlSession.insert(NAMESPACE + ".insertIntoStock", receiving);
        logger.info("재고 정보 추가 완료! 결과: {}", result);
    }

	@Override
	public List<ReceivingVO> getReceivingByStatus(String rcv_number) {
		return sqlSession.selectList(NAMESPACE + ".getReceivingByStatus", rcv_number);
	}
	
	@Override
	public void editReceiving(ReceivingVO receiving) {
	    int result = sqlSession.update(NAMESPACE + ".editReceiving", receiving);
	    logger.info("입고 정보 수정 완료! 결과: {}", result);
	}

	@Override
    public void deleteReceiving(String rcv_number) {
        int result = sqlSession.update(NAMESPACE + ".deleteReceiving", rcv_number);
        logger.info("입고 정보 삭제 완료! rcv_number: {}, 결과: {}", rcv_number, result);
    }

	@Override
	public OrdersVO getOrdersName(String ord_number) {
		OrdersVO result = sqlSession.selectOne(NAMESPACE+".getOrdersName",ord_number);
		
		return result;
	}

	@Override
	public List<OrdersVO> getOrders() {
	    List<OrdersVO> result = sqlSession.selectList(NAMESPACE + ".getOrders");
	    return result;
	}

	@Override
	public List<OrdersVO> getRcvSupervisorInfo() {
		List<OrdersVO> result =  sqlSession.selectList(NAMESPACE + ".getRcvSupervisorInfo");
		 return result;
	}
}
	
