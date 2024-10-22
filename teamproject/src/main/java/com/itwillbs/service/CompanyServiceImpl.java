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
    private CompanyDAO companyDAO; // CompanyDAO 주입

    private static final Logger logger = LoggerFactory.getLogger(CompanyServiceImpl.class);

    @Override
    public List<CompanyVO> getCompanyList() {
        logger.debug("거래처 목록 조회 메서드 호출: getCompanyList()");
        return companyDAO.getCompanyList(); // 거래처 목록 조회
    }

    @Override
    public void registerCompany(CompanyVO company) {
        logger.debug("거래처 등록 메서드 호출: registerCompany(CompanyVO company)");
        
        // 파라미터 로그 추가
        logger.debug("거래처 코드: {}", company.getCompany_code());
        logger.debug("거래처 명: {}", company.getCompany_name());
        logger.debug("실무자명: {}", company.getCompany_manager());
        logger.debug("전화번호: {}", company.getCompany_tel());
        logger.debug("이메일: {}", company.getCompany_email());
        logger.debug("주소: {}", company.getCompany_address());

        companyDAO.insertCompany(company); // 거래처 등록
    }

    @Override
    public CompanyVO getCompanyByCode(String companyCode) {
        logger.debug("거래처 상세 조회 메서드 호출: getCompanyByCode(String companyCode) - 코드: {}", companyCode);
        return companyDAO.getCompanyByCode(companyCode); // 거래처 상세 조회
    }

    @Override
    public void updateCompany(CompanyVO company) {
        logger.debug("거래처 수정 메서드 호출: updateCompany(CompanyVO company)");
        
        // 파라미터 로그 추가
        logger.debug("거래처 코드: {}", company.getCompany_code());
        logger.debug("거래처 명: {}", company.getCompany_name());
        logger.debug("실무자명: {}", company.getCompany_manager());
        logger.debug("전화번호: {}", company.getCompany_tel());
        logger.debug("이메일: {}", company.getCompany_email());
        logger.debug("주소: {}", company.getCompany_address());

        companyDAO.updateCompany(company); // 거래처 수정
    }
    
    @Override
	public CompanyVO getCompany(String code) {
		
		return companyDAO.getCompany(code);
	}


    @Override
    public void deleteCompany(int companyCode) {
        logger.debug("거래처 삭제 메서드 호출: deleteCompany(String companyCode) - 코드: {}", companyCode);
        companyDAO.deleteCompany(companyCode); // 거래처 삭제
    }
}
