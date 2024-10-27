package com.itwillbs.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.CordersVO;
import com.itwillbs.persistence.CordersDAO;

@Service
public class CordersServiceImpl implements CordersService {
	
	@Autowired
	private CordersDAO codao;
	
	
	private static final Logger logger = LoggerFactory.getLogger(CordersServiceImpl.class);
	
	@Override
	public int insert02(CordersVO cordersVO) {
		
		int result = codao.insert02(cordersVO);
		
		return result;
	}
	
	@Override
	public List<CordersVO> listOrder03() {
		
		return codao.listOrder03();
	}
	
	@Override
	public List<CordersVO> listProd02() {
		// TODO Auto-generated method stub
		return codao.listProd02();
	}
	
	
	@Override
	public List<CordersVO> listManager02() {
		// TODO Auto-generated method stub
		return codao.listManager02();
	}
	
	@Override
	public void updateOrderC(CordersVO cordersVO) {
		// TODO Auto-generated method stub
		codao.updateOrderC(cordersVO);
	}
	
	@Override
	public void deleteOrderC(CordersVO cordersVO) {
		// TODO Auto-generated method stub
		codao.deleteOrderC(cordersVO);
	}
	
}
