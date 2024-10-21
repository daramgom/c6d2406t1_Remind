package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.CompanyVO;

public interface CompanyService {
	
	public List<CompanyVO> getCompanyList();
	
	public CompanyVO getCompany(String code);

}
