package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.WarehouseVO;

@Repository
public class WarehouseDAOImpl implements WarehouseDAO {

    @Inject
    private SqlSession sqlSession;
    
    // Mapper namespace 정보 저장
    private static final String NAMESPACE = "com.itwillbs.persistence.WarehouseDAO"; // 적절한 namespace로 수정
    private static final Logger logger = LoggerFactory.getLogger(WarehouseDAOImpl.class);

    @Override
    public List<WarehouseVO> getAllWarehouses() {
        List<WarehouseVO> warehouses = sqlSession.selectList(NAMESPACE + ".getAllWarehouses");
        logger.debug("DAO: Retrieved warehouses: {}", warehouses);
        return warehouses;
    }

    @Override
    public WarehouseVO getWarehouseById(int wh_number) {
        WarehouseVO warehouse = sqlSession.selectOne(NAMESPACE + ".getWarehouseById", wh_number);
        logger.debug("DAO: Retrieved warehouse by ID: {}", warehouse);
        return warehouse;
    }

    @Override
    public void addWarehouse(WarehouseVO warehouse) {
        int result = sqlSession.insert(NAMESPACE + ".addWarehouse", warehouse);
        logger.debug("DAO: Add warehouse result: {}", result);
    }

    @Override
    public void updateWarehouse(WarehouseVO warehouse) {
        int result = sqlSession.update(NAMESPACE + ".updateWarehouse", warehouse);
        logger.debug("DAO: Update warehouse result: {}", result);
    }

    @Override
    public void updateWarehouseStatus(int wh_number) { // 메서드 이름 변경
        int result = sqlSession.update(NAMESPACE + ".updateWarehouseStatus", wh_number); // DAO 메서드 호출 수정
        logger.debug("DAO: Update warehouse status result: {}", result);
    }

    // 특정 창고에 속한 제품 목록을 조회하는 메서드 추가
    @Override
    public List<WarehouseVO> getProductsByWarehouseId(int wh_number) {
        List<WarehouseVO> products = sqlSession.selectList(NAMESPACE + ".getProductsByWarehouseId", wh_number);
        logger.debug("DAO: Retrieved products for warehouse ID {}: {}", wh_number, products);
        return products;
    }
}
