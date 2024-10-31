package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;

public interface AdminService {
	
	
	public int getMemberTotalCount(String member_id, Criteria cri);
	
	public int getCompanyMemberTotalCount(String member_id, Criteria cri);
	
	public int getWaitingMemberTotalCount(Criteria cri);
	
	// admin 회원정보 목록 d
	public List<MemberVO> memberList(String id,Criteria cri);
	
	// admin 특정 회원 조회. d
	public Map<String, Object> memberInfo(String Member_id);
	
	// 회원정보 수정 d
	public int memberUpdate(MemberVO vo);
	
	// 회원정보 삭제 d
	public Integer memberDelete(MemberVO vo);
	
	// admin 회원정보 목록 d
	public List<MemberVO> signupRequestList(Criteria cri);
	// admin 회원가입 신청 목록 승인
	public int membersUpdate(List<MemberVO> memberList);
	
	// admin 회원가입 신청 목록 삭제
	public Integer membersDelete(List<MemberVO> vo);
	// 회원가입 거래처
	public String companyMemberJoin(MemberVO vo);
	// admin 권한 변경
	public int memberPermissionUpdate(MemberVO vo);
	// admin 거래처 회원가입 존재여부 체크
	public MemberVO memberCodeCheck(CompanyVO vo);
	// admin 거래처 List
	public List<MemberVO> getCompanymemberList(String id,Criteria cri);
	// 회원가입한 거래처 삭제
	public int deleteCompanyMember(MemberVO vo);
	
	

}
