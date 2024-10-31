package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;

public interface MemberService {
	
	
	// 사용자의 처리 로직을 구현
	public boolean login(String userId, HttpSession session);
	
	// 로그아웃
	public void logout(String userId);
	
	// 회원가입 동작 d
	public String memberJoin(MemberVO vo);
	
	// 회원로그인 체크 동작 d 
	public MemberVO memberLoginCheck(MemberVO vo);
	
	// 회원가입 id 중복 체크 d
	public MemberVO memberIdCheck(String member_id);
	
	// 회원정보 전화번호 조회 d
	public MemberVO memberInfoTel(String tel);
	
	// 회원정보 조회  d 
	public MemberVO memberEmailSearch(String email);
	
	// 회원 id와 email이 같은지 확인하는 메서드
	public MemberVO memberIdEmailSearch(MemberVO vo);
	
	// 회원 Name와 email이 같은지 확인하는 메서드
	public MemberVO memberNameEmailSearch(MemberVO vo); 
	
	// ?
	public Map<String, Object> getInfo();
	
	// 헤더에서 자신 정보 변경.
	public MemberVO memberUpdateInfo(String id,String span,String newValue);
	
	// 비밀번호 찾기에서 사용되는 새로운 비밀번호 설정
	public int memberUpdatePw(MemberVO vo);
	
	
	
	
	
	
	
}
