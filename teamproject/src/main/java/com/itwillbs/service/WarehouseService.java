package com.itwillbs.service;

import com.itwillbs.domain.WarehouseVO;
import java.util.List;

public interface WarehouseService {
    void addWarehouse(WarehouseVO warehouse); // 창고 추가
    WarehouseVO getWarehouseById(int wh_number); // ID로 창고 조회
    List<WarehouseVO> getAllWarehouses(); // 모든 창고 조회
    void updateWarehouse(WarehouseVO warehouse); // 창고 수정
    void updateWarehouseStatus(int wh_number); // ID로 창고 삭제 상태 업데이트
    
    // 특정 창고에 속한 제품 목록을 조회하는 메서드 추가
    List<WarehouseVO> getProductsByWarehouseId(int wh_number); // 특정 창고의 제품 목록 조회

    // 위도와 경도를 포함한 창고 정보를 추가하는 메서드
    void addWarehouseWithLocation(WarehouseVO warehouse); // 위치 정보와 함께 창고 추가
}
