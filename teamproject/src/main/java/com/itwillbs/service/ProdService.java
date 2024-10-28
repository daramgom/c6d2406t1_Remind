package com.itwillbs.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.itwillbs.domain.ProdVO;

public interface ProdService {
	
	// 제품등록
	public void insertProd(ProdVO vo, HttpServletRequest req);
	public List<ProdVO> insertList();
	
	
	// 제품목록
	public List<ProdVO> listProd();
	
	
	// 제품조회
	public ProdVO findProd(ProdVO vo);
	public List<ProdVO> findProdList(ProdVO vo);
	
	
	// 제품수정
	public void updateProd(ProdVO vo, HttpServletRequest req);
	
	
	// 제품삭제
	public void deleteProd(ProdVO vo);
	
	
	// 재고이동
	public int transferProd(ProdVO vo);
	public List<ProdVO> transferSelect();
	public List<ProdVO> transferSelect2(ProdVO vo);
	public List<ProdVO> transferSelect3();
	public List<ProdVO> moveStockList(ProdVO vo);
	public int moveStock(List<ProdVO> moveList);
	public int moveStockCancel(List<ProdVO> moveList);
	public List<ProdVO> moveStockAlert();
	
	// 재고 알람 설정
	public int setStock(ProdVO vo);
	public List<ProdVO> setStockList();
	
	
	// 거래처 메인 페이지 제품목록
	public List<ProdVO> cmainListProd();
	
}
