package com.itwillbs.domain;

import lombok.Data;

@Data
public class CompanyVO {
    /*
      company_code VARCHAR(30) NOT NULL,
      company_name VARCHAR(30) NOT NULL,
      company_manager VARCHAR(30) NOT NULL,
      company_tel VARCHAR(30) NOT NULL,
      company_email VARCHAR(50) NOT NULL,
      company_address VARCHAR(100) NOT NULL,
      PRIMARY KEY (company_code)
    */

    // 거래처 코드  
    private String company_code; // 거래처 코드  

    // 거래처 명
    private String company_name; // 거래처 명

    // 거래처 실무자명
    private String company_manager; // 거래처 실무자명

    // 실무자 전화번호
    private String company_tel; // 실무자 전화번호

    // 실무자 이메일 
    private String company_email; // 실무자 이메일 

    // 거래처 주소
    private String company_address; // 거래처 주소

    // Getter 및 Setter 메서드

    public String getCompany_code() {
        return company_code;
    }

    public void setCompany_code(String company_code) {
        this.company_code = company_code;
    }

    public String getCompany_name() {
        return company_name;
    }

    public void setCompany_name(String company_name) {
        this.company_name = company_name;
    }

    public String getCompany_manager() {
        return company_manager;
    }

    public void setCompany_manager(String company_manager) {
        this.company_manager = company_manager;
    }

    public String getCompany_tel() {
        return company_tel;
    }

    public void setCompany_tel(String company_tel) {
        this.company_tel = company_tel;
    }

    public String getCompany_email() {
        return company_email;
    }

    public void setCompany_email(String company_email) {
        this.company_email = company_email;
    }

    public String getCompany_address() {
        return company_address;
    }

    public void setCompany_address(String company_address) {
        this.company_address = company_address;
    }
}
