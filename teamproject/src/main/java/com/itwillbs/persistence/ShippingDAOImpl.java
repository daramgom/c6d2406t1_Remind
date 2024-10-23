package com.itwillbs.persistence;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.OrdersVO;
import com.itwillbs.domain.ShippingVO;

@Repository
public class ShippingDAOImpl implements ShippingDAO {
    private static final Logger logger = LoggerFactory.getLogger(ShippingDAOImpl.class);

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.itwillbs.mapper.ShippingMapper";

    @Override
    public void insertShippingRequest(ShippingVO shippingVO) {
        int result = sqlSession.insert(NAMESPACE + ".insertShippingRequest", shippingVO);
        logger.debug("출고 요청 정보 디비 등록 결과: {}", result);
    }

    @Override
    public OrdersVO getShippingInfoByOrderNumber(String order_number) {
        OrdersVO orders = sqlSession.selectOne(NAMESPACE + ".getShippingInfoByOrderNumber", order_number);
        logger.debug("Fetched OrdersVO: {}", orders);
        return orders;
    }
    
    @Override
    public List<OrdersVO> getAllOrderRequests() {
    	List<OrdersVO> ordersList = sqlSession.selectList(NAMESPACE + ".getAllOrderRequests");
        logger.info("발주 목록 조회 완료! 총 개수: {}", ordersList.size());
        return ordersList;
    }

    // 모든 출고 요청 내역 조회
    @Override
    public List<ShippingVO> getAllShippingRequests() {
        List<ShippingVO> shippingRequests = sqlSession.selectList(NAMESPACE + ".getAllShippingRequests");
        logger.debug("Fetched all Shipping Requests: {}", shippingRequests);
        return shippingRequests;
    }

    // 출고 요청 업데이트
    @Override
    public void updateShipping(ShippingVO shippingVO) {
        int result = sqlSession.update(NAMESPACE + ".updateShipping", shippingVO);
        logger.debug("출고 요청 업데이트 결과: {}", result);
    }

    // 출고 반려
    @Override
    public void rejectShipping(String shp_number) {
        int result = sqlSession.update(NAMESPACE + ".rejectShipping", shp_number);
        logger.debug("출고 반려 결과: {}", result);
    }

    // 출고 수정
    @Override
    public void editShipping(ShippingVO shippingVO) {
        int result = sqlSession.update(NAMESPACE + ".editShipping", shippingVO);
        logger.debug("출고 수정 결과: {}", result);
    }

    // 출고 삭제
    @Override
    public void deleteShipping(String shp_number) {
        int result = sqlSession.delete(NAMESPACE + ".deleteShipping", shp_number);
        logger.debug("출고 삭제 결과: {}", result);
    }

    // 출고 상태로 검색
    @Override
    public List<ShippingVO> getShippingByStatus(String shp_status) {
        List<ShippingVO> shippingList = sqlSession.selectList(NAMESPACE + ".getShippingByStatus", shp_status);
        logger.debug("Fetched Shipping by status {}: {}", shp_status, shippingList);
        return shippingList;
    }
    //출고 재고
	@Override
	public void updateStockForShipping(ShippingVO shipping) {
        int result = sqlSession.update(NAMESPACE + ".updateStockForShipping", shipping);
        logger.info("재고 정보 추가 완료! 결과: {}", result);
		
	}

	@Override
	public OrdersVO getOrdersName(String ord_number) {
		OrdersVO result = sqlSession.selectOne(NAMESPACE+".getOrdersName",ord_number);
		return result;
	}
}
