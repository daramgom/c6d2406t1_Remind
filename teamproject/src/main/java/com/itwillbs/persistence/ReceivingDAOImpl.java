package com.itwillbs.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ReceivingVO;

@Repository
public class ReceivingDAOImpl implements ReceivingDAO {

    @Autowired
    private SqlSession sqlSession;
    
    private static final String NAMESPACE = "com.itwillbs.mapper.ReceivingMapper";

    public void insertRcv(ReceivingVO VO) {
      
        int result = sqlSession.insert(NAMESPACE + ".insertRcv", VO);
        
        System.out.println("Dao: " + result);
        System.out.println("Dao: 입고요청 완료!");
    }
}