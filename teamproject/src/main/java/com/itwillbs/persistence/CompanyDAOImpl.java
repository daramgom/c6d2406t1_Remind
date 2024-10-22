package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.CompanyVO;

@Repository
public class CompanyDAOImpl implements CompanyDAO {

    @Inject
    private SqlSession sqlSession;
    
    // Mapper namespace 정보 저장
    private static final String NAMESPACE = "com.itwillbs.persistence.CompanyDAO"; // 적절한 namespace로 수정
    private static final Logger logger = LoggerFactory.getLogger(CompanyDAOImpl.class);

    @Override
    public List<CompanyVO> getCompanyList() {
        List<CompanyVO> companies = sqlSession.selectList(NAMESPACE + ".getCompanyList");
        logger.debug("DAO: Retrieved companies: {}", companies);
        return companies;
    }

    @Override
    public void insertCompany(CompanyVO company) {
        int result = sqlSession.insert(NAMESPACE + ".insertCompany", company);
        logger.debug("DAO: Add company result: {}", result);
    }

    @Override
    public CompanyVO getCompanyByCode(String companyCode) {
        CompanyVO company = sqlSession.selectOne(NAMESPACE + ".getCompanyByCode", companyCode);
        logger.debug("DAO: Retrieved company by code: {}", company);
        return company;
    }

    @Override
    public void updateCompany(CompanyVO company) {
        int result = sqlSession.update(NAMESPACE + ".updateCompany", company);
        logger.debug("DAO: Update company result: {}", result);
    }

    @Override
    public void deleteCompany(int companyCode) { // 매개변수 타입을 int로 변경
        int result = sqlSession.delete(NAMESPACE + ".deleteCompany", companyCode);
        logger.debug("DAO: Delete company result: {}", result);
    }
    
    @Override
	public CompanyVO getCompany(String code) {
		System.out.println("DAO : code : " + code);
		
		return sqlSession.selectOne(NAMESPACE+".getCompany", code);
	}
    

}
