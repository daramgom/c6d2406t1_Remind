package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.OrdersVO;
import com.itwillbs.domain.ReceivingVO;
import com.itwillbs.domain.ShippingVO;

public interface ShippingDAO {
    // 출고 요청 저장
    void insertShippingRequest(ShippingVO shippingVO);
    
    // 발주 관리번호로 제품 정보 가져오기
    OrdersVO getShippingInfoByOrderNumber(String order_number);

    // 모든 출고 요청 내역 조회
    List<ShippingVO> getAllShippingRequests();
    
    public List<OrdersVO> getAllOrderRequests(); 

    // 출고 요청 업데이트
    void updateShipping(ShippingVO shippingVO);
    
    //출고 재고
    void updateStockForShipping(ShippingVO shipping);

    // 출고 반려
    void rejectShipping(String shp_number);

    // 출고 수정
    void editShipping(ShippingVO shippingVO);

    // 출고 삭제
    void deleteShipping(String shp_number);

    // 출고 상태로 검색
    List<ShippingVO> getShippingByStatus(String shp_status);
    
    public OrdersVO getOrdersName(String ord_number);
    
    
    
}
