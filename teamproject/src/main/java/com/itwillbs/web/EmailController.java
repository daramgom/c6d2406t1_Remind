	package com.itwillbs.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.service.EmailService;
import com.itwillbs.service.MemberService;

@RestController
public class EmailController {
	
	Map<String, String> response = new HashMap<>();

    @Autowired
    private EmailService emailService;
    
    @Autowired 
    private MemberService mService;

    @PostMapping("/sendVerificationCode")
    public ResponseEntity<Map<String, String>> sendVerificationCode(@RequestBody VerificationRequest request) {
    	response.clear(); // 메서드 시작 시 초기화
    	
    	System.out.println("eamil : "+ request.getEmail() );
    	
    	
    	MemberVO result = mService.memberEmailSearch(request.getEmail());
    	
    	
    	System.out.println("result : "+ result );
    	if(result != null) {
    		response.put("message", "이미 등록된 이메일 입니다! 다른 이메을을 입력해주세요.");
    		return	ResponseEntity.ok(response); // 200 응답
    	}
    		
		emailService.sendVerificationCode(request.getEmail()); 
		
		response.put("message", "인증 코드가 이메일로 전송되었습니다!");
		return ResponseEntity.ok(response); // 200 OK 응답  		
    	
    }
    
    @PostMapping("/findMemberInfo")
    public ResponseEntity<Map<String, String>> findMemberInfo(@RequestBody MemberVO vo) {
    	response.clear(); // 메서드 시작 시 초기화
    	
    	System.out.println("eamil : "+ vo );
    	
    	
    	MemberVO result = mService.memberIdEmailSearch(vo);
    	
    	
    	System.out.println("result : "+ result );
    	if(result == null) {
    		response.put("message", "등록된 정보와 다릅니다.");
    		response.put("result", "false");
    		return	ResponseEntity.ok(response); // 200 응답
    		
    	}
    	
    	emailService.sendVerificationCode(result.getMember_email()); 
    	
    	response.put("result", "true");
    	response.put("message", "인증 코드가 이메일로 전송되었습니다!");
    	return ResponseEntity.ok(response); // 200 OK 응답  		
    	
    }

    @PostMapping("/verifyCode")
    public ResponseEntity<Map<String, String>> verifyCode(@RequestBody VerificationRequest request) {
    	response.clear(); // 메서드 시작 시 초기화
    	System.out.println("인증코드 : "+ request.getCode() );
    	
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

// Getters and Setters
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getCode() { return code; }
        public void setCode(String code) { this.code = code; }
    }
}