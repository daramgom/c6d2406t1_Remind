package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.persistence.MemberDAO;

@Service
public class AdminServiceImpl implements AdminService {

	
	
	
	@Inject
	private MemberDAO mdao;
	
	@Override
	public String companyMemberJoin(MemberVO vo) {
		
		String hashedPassword = BCrypt.hashpw(vo.getMember_pw(), BCrypt.gensalt());
        vo.setMember_pw(hashedPassword);
		
		return mdao.insertCompanyMember(vo);
	}
	
	
	@Override
	public int memberUpdate(MemberVO uvo) {
		return mdao.updateMember(uvo);
	}
	

	@Override
	public int memberPermissionUpdate(MemberVO vo) {
		return mdao.updatePermission(vo);
	}
	
	@Override
	public MemberVO memberCodeCheck(CompanyVO vo) {
		return mdao.memberCodeCheck(vo);
	}
	
	
	@Override
	public Integer memberDelete(MemberVO vo) {
		return mdao.deleteMember(vo); 
		
	}
	
	@Override
	public Map<String,Object> memberInfo(String member_id) {
		return mdao.getMemberDetails(member_id);
	}
	
	// admin 전용 특정 사용자 조회
	@Override
	public List<MemberVO> memberList(String id, Criteria cri) {
		return mdao.getMemberList(id,cri);
	}
	// admin 전용 거래처 회원목록
	@Override
	public List<MemberVO> getCompanymemberList(String id, Criteria cri) {
		return mdao.getCompanyMemberList(id,cri);
	}
	
	// admin 전용 회원가입 신청 멤버 목록
	@Override
	public List<MemberVO> signupRequestList(Criteria cri) {
		return  mdao.getSignupRequestList(cri);
	}
	
	// admin 전용 회원가입 신청 멤버 승인.
	@Override
	public int membersUpdate(List<MemberVO> memberList) {
		return mdao.updateMembers(memberList); 
	}
	
	// admin 전용 회원가입 신청 멤버 삭제.
	@Override
	public Integer membersDelete(List<MemberVO> vo) {
		return mdao.deleteMembers(vo);
	}
	
	@Override
	public int deleteCompanyMember(MemberVO vo) {
		return mdao.deleteCompanyMember(vo);
	}
	
	@Override
	public int getMemberTotalCount(String member_id, Criteria cri) {
		return mdao.getMemberTotalCount(member_id , cri);
	}
	
	@Override
	public int getCompanyMemberTotalCount(String member_id, Criteria cri) {
		// TODO Auto-generated method stub
		return mdao.getCompanyMemberTotalCount(member_id , cri);
	}
	
	@Override
	public int getWaitingMemberTotalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return mdao.getWaitingMemberTotalCount(cri);
	}
	
	
}
