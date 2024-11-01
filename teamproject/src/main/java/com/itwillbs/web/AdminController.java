package com.itwillbs.web;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.service.AdminService;
import com.itwillbs.service.CompanyService;
import com.itwillbs.service.EmailService;
import com.itwillbs.service.MemberService;

@Controller
@RequestMapping(value = "/admin/*")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Inject
	private MemberService mService;

	@Inject
	private CompanyService cService;
	
	@Inject
	private EmailService eService;
	
	@Inject
	private AdminService adminService;
	
	

	Map<String, String> response = new HashMap<>();;

	@RequestMapping(value = "/MemberList", method = RequestMethod.GET)
	public void adminMemberListGET(Model model, HttpSession session, Criteria cri) {
		String member_id = (String) session.getAttribute("id");
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(adminService.getMemberTotalCount(member_id,cri));
		
		List<MemberVO> memberList = adminService.memberList(member_id, cri);
		
		model.addAttribute("memberList", memberList);
	    model.addAttribute("pageVO", pageVO);

	}

	@RequestMapping(value = "/getMemberInfo", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> memberDetails(@RequestBody MemberVO vo) {
		Map<String, Object> memberInfo = adminService.memberInfo(vo.getMember_id());

		// 결과를 ResponseEntity로 반환
		return ResponseEntity.ok(memberInfo);
	}

	@RequestMapping(value = "/updateMember", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>> updateMember(@RequestBody MemberVO vo) {
		response.clear();
		
		int result = adminService.memberUpdate(vo);
		if (result == 0) {
			response.put("message", "오류");
			return ResponseEntity.ok(response);
		}
		response.put("message", "수정");
		return ResponseEntity.ok(response);
	}

	@RequestMapping(value = "/deleteMember", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>> deleteMember(@RequestBody MemberVO vo) {
		response.clear();

		int result = adminService.memberDelete(vo);

		if (result == 0) {
			response.put("message", "오류");
			return ResponseEntity.ok(response);
		}
		response.put("message", "삭제");
		return ResponseEntity.ok(response);
	}

	@RequestMapping(value = "/signReq", method = RequestMethod.GET)
	public void memberRequest(Criteria cri,Model model) {
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(adminService.getWaitingMemberTotalCount(cri));
	    // 서비스 메서드 호출
	    List result = adminService.signupRequestList(cri);

	    if (!result.isEmpty()) {
	        model.addAttribute("WaitingList", result.get(0)); // 대기 회원 목록
	        model.addAttribute("EmpList", result.get(1));     // 직원 목록
	        model.addAttribute("DeptList", result.get(2));    // 부서 목록
	        model.addAttribute("pageVO", pageVO);
	    }
	    
	}
	
	

	@PostMapping("/signReq")
	public ResponseEntity<String> SignRequestUpdate(@RequestBody List<MemberVO> selectedMembers) {

		try {
			// 처리 로직 추가 (예: DB에 저장, 승인 처리 등)
			adminService.membersUpdate(selectedMembers);

			// 성공 응답 반환
			return ResponseEntity.ok("{\"result\": true}");
		} catch (Exception e) {
			// 예외 처리
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("{\"result\": false, \"message\": \"업데이트 중 오류가 발생했습니다.\"}");
		}
	}

	@PostMapping("/signReqDelete")
	public ResponseEntity<String> SignRequestDelete(@RequestBody List<MemberVO> selectedMembers) {

		try {
			// 처리 로직 추가 (예: DB에 저장, 승인 처리 등)
			adminService.membersDelete(selectedMembers);

			// 성공 응답 반환
			return ResponseEntity.ok("{\"result\": true}");
		} catch (Exception e) {
			// 예외 처리
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("{\"result\": false, \"message\": \"업데이트 중 오류가 발생했습니다.\"}");
		}
	}


	@RequestMapping(value = "/companySignUpModal", method = RequestMethod.GET)
	public void companyList(Model model) {
		 List<CompanyVO> result = cService.getCompanyList();
		 model.addAttribute("companyList", result );
	}
	
	

	@RequestMapping(value = "/companySignUpModal", method = RequestMethod.POST)
	public ResponseEntity<CompanyVO> companySignUpGET(@RequestBody CompanyVO company_code) {
	    if (company_code == null || company_code.getCompany_code() == null) {
	        return ResponseEntity.badRequest().body(null); // 400 Bad Request
	    }

	    CompanyVO result = cService.getCompany(company_code.getCompany_code()); 
	    
	    if (result == null) {
	        return ResponseEntity.notFound().build(); // 404 Not Found
	    }

	    return ResponseEntity.ok(result); // 200 OK
	}

	@RequestMapping(value = "/checkUserEamil", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>>  checkUserEmail(@RequestBody MemberVO email) {
		response.clear();

	    try {
	        MemberVO result = mService.memberEmailSearch(email.getMember_email());

	        if (result != null) {
	            // 중복된 이메일이 있을 경우
	        	response.put("message", "중복된 이메일입니다.");
	        	response.put("result", "false");
	            return ResponseEntity.ok(response);
	        } else {
	            // 사용 가능한 이메일인 경우
	        	response.put("result", "true");
	        	response.put("message", "사용 가능한 이메일입니다.");
	        	return ResponseEntity.ok(response);
	        }
	    } catch (Exception e) {
	        // 예외 처리
	        response.put("message", "업데이트 중 오류가 발생했습니다.");
	        response.put("result", "false");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body(response);
	    }
	}
	
	
	
	@RequestMapping(value = "/checkUserId", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>>  checkUserId(@RequestBody MemberVO member_id) {
		response.clear();

	    try {
	        MemberVO result = mService.memberIdCheck(member_id.getMember_id());

	        if (result != null) {
	            // 중복된 이메일이 있을 경우
	        	response.put("message", "중복된 아이디입니다.");
	        	response.put("result", "false");
	            return ResponseEntity.ok(response);
	        } else {
	            // 사용 가능한 이메일인 경우
	        	response.put("result", "true");
	        	response.put("message", "사용가능한 아이디 입니다!");
	        	return ResponseEntity.ok(response);
	        }
	    } catch (Exception e) {
	        // 예외 처리
	        response.put("message", "업데이트 중 오류가 발생했습니다.");
	        response.put("result", "false");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body(response);
	    }
	}
	
	@RequestMapping(value ="/companyMemberSignUp" , method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> memberSignUpPost(@RequestBody MemberVO vo) {
		response.clear();

		String result = adminService.companyMemberJoin(vo);

		// 중복 체크에 대한 메시지를 매핑
		Map<String, String> messageMap = new HashMap<>();
		messageMap.put("아이디 중복", "이미 등록된 아이디입니다.");
		messageMap.put("이메일 중복", "이미 등록된 이메일입니다.");
		messageMap.put("전화번호 중복", "이미 등록된 전화번호입니다.");

		if (messageMap.containsKey(result)) {
		    response.put("message", messageMap.get(result));
		    return ResponseEntity.ok(response); // 200 OK 응답
		}

		// 회원가입 실행
		response.put("message", "회원가입이 성공적으로 완료되었습니다!");
		return ResponseEntity.ok(response); // 200 OK 응답
	}

	
	 @PostMapping("/updatePermission")
	    public ResponseEntity<String> updatePermission(@RequestBody MemberVO vo) {
		 
	    	int result = adminService.memberPermissionUpdate(vo);
	    	
	    	if(result == 0) {
	    		return ResponseEntity.ok("{\"success\": false }");
	    	}
	    	
	    	return ResponseEntity.ok("{\"success\": true }");
	    }
	 
	 @RequestMapping(value = "/companyMemberCheck", method = RequestMethod.POST)
		public ResponseEntity<Map<String, String>>  companyMemberCheck(@RequestBody CompanyVO vo) {
			response.clear();

		    try {
		        MemberVO result = adminService.memberCodeCheck(vo);

		        if (result != null) {
		            // 중복된 이메일이 있을 경우
		        	response.put("message", "이미 회원가입한 거래처 입니다.");
		        	response.put("result", "false");
		            return ResponseEntity.ok(response);
		        } else {
		            // 사용 가능한 이메일인 경우
		        	response.put("result", "true");
		        	response.put("message", "회원가입이 가능한 거래처 입니다!");
		        	return ResponseEntity.ok(response);
		        }
		    } catch (Exception e) {
		        // 예외 처리
		        response.put("message", "업데이트 중 오류가 발생했습니다.");
		        response.put("result", "false");
		        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
		                .body(response);
		    }
		}
	 
	 
	 @RequestMapping(value = "/sendEmail", method = RequestMethod.POST)
	 public ResponseEntity<Map<String, String>>  sendEmail(@RequestBody CompanyVO vo) {
		 response.clear();
		 
		 try {
			 
			MemberVO result = adminService.memberCodeCheck(vo);
			int resultInt = eService.sendIdPwCode(result); 
			 if (resultInt == 0) {
				 // 중복된 이메일이 있을 경우
				 response.put("message", "비밀번호 변경중 오류가 발생했습니다.");
				 response.put("result", "false");
			 } else {
				 // 사용 가능한 이메일인 경우
				 response.put("result", "true");
				 response.put("message", "변경된 비밀번호를 전송하였습니다.!");
			 }
			 return ResponseEntity.ok(response);
		 } catch (Exception e) {
			 // 예외 처리
			 response.put("message", "업데이트 중 오류가 발생했습니다.");
			 response.put("result", "false");
			 return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					 .body(response);
		 }
	 }
	 
	 @RequestMapping(value = "/CompanyMemberList", method = RequestMethod.GET)
		public void ConpanyMemberListGET(Model model, HttpSession session, Criteria cri) {
			
		 	String member_id = (String) session.getAttribute("id");
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(adminService.getCompanyMemberTotalCount(member_id,cri));
			
			List<MemberVO> memberList = adminService.getCompanymemberList(member_id, cri);
			
			model.addAttribute("memberList", memberList);
		    model.addAttribute("pageVO", pageVO);
		    

		}
	 
	 
	 	@RequestMapping(value ="/deleteCompanyMember" , method=RequestMethod.POST)
	 	public ResponseEntity<Map<String, String>> deleteCompanyMember(@RequestBody MemberVO vo){
	 		response.clear();
			 
			 try {
				 
				 int result = adminService.deleteCompanyMember(vo);
				 
				 if (result == 0) {
					 // 중복된 이메일이 있을 경우
					 response.put("message", "삭제중 오류가 발생했습니다.");
					 response.put("result", "false");
				 } else {
					 // 사용 가능한 이메일인 경우
					 response.put("result", "true");
					 response.put("message", "거래처 아이디 삭제를 했습니다.!");
				 }
				 return ResponseEntity.ok(response);
			 } catch (Exception e) {
				 // 예외 처리
				 response.put("message", "업데이트 중 오류가 발생했습니다.");
				 response.put("result", "false");
				 return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
						 .body(response);
			 }
	 	}
	 	
	 	
	 	
	 
	 
	 
}
