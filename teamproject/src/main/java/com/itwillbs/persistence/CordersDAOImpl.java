package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.CordersVO;

@Repository
public class CordersDAOImpl implements CordersDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.CorderMapper";
	
	@Override
	public int insert02(CordersVO cordersVO) {
		
		int result = sqlSession.insert(NAMESPACE+".insert02", cordersVO);
		
		return result;
	}
	
	@Override
	public List<CordersVO> listOrder03() {
		return sqlSession.selectList(NAMESPACE+".listOrder03");
	}
	
	@Override
	public List<CordersVO> listProd02() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE+".listProd02");
	}
	
	
	@Override
	public List<CordersVO> listManager02() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE+".listManager02");
	}
	
	@Override
	public void updateOrderC(CordersVO cordersVO) {
		// TODO Auto-generated method stub
		sqlSession.update(NAMESPACE+".updateOrderC", cordersVO);
	}
	
	@Override
	public void deleteOrderC(CordersVO cordersVO) {
		// TODO Auto-generated method stub
		sqlSession.update(NAMESPACE+".deleteOrderC", cordersVO);
	}
	
}
