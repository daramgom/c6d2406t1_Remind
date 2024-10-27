package com.itwillbs.domain;

import lombok.Data;

@Data
public class CompanyVO {
    /** 거래처 코드 */
    private String company_code;

    /** 거래처명 */
    private String company_name;

    /** 거래처 실무자명 */
    private String company_manager;

    /** 실무자 전화번호 */
    private String company_tel;

    /** 실무자 이메일 */
    private String company_email;

    /** 거래처 주소 */
    private String company_address;

    /** 삭제 여부 (01: 활성, 02: 삭제) */
    private String is_deleted;
}