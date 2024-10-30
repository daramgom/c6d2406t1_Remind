package com.itwillbs.persistence;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.itwillbs.domain.CompanyVO;
import com.itwillbs.domain.MemberVO;

@Repository
public class CompanyDAOImpl implements CompanyDAO {

    @Inject
    private SqlSession sqlSession;
    
    private static final String NAMESPACE = "com.itwillbs.persistence.CompanyDAO";
    private static final Logger logger = LoggerFactory.getLogger(CompanyDAOImpl.class);

    @Override
    public List<CompanyVO> getCompanyList() {
        try {
            List<CompanyVO> companies = sqlSession.selectList(NAMESPACE + ".getCompanyList");
            logger.debug("DAO: Retrieved companies: {}", companies);
            return companies;
        } catch (DataAccessException e) {
            logger.error("Error retrieving company list: ", e);
            throw e;
        }
    }

    @Override
    @Transactional
    public void insertCompany(CompanyVO company) {
        try {
            int result = sqlSession.insert(NAMESPACE + ".insertCompany", company);
            logger.debug("DAO: Add company result: {}", result);
        } catch (DataAccessException e) {
            logger.error("Error inserting company: ", e);
            throw e;
        }
    }

    @Override
    public CompanyVO getCompanyByCode(String companyCode) {
        return getCompany(companyCode);
    }

    @Override
    @Transactional
    public void updateCompany(CompanyVO company) {
        try {
            int result = sqlSession.update(NAMESPACE + ".updateCompany", company);
            logger.debug("DAO: Update company result: {}", result);
        } catch (DataAccessException e) {
            logger.error("Error updating company: ", e);
            throw e;
        }
    }

    @Override
    @Transactional
    public void updateCompanyStatus(String companyCode, String isDeleted) {
        try {
            CompanyVO company = new CompanyVO();
            company.setCompany_code(companyCode);
            company.setIs_deleted(isDeleted);
            int result = sqlSession.update(NAMESPACE + ".updateCompanyStatus", company);
			
			  MemberVO member = sqlSession.selectOne(NAMESPACE + ".getMember", company);
			  if(member == null) {
			 
			 }else { sqlSession.selectOne(NAMESPACE + ".deleteMember", company); }
        
            logger.debug("DAO: Update company status result: {}", result);
        } catch (DataAccessException e) {
            logger.error("Error updating company status: ", e);
            throw e;
        }
    }

    @Override
    public List<CompanyVO> getActiveCompanyList() {
        try {
            List<CompanyVO> activeCompanies = sqlSession.selectList(NAMESPACE + ".getActiveCompanyList");
            logger.debug("DAO: Retrieved active companies: {}", activeCompanies);
            return activeCompanies;
        } catch (DataAccessException e) {
            logger.error("Error retrieving active company list: ", e);
            throw e;
        }
    }

    @Override
    public CompanyVO getCompany(String code) {
        try {
            logger.debug("DAO: Retrieving company with code: {}", code);
            CompanyVO company = sqlSession.selectOne(NAMESPACE + ".getCompany", code);
            logger.debug("DAO: Retrieved company: {}", company);
            return company;
        } catch (DataAccessException e) {
            logger.error("Error retrieving company: ", e);
            throw e;
        }
    }
}