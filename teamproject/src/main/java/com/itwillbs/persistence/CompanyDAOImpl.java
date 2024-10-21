package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.CompanyVO;

@Repository
public class CompanyDAOImpl implements CompanyDAO{
	
	

	@Inject
	private SqlSession sqlSession; // 자동으로 연결, 자원해제,SQL실행, mybatis...

	// Mapper namespace 정보 저장
	private static final String NAMESPACE = "com.itwillbs.mapper.CompanyMapper";


	@Override
	public List<CompanyVO> getCompanyList() {
		List<CompanyVO> resultList = sqlSession.selectList(NAMESPACE+".getCompanyList");
		System.out.println("DAO : resultList" + resultList);
		
		return resultList;
	}
	
	@Override
	public CompanyVO getCompany(String code) {
		System.out.println("DAO : code : " + code);
		
		return sqlSession.selectOne(NAMESPACE+".getCompany", code);
	}
}
