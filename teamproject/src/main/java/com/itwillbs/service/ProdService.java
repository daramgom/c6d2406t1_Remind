package com.itwillbs.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.itwillbs.domain.ProdVO;

public interface ProdService {
	
	// 제품등록
	public void insertProd(ProdVO vo, HttpServletRequest req);
	
	// 제품목록
	public List<ProdVO> listProd();
	
	// 제품조회
	public ProdVO findProd(ProdVO vo);
	
}
