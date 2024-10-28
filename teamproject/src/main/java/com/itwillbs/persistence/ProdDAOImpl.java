package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.domain.ProdVO;


@Repository
public class ProdDAOImpl implements ProdDAO {
	
	@Inject
	private SqlSession sqlSession; 
	
	
	// Mapper namespace 정보 저장
	private static final String NAMESPACE = "com.itwillbs.mapper.ProdMapper";
	private static final Logger logger = LoggerFactory.getLogger(ProdDAOImpl.class);
	
	
	// 제품등록
	@Override
	public void insertProd(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ DAO : insertProd(ProdVO vo) 실행");
		int result = sqlSession.insert(NAMESPACE+".insertProd", vo);
		logger.debug("( •̀ ω •́ )✧ DAO : result : "+result);
		logger.debug("( •̀ ω •́ )✧ DAO : 제품등록 완료 ");
	}
	
	// 제품 등록 입고처
	@Override
	public List<ProdVO> insertList() {
		logger.debug("( •̀ ω •́ )✧ DAO : insertList(); 실행");
		return sqlSession.selectList(NAMESPACE+".insertList");
	}


	// 제품목록
	@Override
	public List<ProdVO> listProd() {
		logger.debug("( •̀ ω •́ )✧ DAO : listProd(); 실행");
		return sqlSession.selectList(NAMESPACE + ".listProd");
	}


	// 제품조회
	@Override
	public ProdVO findProd(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ DAO : findProd(ProdVO vo) 실행");
		return sqlSession.selectOne(NAMESPACE + ".findProd", vo);
	}

	@Override
	public List<ProdVO> findProdList(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ DAO : findProdList(ProdVO vo) 실행");
		return sqlSession.selectList(NAMESPACE + ".findProdList", vo);
	}


	// 제품수정
	@Override
	public void updateProd(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ DAO : updateProd(ProdVO vo) 실행");
		sqlSession.update(NAMESPACE + ".updateProd", vo);
	}


	// 제품삭제
	@Override
	public void deleteProd(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ DAO : deleteProd(ProdVO vo) 실행");
		sqlSession.update(NAMESPACE + ".deleteProd", vo);
	}

	
	// 재고이동이력기록
	@Override
	public int transferProd(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ DAO : transferProd(ProdVO vo) 실행");
		int result = sqlSession.insert(NAMESPACE+ ".transferProd", vo);
		result += sqlSession.update(NAMESPACE+".moveStock", vo);
		result += sqlSession.insert(NAMESPACE+".moveStock2", vo);
		return result;
	}
	
	// 재고이동선택1
	@Override
	public List<ProdVO> transferSelect() {
		logger.debug("( •̀ ω •́ )✧ DAO : transferSelect(ProdVO vo) 실행");
		return sqlSession.selectList(NAMESPACE + ".transferSelect");
	}
	
	// 재고이동선택2
	@Override
	public List<ProdVO> transferSelect2(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ DAO : transferSelect2(ProdVO vo) 실행");
		return sqlSession.selectList(NAMESPACE + ".transferSelect2", vo);
	}
	
	// 재고이동선택3
	@Override
	public List<ProdVO> transferSelect3() {
		logger.debug("( •̀ ω •́ )✧ DAO : transferSelect3() 실행");
		return sqlSession.selectList(NAMESPACE + ".transferSelect3");
	}
	
	
	
	// 재고이동내역리스트
	@Override
	public List<ProdVO> moveStockList(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ DAO : moveStockList(ProdVO vo) 실행");
		return sqlSession.selectList(NAMESPACE+ ".moveStockList", vo);
	}

	// 재고이동승인
	@Override
	@Transactional
	public int moveStock(List<ProdVO> moveList) {
		logger.debug("( •̀ ω •́ )✧ DAO : moveStock(List<ProdVO> moveList) 실행");
		int result = 0;
		for(ProdVO vo: moveList) {
			result += sqlSession.update(NAMESPACE+".moveStock3", vo);
		}
		logger.debug("( •̀ ω •́ )✧ DAO : result : "+result);
		return result;
	}
	
	// 재고이동취소
	@Override
	@Transactional
	public int moveStockCancel(List<ProdVO> moveList) {
		logger.debug("( •̀ ω •́ )✧ DAO : moveStockCancel(List<ProdVO> moveList) 실행");
		int result = 0;
		for(ProdVO vo: moveList) {
			result += sqlSession.update(NAMESPACE+".moveStockCancel", vo);
			result += sqlSession.update(NAMESPACE+".moveStockCancel2", vo);
			result += sqlSession.update(NAMESPACE+".moveStock3", vo);
		}
		logger.debug("( •̀ ω •́ )✧ DAO : result : "+result);
		return result;
	}
	
	// 재고이동알람
	@Override
	public List<ProdVO> moveStockAlert() {
		logger.debug("( •̀ ω •́ )✧ DAO : moveStockAlert() 실행");
		return sqlSession.selectList(NAMESPACE+".moveStockAlert");
	}

	// 재고알람설정
	@Override
	public int setStock(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ DAO : setStock(ProdVO vo) 실행");
		return sqlSession.update(NAMESPACE + ".setStock", vo);
	}
	
	// 재고알람목록
	@Override
	public List<ProdVO> setStockList() {
		logger.debug("( •̀ ω •́ )✧ DAO : setStockList() 실행");
		return sqlSession.selectList(NAMESPACE + ".setStockList");
	}
	
	
	// 거래처 메인 페이지 제품목록
	@Override
	public List<ProdVO> cmainListProd() {
		logger.debug("( •̀ ω •́ )✧ DAO : cmainListProd() 실행");
		return sqlSession.selectList(NAMESPACE + ".cmainListProd");
	}
	
	
}//class
