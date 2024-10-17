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
	public List<ProdVO> findProdList(ProdVO vo);
	
	
	// 제품수정
	public void updateProd(ProdVO vo, HttpServletRequest req);
	
	
	// 제품삭제
	public void deleteProd(ProdVO vo, HttpServletRequest req);
	
	
	// 재고이동
	public List<ProdVO> transferSelect();
	public List<ProdVO> transferSelect2(ProdVO vo);
	
	
	
}
