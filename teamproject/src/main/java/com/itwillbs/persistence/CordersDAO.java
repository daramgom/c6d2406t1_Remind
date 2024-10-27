package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.CordersVO;

public interface CordersDAO {
	
	public int insert02(CordersVO cordersVO);
	
	public List<CordersVO> listOrder03();
	
	public List<CordersVO> listProd02();
	
	public List<CordersVO> listManager02();
	
	// 거래처 발주 정보 수정
	void updateOrderC(CordersVO cordersVO);
	
	// 거래처 발주 정보 삭제
	void deleteOrderC(CordersVO cordersVO);
	
}
