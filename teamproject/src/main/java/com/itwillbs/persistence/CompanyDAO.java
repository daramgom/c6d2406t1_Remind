package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.CompanyVO;

public interface CompanyDAO {
	
	public List<CompanyVO> getCompanyList();
	
}
