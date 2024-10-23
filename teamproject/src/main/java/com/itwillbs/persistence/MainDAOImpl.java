package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.MainVO;

@Repository
public class MainDAOImpl implements MainDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.MainMapper";
	private static final Logger logger = LoggerFactory.getLogger(MainDAOImpl.class);
	
	@Override
	public MainVO getQty() {
		logger.debug("( •̀ ω •́ )✧ MainDAO : getQty() 실행");
		MainVO vo = new MainVO();
		Integer result = sqlSession.selectOne(NAMESPACE + ".prodAllQty");
		if(result == null) {
			return vo;
		} else {
			vo.setProd_all_qty((int)result);
		}
		Integer result2 = sqlSession.selectOne(NAMESPACE + ".monthOrd");
		if(result2 == null) {
			return vo;
		} else {
			vo.setMonth_ord(sqlSession.selectOne(NAMESPACE + ".monthOrd"));
		}
		Integer result3 = sqlSession.selectOne(NAMESPACE + ".monthRcv");
		if(result3 == null) {
			return vo;
		} else {
			vo.setMonth_rcv(sqlSession.selectOne(NAMESPACE + ".monthRcv"));
		}
		Integer result4 = sqlSession.selectOne(NAMESPACE + ".monthShp");
		if(result4 == null) {
			return vo;
		} else {
			vo.setMonth_shp(sqlSession.selectOne(NAMESPACE + ".monthShp"));
		}
		
		return vo;
	}

	@Override
	public List<MainVO> dayQty() {
		logger.debug("( •̀ ω •́ )✧ MainDAO : dayQty() 실행");
		
		return sqlSession.selectList(NAMESPACE + ".dayQty");
	}
	
	

}
