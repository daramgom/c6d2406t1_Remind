package com.itwillbs.service;

import java.util.List;
import com.itwillbs.domain.CompanyVO;

public interface CompanyService {
    List<CompanyVO> getCompanyList(); // 모든 거래처 목록 조회

    List<CompanyVO> getActiveCompanyList(); // 활성 상태의 거래처 목록 조회

    void registerCompany(CompanyVO company); // 거래처 등록

    CompanyVO getCompanyByCode(String companyCode); // 거래처 상세 조회

    void updateCompany(CompanyVO company); // 거래처 정보 수정

    CompanyVO getCompany(String code); // 거래처 조회 (코드로)

    // 거래처 상태 업데이트 (활성/비활성/삭제 등)
    void updateCompanyStatus(String companyCode, String status);

    
}