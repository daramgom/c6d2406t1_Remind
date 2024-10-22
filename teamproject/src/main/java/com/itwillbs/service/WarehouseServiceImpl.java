package com.itwillbs.service;

import com.itwillbs.persistence.WarehouseDAO;
import com.itwillbs.domain.WarehouseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WarehouseServiceImpl implements WarehouseService {

    @Autowired
    private WarehouseDAO warehouseDAO;

    @Override
    public void addWarehouse(WarehouseVO warehouse) {
        warehouseDAO.addWarehouse(warehouse);
    }

    @Override
    public WarehouseVO getWarehouseById(int wh_number) {
        return warehouseDAO.getWarehouseById(wh_number);
    }

    @Override
    public List<WarehouseVO> getAllWarehouses() {
        return warehouseDAO.getAllWarehouses();
    }

    @Override
    public void updateWarehouse(WarehouseVO warehouse) {
        warehouseDAO.updateWarehouse(warehouse);
    }

    @Override
    public void updateWarehouseStatus(int wh_number) {
        warehouseDAO.updateWarehouseStatus(wh_number);
    }

    // 특정 창고에 속한 제품 목록을 조회하는 메서드 추가
    @Override
    public List<WarehouseVO> getProductsByWarehouseId(int wh_number) {
        return warehouseDAO.getProductsByWarehouseId(wh_number);
    }

    // 위도와 경도를 포함한 창고 정보를 추가하는 메서드
    @Override
    public void addWarehouseWithLocation(WarehouseVO warehouse) {
        warehouseDAO.addWarehouse(warehouse); // 기존 addWarehouse 메서드 호출
    }
}
