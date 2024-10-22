package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.MainVO;

public interface MainDAO {
	public MainVO getQty();
	public List<MainVO> dayQty();
}
