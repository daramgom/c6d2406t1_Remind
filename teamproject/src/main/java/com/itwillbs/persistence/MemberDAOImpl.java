package com.itwillbs.persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;

/**
 * 
 * MemberDAO 동작을 수행
 *
 */
// @Repository : 스프링이 해당클래스를 DAO객체 (Bean)로 인식
// 				root-context.xml파일에서 해당객체를 사용하도록 설정.
// 
@Repository
public class MemberDAOImpl implements MemberDAO {
	// 파일에 S라고 붙어 있으면 spring이 관리하는대상을 나타냄.

	// 공통변수, 디비 연결, 자원해제
	// 디비 연결객체(SqlSessionFactory)가 필요함 => 의존관계 주입
//	@Inject
//	private SqlSessionFactory sqlFactory;

	@Inject
	private SqlSession sqlSession; // 자동으로 연결, 자원해제,SQL실행, mybatis...

	// Mapper namespace 정보 저장
	private static final String NAMESPACE = "com.itwillbs.mapper.MemberMapper";

	@Override
	public String insertMember(MemberVO vo) {
		System.out.println(" DAO : 회원가입 동작 실행! ");

		// ID 중복 체크
		if (getMember(vo.getMember_id()) != null) {
			return "아이디 중복";
		}

		// 이메일 중복 체크
		if (getMemberEmail(vo.getMember_email()) != null) {
			return "이메일 중복";
		}

		// 전화번호 중복 체크
		if (getMemberTel(vo.getMember_tel()) != null) {
			return "전화번호 중복";
		}

		// 회원가입 처리
		int result = sqlSession.insert(NAMESPACE + ".insertMember", vo);
		System.out.println(" DAO : result : " + result);
		System.out.println(" DAO : 회원가입 완료! ");

		return "회원가입 완료";
	}
	
	
	// 거래처 회원가입
	@Override
	public String insertCompanyMember(MemberVO vo) {
		System.out.println(" DAO : 회원가입 동작 실행! ");

		// ID 중복 체크
		if (getMember(vo.getMember_id()) != null) {
			return "아이디 중복";
		}

		// 이메일 중복 체크
		if (getMemberEmail(vo.getMember_email()) != null) {
			return "이메일 중복";
		}

		// 전화번호 중복 체크
		if (getMemberTel(vo.getMember_tel()) != null) {
			return "전화번호 중복";
		}

		// 회원가입 처리
		int result = sqlSession.insert(NAMESPACE + ".insertCompanyMember", vo);
		System.out.println(" DAO : result : " + result);
		System.out.println(" DAO : 회원가입 완료! ");

		return "회원가입 완료";
	}

	@Override
	public MemberVO loginMember(MemberVO vo) {
		System.out.println(" DAO : loginMember(MemberVO vo) 실행 ");

		// SQL 구문을 mapper에 생성
		System.out.println(" DAO : mapper SQL 생성완료. ");
		// SQL 구문 실행.
		MemberVO resultVO = sqlSession.selectOne(NAMESPACE + ".loginMember", vo);
		if(resultVO == null ) {
			return null;
		}

		System.out.println(" DAO : " + resultVO);

		return resultVO;
	}


	@Override
	public MemberVO getMember(String member_id) {
		System.out.println(" DAO : getMember(String userid) ");

		return sqlSession.selectOne(NAMESPACE + ".getMemberId", member_id);
	}

	@Override
	public MemberVO getMemberEmail(String email) {
		System.out.println(" DAO : getMemberEmail(String email) ");
		return sqlSession.selectOne(NAMESPACE + ".getMemberEmail", email);
	}

	@Override
	public MemberVO getMemberTel(String tel) {
		// TODO Auto-generated method stub
		System.out.println("tel : DAO " + tel);
		return sqlSession.selectOne(NAMESPACE + ".getMemberTel", tel);
	}
	

	@Override
	public int updateMember(MemberVO uvo) {
		System.out.println(" DAO : updateMember(MemberVO uvo) ");
		System.out.println(uvo + "uvo");
		// mapper - sql 작성
		// sqlSession - sql 실행 (결과에 따른 정수데이터를 리턴)

		int result = sqlSession.update(NAMESPACE + ".updateMember", uvo);

		return result;
	}
	@Override
	public MemberVO updateMemberName(MemberVO uvo) {
		MemberVO member = new MemberVO();
		
		int result = sqlSession.update(NAMESPACE + ".updateMemberName", uvo);
		
		if(result != 0) {
			member = getMember(uvo.getMember_id());
		}
		
		
		return member;
	}
	
	
	
	
	@Override
	public MemberVO updateMemberTel(MemberVO uvo) {
		MemberVO used = getMemberTel(uvo.getMember_tel());
		MemberVO member = new MemberVO();
		
		if(used != null) {
			return member;
		}
		
		int result = sqlSession.update(NAMESPACE + ".updateMemberTel", uvo);
		if(result != 0) {
			member = getMemberTel(uvo.getMember_tel());
		}
		
		return member;
	}
	
