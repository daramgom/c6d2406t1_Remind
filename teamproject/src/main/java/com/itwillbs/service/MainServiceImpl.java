package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.MainVO;
import com.itwillbs.persistence.MainDAO;
import com.itwillbs.persistence.MainDAOImpl;

@Service
public class MainServiceImpl implements MainService {
	@Inject
	private MainDAO mdao;
	private static final Logger logger = LoggerFactory.getLogger(MainDAOImpl.class);
	
	@Override
	public MainVO getQty() {
		logger.debug("( •̀ ω •́ )✧ MainService : getQty() 실행");
		return mdao.getQty();
	}

	@Override
	public List<MainVO> dayQty() {
		logger.debug("( •̀ ω •́ )✧ MainService : dayQty() 실행");
		return mdao.dayQty();
	}
	
	
}
