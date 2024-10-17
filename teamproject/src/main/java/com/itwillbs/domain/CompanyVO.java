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
	
	private String company_code; // 거래처 코드  
	private String company_name; // 거래처 명
	private String company_manager;  // 거래처 실무자명
	private String company_tel; // 실무자 비밀번호
	private String company_email; // 실무자 이메일 
	private String company_address; // 거래처 주소
	  
	  
}
