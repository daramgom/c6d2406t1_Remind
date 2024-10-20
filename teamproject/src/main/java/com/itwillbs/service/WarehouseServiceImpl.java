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
    public void deleteWarehouse(int wh_number) {
        warehouseDAO.deleteWarehouse(wh_number);
    }

    // 특정 창고에 속한 제품 목록을 조회하는 메서드 추가
    @Override
    public List<WarehouseVO> getProductsByWarehouseId(int wh_number) {
        return warehouseDAO.getProductsByWarehouseId(wh_number);
    }
}