	@Override
	public int updatePermission(MemberVO vo) {
		System.out.println("DAO : "+vo);
		int result = sqlSession.update(NAMESPACE + ".updatePermission", vo);
		
		return result;
	}
	
	
	@Override
	public MemberVO memberCodeCheck(CompanyVO vo) {
		System.out.println("DAO : "+ vo);
		
		MemberVO result = sqlSession.selectOne(NAMESPACE+ ".memberCodeCheck", vo.getCompany_code());
		System.out.println(result);
		
		return result;
	}
	
	
	
	

	@Override
	public Integer deleteMember(MemberVO dvo) {
		System.out.println(" DAO : deleteMember(MemberVO dvo) ");
		return sqlSession.update(NAMESPACE + ".deleteMember", dvo);
	}

	// admin 회원 전체 조회.
	@Override
	public List<MemberVO> getMemberList(String member_id, Criteria cri) {
	    System.out.println(" DAO : getMemberList() ");
	    
	    // 총 회원 수를 계산하기 위한 매개변수 준비
	    Map<String, Object> countParams = new HashMap<>();
	    countParams.put("member_id", member_id);
	    countParams.put("keyword", cri.getKeyword()); // 검색 키워드 추가
	    int totalCount = sqlSession.selectOne(NAMESPACE + ".getMemberListCount", countParams);
	    
	    // 총 회원 수를 Criteria에 설정 (페이지 수 계산을 위해)
	    cri.setTotalCount(totalCount);

	    // 회원 목록 조회를 위한 매개변수 준비
	    Map<String, Object> params = new HashMap<>();
	    params.put("member_id", member_id);
	    params.put("startPage", cri.getStartPage());
	    params.put("pageSize", cri.getPageSize());
	    params.put("keyword", cri.getKeyword()); // 검색 키워드 추가
	    return sqlSession.selectList(NAMESPACE + ".getMemberList", params);
	}
	
	@Override
	public List<MemberVO> getCompanyMemberList(String member_id, Criteria cri) {
		System.out.println(" DAO : getMemberList() ");
	    
	    // 총 회원 수를 계산하기 위한 매개변수 준비
	    Map<String, Object> countParams = new HashMap<>();
	    countParams.put("member_id", member_id);
	    countParams.put("keyword", cri.getKeyword()); // 검색 키워드 추가
	    int totalCount = sqlSession.selectOne(NAMESPACE + ".getCompanyMemberListCount", countParams);
	    
	    System.out.println(" DAO : totalCount() 거래처 회사 카운트 "+ totalCount);
	    // 총 회원 수를 Criteria에 설정 (페이지 수 계산을 위해)
	    cri.setTotalCount(totalCount);
	    

	    // 회원 목록 조회를 위한 매개변수 준비
	    Map<String, Object> params = new HashMap<>();
	    params.put("member_id", member_id);
	    System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ : "+ cri.getStartPage());
	    params.put("startPage", cri.getStartPage());
	    params.put("pageSize", cri.getPageSize());
	    params.put("keyword", cri.getKeyword()); // 검색 키워드 추가
	    return sqlSession.selectList(NAMESPACE + ".getCompanyMemberList", params);
	}
	

	
	@Override
	public List<MemberVO> getSignupRequestList(Criteria cri) {
		List resultList = new ArrayList();
		/* Criteria cri */
			// 합쳐진 List결과를 리턴
			int totalCount = sqlSession.selectOne(NAMESPACE + ".getWaitingMemberCount");
			List resultWaitingMember = sqlSession.selectList(NAMESPACE + ".getWaitingMember", cri);
			// 대기 회원이 없을 경우 빈 결과 반환
		    if (resultWaitingMember.isEmpty()) {
		    	resultList.add(resultWaitingMember);
		    	resultList.add(new ArrayList<>()); // 빈 직원 목록
		        resultList.add(new ArrayList<>()); // 빈 부서 목록
		        resultList.add(totalCount); // 전체 회원 수
		        return resultList;
		    }
			List resultEmpMap = sqlSession.selectList(NAMESPACE + ".getEmp_rank", "common_value");
			List resultDeptMap = sqlSession.selectList(NAMESPACE + ".getDepartment", "department_id");
			
			
			resultList.add(resultWaitingMember);
		    resultList.add(resultEmpMap);
		    resultList.add(resultDeptMap);
		    resultList.add(totalCount); // 전체 대기 회원 수 추가
			return resultList;

	
	}
	
