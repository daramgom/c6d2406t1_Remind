package com.itwillbs.persistence;

import java.util.List;
import com.itwillbs.domain.CompanyVO;

public interface CompanyDAO {
    /**
     * 모든 거래처 목록을 조회합니다.
     */
    List<CompanyVO> getCompanyList();

    /**
     * 활성 상태의 거래처 목록을 조회합니다.
     */
    List<CompanyVO> getActiveCompanyList();

    /**
     * 새로운 거래처를 등록합니다.
     */
    void insertCompany(CompanyVO company);

    /**
     * 거래처 코드로 특정 거래처를 조회합니다.
     */
    CompanyVO getCompanyByCode(String companyCode);

    /**
     * 거래처 정보를 수정합니다.
     */
    void updateCompany(CompanyVO company);

    /**
     * 거래처의 상태를 업데이트합니다. (논리적 삭제 포함)
     */
    void updateCompanyStatus(String companyCode, String status);

    /**
     * 거래처 코드로 특정 거래처를 조회합니다. (getCompanyByCode와 동일한 기능)
     */
    CompanyVO getCompany(String code);
}