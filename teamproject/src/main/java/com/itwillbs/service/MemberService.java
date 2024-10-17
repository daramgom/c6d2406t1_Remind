package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.MemberVO;

public interface MemberService {
	
	
	// 사용자의 처리 로직을 구현
	
	// 회원가입 동작 d
	public String memberJoin(MemberVO vo);
	
	// 회원로그인 체크 동작 d 
	public MemberVO memberLoginCheck(MemberVO vo);
	
	// 회원가입 id 중복 체크 d
	public MemberVO memberIdCheck(String member_id);
	
	// 회원정보 조회  d 
	public MemberVO memberEmailSearch(String email);
	
	// 회원정보 수정 d
	public int memberUpdate(MemberVO vo);

	// 회원정보 삭제 d
	public Integer memberDelete(MemberVO vo);
	
	// 회원정보 전화번호 조회 d
	public MemberVO memberInfoTel(String tel);
	
	// admin 회원정보 목록 d
	public List<MemberVO> memberList(String action);

	// admin 특정 회원 조회. d
	public Map<String, Object> memberInfo(String Member_id);
	
	
}
