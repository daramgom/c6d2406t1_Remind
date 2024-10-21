package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.persistence.CompanyDAO;

@Service
public class CompanyServiceImpl implements CompanyService{
	
	@Inject
	private CompanyDAO Cdao;
	
	@Override
	public List<CompanyVO> getCompanyList() {
		
		return Cdao.getCompanyList();
	}
	
	@Override
	public CompanyVO getCompany(String code) {
		
		return Cdao.getCompany(code);
	}

}
