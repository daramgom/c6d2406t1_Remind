package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;

public interface MemberService {
	
	
	// 사용자의 처리 로직을 구현
	
	// 회원가입 동작 d
	public String memberJoin(MemberVO vo);
	
	// 회원가입 거래처
	public String companyMemberJoin(MemberVO vo);
	
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
	public List<MemberVO> memberList(String id,Criteria cri);
	
	public List<MemberVO> getCompanymemberList(String id,Criteria cri);
	
	// admin 회원정보 목록 d
	public List<MemberVO> signupRequestList(Criteria cri);

	// admin 특정 회원 조회. d
	public Map<String, Object> memberInfo(String Member_id);
	
	// admin 회원가입 신청 목록 승인
	public int membersUpdate(List<MemberVO> memberList);
	
	// admin 회원가입 신청 목록 삭제
	public Integer membersDelete(List<MemberVO> vo);
	
	// admin 거래처 회원가입 존재여부 체크
	public MemberVO memberCodeCheck(CompanyVO vo);
	
	public MemberVO memberIdEmailSearch(MemberVO vo);
	
	public MemberVO memberNameEmailSearch(MemberVO vo); 
	
	
	public int memberPermissionUpdate(MemberVO vo);
	
	public Map<String, Object> getInfo();
	
	public MemberVO memberUpdateInfo(String id,String span,String newValue);
	
	public int memberUpdatePw(MemberVO vo);
	
	public int deleteCompanyMember(MemberVO vo);
	
	
	
}
