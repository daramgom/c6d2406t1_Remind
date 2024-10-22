package com.itwillbs.persistence;

import java.util.List;
import com.itwillbs.domain.WarehouseVO;

public interface WarehouseDAO {
    List<WarehouseVO> getAllWarehouses(); // 모든 창고 조회
    WarehouseVO getWarehouseById(int wh_number); // ID로 창고 조회
    void addWarehouse(WarehouseVO warehouse); // 창고 추가
    void updateWarehouse(WarehouseVO warehouse); // 창고 수정
    void updateWarehouseStatus(int wh_number); // ID로 창고 삭제 상태 업데이트

    // 창고에 속한 제품 목록을 조회하는 메서드 추가
    List<WarehouseVO> getProductsByWarehouseId(int wh_number); // 특정 창고에 속한 제품 목록 조회
}
