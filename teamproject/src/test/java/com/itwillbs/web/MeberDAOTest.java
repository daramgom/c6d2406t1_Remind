package com.itwillbs.web;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.persistence.MemberDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MeberDAOTest {
	// MemberDAO객체의 메서드 호출
	
	@Inject
	private MemberDAO mdao;
	
	// @Test
	public void getBean() {
	}	
	
	
	// @Test
	public void 회원가입테스트() {
		MemberVO vo = new MemberVO();
		
		//vo.setUserid("itwill5");
		//vo.setUsername("학생5");
		//vo.setUserpw("12345");
		//vo.setUseremail("학생5@itwill.com");
		
		// mdao.insertMember(vo);
		
	}
	
//	@Test
	public void 로그인테스트() {
		
		// MemberVO vo = new MemberVO();
		// vo.setUserid("itwill5");
		// vo.setUserpw("12345");
		// MemberVO resultVO =	mdao.loginMember(vo);
		
		//MemberVO resultVO =	mdao.loginMember("admin", "1234");
		
		//if(resultVO != null) {
		//}else {
		//}
		
	}
	
	// @Test
	public void 사용자정보조회() {
		
//		MemberVO vo = new MemberVO();
//		vo.setUserid("itwill5");
//
//		
//		MemberVO resultVO = mdao.getMember(vo);
//		
//		if(resultVO != null) {
//		}else {
//		}
		
		MemberVO resultVO = mdao.getMember("itwill5");
		if(resultVO != null) {
		}else {
		}
	}
	
	//@Test
	public void 회원정보수정() {
		MemberVO uvo = new MemberVO();
		//uvo.setUserid("itwill5");
		//uvo.setUserpw("12345");
		//uvo.setUseremail("itwill5@naver.com");
		
		int result = mdao.updateMember(uvo);
		
		if(result == 1) {
		}else {
		}
		
		
	}
	
	// @Test
	public void 회원정보삭제() {
		
		MemberVO dvo = new MemberVO();
		//dvo.setUserid("itwill3");
		//dvo.setUserpw("12345");
		int result = mdao.deleteMember(dvo);
		
		if(result == 1) {
		}else{
		}
		
	}
	
	@Test
	public void 회원목록_리스트() {
		
		//List<MemberVO> memberList = mdao.getMemberList();
		
		//for (MemberVO memberVO : memberList) {
		//}
		
	}
	
}
