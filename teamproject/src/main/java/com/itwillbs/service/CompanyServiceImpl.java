package com.itwillbs.service;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.itwillbs.persistence.CompanyDAO;
import com.itwillbs.domain.CompanyVO;

@Service
public class CompanyServiceImpl implements CompanyService {

    @Autowired
    private CompanyDAO companyDAO;

    private static final Logger logger = LoggerFactory.getLogger(CompanyServiceImpl.class);

 // 거래처 목록 조회
    @Override
    public List<CompanyVO> getCompanyList() {
        logger.debug("거래처 목록 조회 메서드 호출: getCompanyList()");
        return companyDAO.getCompanyList();
    }
    
    // 거래처 등록
    @Override
    public void registerCompany(CompanyVO company) {
        logger.debug("거래처 등록 메서드 호출: registerCompany(CompanyVO company)");
        companyDAO.insertCompany(company);
    }

    // 거래처 상세 조회
    @Override
    public CompanyVO getCompanyByCode(String companyCode) {
        logger.debug("거래처 상세 조회 메서드 호출: getCompanyByCode(String companyCode) - 코드: {}", companyCode);
        return companyDAO.getCompanyByCode(companyCode);
    }

    // 거래처 정보 수정
    @Override
    public void updateCompany(CompanyVO company) {
        logger.debug("거래처 수정 메서드 호출: updateCompany(CompanyVO company)");
        companyDAO.updateCompany(company);
    }

    // 거래처 조회 (코드로)
    @Override
    public CompanyVO getCompany(String code) {
        logger.debug("거래처 조회 메서드 호출: getCompany(String code) - 코드: {}", code);
        return companyDAO.getCompany(code);
    }

    @Override
    public void updateCompanyStatus(String companyCode, String status) {
        logger.debug("거래처 상태 업데이트 메서드 호출: updateCompanyStatus(String companyCode, String status) - 코드: {}, 상태: {}", companyCode, status);
        companyDAO.updateCompanyStatus(companyCode, status);
    }
    
    @Override
    public List<CompanyVO> getActiveCompanyList() {
        logger.debug("활성 거래처 목록 조회 메서드 호출: getActiveCompanyList()");
        return companyDAO.getActiveCompanyList();
    }
   
    }
