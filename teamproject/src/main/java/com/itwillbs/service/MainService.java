package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.MainVO;

public interface MainService {
	public MainVO getQty();
	public List<MainVO> dayQty();

}
