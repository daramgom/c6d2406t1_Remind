package com.itwillbs.service;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.persistence.MemberDAO;
import org.springframework.stereotype.Service;

// @Service : 서비스 영역(비지니스 로직 영역) 에서의 동작을 구현하도록 설정
//            root-context.xml에 빈(MemberService)으로 등록 사용.

/**
 * 
 * 비즈니스 영역, Action페이지, pro.jsp 동작을 처리하는 공간.
 * => 컨트롤러와 DAO를 연결다리(접착제) / 완충영역
 * => 고객사마다 유연한 대처가 가능.
 */
@Service
public class MemberServiceImpl implements MemberService{
	
	// MemberDAO 객체 주입
	@Inject
	private MemberDAO mdao;

	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	
	// 활성 세션을 저장하는 맵
		private final Map<String, HttpSession> activeSessions = new ConcurrentHashMap<>();

		@Override
		public boolean login(String userId, HttpSession session) {
	        // 이미 로그인된 사용자인지 체크
	        if (activeSessions.containsKey(userId)) {
	            return false; // 이미 로그인한 사용자
	        } else {
	            activeSessions.put(userId, session); // 세션 추가
	            session.setAttribute("userId", userId); // 세션에 사용자 ID 저장
	            return true; // 로그인 성공
	        }
	    }
		
		@Override
		public void logout(String userId) {
	        // 활성 세션에서 사용자 제거
	        activeSessions.remove(userId);
	        // 추가적으로 세션 무효화
	    }

	@Override
	public String memberJoin(MemberVO vo) {
		logger.debug("(●'◡'●) 컨트롤러 -> 서비스 ");
		logger.debug("(●'◡'●) 회원가입 메서드 memberJoin(MemberVO vo) 실행 ");
		
		String hashedPassword = BCrypt.hashpw(vo.getMember_pw(), BCrypt.gensalt());
        vo.setMember_pw(hashedPassword);
		
		return mdao.insertMember(vo);
		
	}

	
	@Override
	public MemberVO memberLoginCheck(MemberVO vo) {
	    MemberVO storedMember = mdao.loginMember(vo);

	    if (storedMember == null) {
	        return null; // 아이디가 없음
	    }
	    
	    
	    // 비밀번호 확인 -> 비밀번호가 맞으면
	    if (BCrypt.checkpw(vo.getMember_pw(), storedMember.getMember_pw())) {
	    	// 로그인 성공
	    	return storedMember; // 비밀번호 일치
	    }

	    return new MemberVO(); // 빈 MemberVO 객체 반환 (비밀번호 틀림)
	}
	
	
	@Override
	public MemberVO memberIdCheck(String member_id) {
		return mdao.getMember(member_id);
	}
	
	
	@Override
	public MemberVO memberIdEmailSearch(MemberVO vo) {
		return mdao.getMemberIdEmailSearch(vo);
	}
	
	
	
	@Override
	public MemberVO memberEmailSearch(String email) {
		return mdao.getMemberEmail(email);
	}
	
	
	@Override
	public MemberVO memberInfoTel(String tel) {
		logger.debug("(●'◡'●) memberInfoTel(String Tel) 실행 " + tel);
		return mdao.getMemberTel(tel);
	}
	
	
	@Override
	public Map<String, Object> getInfo() {
		return mdao.getInfo();
	}
	
	@Override
	public MemberVO memberUpdateInfo(String id, String span, String newValue) {
		MemberVO member = new MemberVO();
		member.setMember_id(id);
		
		if(span.equals("userName")) {
			member.setMember_name(newValue);
			return mdao.updateMemberName(member);
		}
		member.setMember_tel(newValue);
		return mdao.updateMemberTel(member);
	}
	
	
	@Override
	public int memberUpdatePw(MemberVO vo) {
		String hashedPassword = BCrypt.hashpw(vo.getMember_pw(), BCrypt.gensalt());
        vo.setMember_pw(hashedPassword);
		
		return mdao.UpdatePwMember(vo);
	}
	
	
	@Override
	public MemberVO memberNameEmailSearch(MemberVO vo) {
		return mdao.getMemberNameEmailSearch(vo);
	}
	
	@Override
	public int getWaitingMemberTotalCount() {
		return mdao.getWaitingMemberTotalCount();
	}
	
}
