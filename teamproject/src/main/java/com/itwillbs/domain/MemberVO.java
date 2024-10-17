package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Data;
//import lombok.AllArgsConstructor;
//import lombok.Getter;
//import lombok.NoArgsConstructor;
//import lombok.Setter;
//import lombok.ToString;


/**
 * VO (Value Object) : 데이터 저장 객체 (값을 저장하는 동작 이외의 동작O)
 *	DTO (Data Transfer Object) : 데이터 전송 객체 (값을 저장하는 동작 이외의 동작X)
 *
 * tbl_member 테이블정보를 저장하는 객체
 *
 */
// @Data => set/get메서드 자동생성.
//@Setter
//@Getter
//@NoArgsConstructor
//@AllArgsConstructor
//@ToString
@Data
public class MemberVO {

	// private String Uid;
	// private String uId; // getUId() x
	// private String userId; // getUserId() o 웬만하면 x
	
	private String member_id; // 아이디
	private String member_pw; // 비밀번호
	private String member_name; // 사용자 이름
	private String member_email; // 이메일
	private String member_tel; // 사용자 전화번호
	// 
	private String member_birth; // 사용자 생일 
	// 
	private String department_id; // 부서번호
	private String employee_rank; // 직급
	private Timestamp create_date; // 회원가입일
	private Timestamp update_date; // 회원정보 수정일
	private String permission_id; // 사용자 권한. user admin
	
	private String member_state; // 근무 , 휴직 , 퇴사 , 거래처  
	private String approval_status; // 회원가입 미승인 , 승인.
	
	private String employee_rank_value;
	
	
}
