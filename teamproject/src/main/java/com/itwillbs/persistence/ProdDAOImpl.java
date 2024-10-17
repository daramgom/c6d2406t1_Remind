package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ProdVO;

//@Repository : 스프링이 해당클래스를 DAO객체 (Bean)로 인식
//				root-context.xml파일에서 해당객체를 사용하도록 설정.

@Repository
public class ProdDAOImpl implements ProdDAO {
	
	@Inject
	private SqlSession sqlSession; 
	// 객체 주입으로 DB 연결 작업 완료 : 자동으로 연결, 자원해제, SQL실행, mybatis...
	// root-context.xml에서 beans 연결 SqlSession --> SqlSessionFactory --> dataSource --> hikariConfig
	// sqlSession : <constructor-arg name="sqlSessionFactory" ref="sqlSessionFactory" />
	// sqlSessionFactory : <property name="dataSource" ref="dataSource" />
	//					   <property name="configLocation" value="classpath:/mybatis-config.xml" />
	//                     <property name="mapperLocations" value="classpath:/mappers/**/*Mapper.xml" />
	// dataSource: <constructor-arg ref="hikariConfig" />
	
	
	// Mapper namespace 정보 저장
	private static final String NAMESPACE = "com.itwillbs.mapper.ProdMapper";
	private static final Logger logger = LoggerFactory.getLogger(ProdDAOImpl.class);
	
	
	// 제품등록
	@Override
	public void insertProd(ProdVO vo) {
		// 1.2 디비연결  => 생략 SqlSession 객체 주입
		// 3. SQL 구문(Mapper 생성) & pstmt 객체 (mybatis 관리)
		// 4. SQL 실행
		// [com.itwillbs.mapper.ProdMapper.insertProd]
		logger.debug("( •̀ ω •́ )✧ DAO : insertProd(ProdVO vo) 실행");
		int result = sqlSession.insert(NAMESPACE+".insertProd", vo);
		logger.debug("( •̀ ω •́ )✧ DAO : result : "+result);
		logger.debug("( •̀ ω •́ )✧ DAO : 제품등록 완료 ");
	}
	

	@Override
	public void insertProdPWQ(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ DAO : insertProdPWQ(ProdVO vo) 실행");
		int result = sqlSession.insert(NAMESPACE + ".insertProdPWQ", vo);
		logger.debug("( •̀ ω •́ )✧ DAO : result : "+result);
	}


	// 제품목록
	@Override
	public List<ProdVO> listProd() {
		// 1.2 디비연결  => 생략 SqlSession 객체 주입
		// 3. SQL 구문(Mapper 생성) & pstmt 객체 (mybatis 관리)
		// 4. SQL 실행
		// [com.itwillbs.mapper.ProdMapper.listProd]
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


	// 재고이동
	@Override
	public List<ProdVO> transferSelect() {
		logger.debug("( •̀ ω •́ )✧ DAO : transferSelect(ProdVO vo) 실행");
		return sqlSession.selectList(NAMESPACE + ".transferSelect");
	}

	// 재고이동
	@Override
	public List<ProdVO> transferSelect2(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ DAO : transferSelect2(ProdVO vo) 실행");
		return sqlSession.selectList(NAMESPACE + ".transferSelect2", vo);
	}


	
	
	
	
}//class
