package com.itwillbs.web;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.EmailService;
import com.itwillbs.service.MemberService;

@Controller
public class SignController {
	
	Map<String, String> response = new HashMap<>();
	
	@Inject
	private MemberService mService;
	
	@Autowired
    private EmailService emailService;
	
	// 회원가입 페이지 Get 요청
 	@RequestMapping(value ="signup" , method=RequestMethod.GET)
 	public void signupGet(  Model model , UserVO uvo) {
 		model.addAttribute("member" , uvo);
 	}
 	
	/*
	 * // 회원가입 페이지 Post 요청
	 * 
	 * @RequestMapping(value ="signup" , method=RequestMethod.POST) public void
	 * signupPOST(HttpSession session ,UserVO vo, Model model) {
	 * logger.debug("vo : " + vo); model.addAttribute("member",vo );
	 * session.removeAttribute("userInfo"); }
	 */	 	
	 	
 	// http://localhost:8088/membersignup
 	@RequestMapping(value ="membersignup" , method=RequestMethod.POST)
 	public ResponseEntity<Map<String, String>> memberSignUpPost(@RequestBody MemberVO vo) {
 		response.clear();

 		String result = mService.memberJoin(vo);

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
	 	
 	@RequestMapping(value ="/checkUserId" , method=RequestMethod.POST)
 	public ResponseEntity<Map<String, String>> memberIdcheck(@RequestBody MemberVO vo) {
 		response.clear();
 		
 		String member_id = vo.getMember_id();
 		
 		MemberVO result =  mService.memberIdCheck(member_id);
 		
 		if(result == null) {
 			response.put("message", "사용가능한 아이디 입니다!");
 			return ResponseEntity.ok(response); // 200 OK 응답  
     	}
     	
 		response.put("message", "이미 등록된 아이디 입니다! 다른 아이디를 입력해주세요.");
 		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);// 400 BAD REQUEST 응답  
 	}
 	
 	 @PostMapping("/sendVerificationCode")
     public ResponseEntity<Map<String, String>> sendVerificationCode(@RequestBody VerificationRequest request) {
     	response.clear(); // 메서드 시작 시 초기화
     	MemberVO result = mService.memberEmailSearch(request.getEmail());
     	
     	if(result != null) {
     		response.put("message", "이미 등록된 이메일 입니다! 다른 이메을을 입력해주세요.");
     		return	ResponseEntity.ok(response); // 200 응답
     	}
     		
 		emailService.sendVerificationCode(request.getEmail()); 
 		
 		response.put("message", "인증 코드가 이메일로 전송되었습니다!");
 		return ResponseEntity.ok(response); // 200 OK 응답  		
     	
     }

     @PostMapping("/verifyCode")
     public ResponseEntity<Map<String, String>> verifyCode(@RequestBody VerificationRequest request) {
     	response.clear(); // 메서드 시작 시 초기화
     	boolean isValid = emailService.verifyCode(request.getEmail(), request.getCode());
         
         if (isValid) {
             response.put("message", "인증이 완료되었습니다!");
             return ResponseEntity.ok(response); // 200 OK 응답
         } else {
             response.put("message", "인증 코드가 잘못되었거나 만료되었습니다.");
             return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response); // 400 BAD REQUEST 응답
         }
     }
     
     // 인증 코드 저장을 위한 DTO
     public static class VerificationRequest {
         private String email;
         private String code;

         //	Getters and Setters
         public String getEmail() { return email; }
         public void setEmail(String email) { this.email = email; }
         public String getCode() { return code; }
         public void setCode(String code) { this.code = code; }
     }
	
}