	@Override
	public int updatePw(MemberVO vo) {
		int result = sqlSession.update(NAMESPACE + ".updatePw", vo);
		return result;
	}

	// admin 특정 회원 조회
	@Override
	public Map<String, Object> getMemberDetails(String member_id) {
		// 왜 map으로 사용하는지? . List로 쓰면 위의 getMemberList에도 사용할 수 있음.
		System.out.println(" DAO : getMemberDetails : " + member_id);
		Map<String, Object> commonStatuses = new HashMap<>();

		MemberVO member = sqlSession.selectOne(NAMESPACE + ".getMemberById", member_id);
		Map<String, Object> resultEmpMap = sqlSession.selectMap(NAMESPACE + ".getEmp_rank", "common_value");
		Map<String, Object> resultMemberStateMap = sqlSession.selectMap(NAMESPACE + ".getMemberState", "common_value");
		Map<String, Object> resultDeptMap = sqlSession.selectMap(NAMESPACE + ".getDepartment", "department_id");

		// List<String> result4 = sqlSession.selectList(NAMESPACE+".getApproval");

		// 결과를 map에 추가
		commonStatuses.put("member", member);
		commonStatuses.put("empRank", resultEmpMap); // 키와 값을 추가합니다.
		commonStatuses.put("memberState", resultMemberStateMap);
		commonStatuses.put("department", resultDeptMap);

//		commonStatuses.put("approval", result4);

		return commonStatuses;
	}

	// admin 회원가입신청 승인
	@Override
	public int updateMembers(List<MemberVO> memberList) {
		System.out.println("DAO: updateMembers");
		int totalUpdated = 0; // 업데이트된 총 개수 초기화

		for (MemberVO vo : memberList) {
			int result = sqlSession.update(NAMESPACE + ".UpdateMembers", vo);
			if (result > 0) {
				totalUpdated++; // 업데이트가 성공한 경우 카운트 증가
			}
		}

		return totalUpdated;
	}
	
	// admin 회원가입 신청 목록 삭제
		@Override
		public Integer deleteMembers(List<MemberVO> memberList) {
			int totalDelete = 0;
			
			
			for (MemberVO vo : memberList) {
				int result = sqlSession.delete(NAMESPACE + ".deleteMembers", vo);
				if (result > 0) {
					totalDelete++; // 업데이트가 성공한 경우 카운트 증가
				}
			}
			return totalDelete;
		}
		
		@Override
		public Map<String, Object> getInfo() {
			Map<String, Object> commonStatuses = new HashMap<>();
			// "common_value" 키 값을 선택하는거임
			Map<String, Object> resultEmpMap = sqlSession.selectMap(NAMESPACE + ".getEmp_rank", "common_value");
			Map<String, Object> resultDeptMap = sqlSession.selectMap(NAMESPACE + ".getDepartment", "department_id");

			// List<String> result4 = sqlSession.selectList(NAMESPACE+".getApproval");

			// 결과를 map에 추가
			commonStatuses.put("empRank", resultEmpMap); // 키와 값을 추가합니다.
			commonStatuses.put("department", resultDeptMap);
			return commonStatuses;
		}
		
		
		
		@Override
		public MemberVO getMemberIdEmailSearch(MemberVO vo) {
			System.out.println("DAO : getMemberIdEmailSearch : "+ vo);
			
			MemberVO result = sqlSession.selectOne(NAMESPACE+ ".getMemberIdEmailSearch", vo);
			
			return result;
		}

		@Override
		public int UpdatePwMember(MemberVO vo) {
			System.out.println("DAO : UpdatePwMember(MemberVO vo) : "+ vo);
			
			int result = sqlSession.update(NAMESPACE+ ".updatePw", vo);
			
			return result;
		}
		
		@Override
		public MemberVO getMemberNameEmailSearch(MemberVO vo) {
			MemberVO result = sqlSession.selectOne(NAMESPACE+".getMemberNameEmailSearch" , vo);
			return result;
		}
		
		@Override
		public int deleteCompanyMember(MemberVO vo) {
			int result = sqlSession.delete(NAMESPACE+".deleteMembers" , vo);
			return result;
		}
		
		
}
