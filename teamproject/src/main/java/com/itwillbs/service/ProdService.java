package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.ProdVO;

public interface ProdService {
	
	// 제품등록
	public void insertProdS(ProdVO vo);
	
	// 제품목록
	public List<ProdVO> listProd();
	
}
