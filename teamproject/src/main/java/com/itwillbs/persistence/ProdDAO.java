package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.ProdVO;

/**
 * 
 *	prod 테이블의 데이터를 활용하는 동작을 정의 
 *  
 */

public interface ProdDAO {
	
	// 제품등록
	public void insertProd(ProdVO vo);
	public List<ProdVO> insertList();
	
	
	// 제품목록
	public List<ProdVO> listProd();
	
	
	// 제품조회
	public ProdVO findProd(ProdVO vo);
	public List<ProdVO> findProdList(ProdVO vo);
	
	
	// 제품수정
	public void updateProd(ProdVO vo);
	
	
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
	
	// 재고알람설정
	public int setStock(ProdVO vo);
	public List<ProdVO> setStockList();
	
}
