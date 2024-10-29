package com.itwillbs.service;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.mail.VerificationCodeGenerator;
import com.itwillbs.persistence.MemberDAO;

@Service
public class EmailService {
	
	@Autowired
    private JavaMailSender mailSender;
	
	// 인증 코드를 저장할 맵
    private ConcurrentHashMap<String, VerificationEntry> verificationCodes = new ConcurrentHashMap<>();

    // 스케줄러 서비스
    private ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    
    // 쓰레드풀 생성
    private ExecutorService emailExecutor = Executors.newCachedThreadPool();
    
    // MemberDAO 객체 주입
 	@Inject
 	private MemberDAO mdao;
    

    
    public int sendIdPwCode(MemberVO vo) {
    	String verificationCode = VerificationCodeGenerator.generateVerificationCode();
    	String hashedPassword = BCrypt.hashpw(verificationCode, BCrypt.gensalt());
    	
    	vo.setMember_pw(hashedPassword);
    	int result = mdao.updatePw(vo);
    	
    	
    	
    	String subject = "부산 ITWILL 재고관리 시스템 ID, 변경된 PW 발송";
//      여기서 태그를 꾸밀 수 있음.
       String body = "<!DOCTYPE html>"
    		   + "<html lang=\"ko\">"
               + "<head>"
               + "    <meta charset=\"UTF-8\">"
               + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
               + "</head>"
               + "<body style=\"font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0;\">"
               + "    <div style=\"background-color: #ffffff; border-radius: 8px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); max-width: 600px; margin: 20px auto; padding: 20px; text-align : center;\">"
               + "        <img src=\"https://lh3.googleusercontent.com/pw/AP1GczMRNpEAjBt6pDduaBvxXIuleQDM1gda--SrYnezTcYGk9wk4jmV2rdROa3nIN4P-EmVGmeQzuQf4XS1rs1t-ijbwfze581bv9WDNXhTs_6AOBN_htVtg_3-M-typzW4NXU0F1kXCaVsaCE6L-ow45M=w538-h80-s-no-gm?authuser=0\" alt=\"로고\" style=\"max-width: 50%; height: auto;\" >"
               + "        <h1 style=\"font-size: 24px; color: #333; border-top: 1px solid; margin: 12px; padding: 10px;\">이메일 인증</h1>"
               + "        <p style=\"font-size: 16px; line-height: 1.5; color: #555; margin: 5px 0;\">안녕하세요! <span style=\"color: #5a00d8; \">REMIND</span> 재고관리 시스템 입니다.</p>"
               + "        <p style=\"font-size: 16px; line-height: 1.5; color: #555; margin: 5px 0;\">아이디 : <div style=\"font-size: 20px; font-weight: bold; color: #007BFF; margin: 20px 0;\">" + vo.getMember_id() + "</div></p>"
               + "        <p style=\"font-size: 16px; line-height: 1.5; color: #555; margin: 5px 0;\">임시 비밀번호  : <div style=\"font-size: 20px; font-weight: bold; color: #007BFF; margin: 20px 0;\">" + verificationCode + "</div></p>"
               + "        <p style=\"font-size: 16px; line-height: 1.5; color: #555; margin: 5px 0;\">요청하신 아이디와 임시 비밀번호입니다.</p>"
               + "        <p style=\"font-size: 16px; line-height: 1.5; color: #555; margin: 5px 0;\">감사합니다.</p>"
               + "    </div>"
               + "</body>"
               + "</html>";

       // 메일 전송을 쓰레드로 처리
       emailExecutor.submit(() -> {
           try {
               MimeMessage message = mailSender.createMimeMessage();
               MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
               
               helper.setTo(vo.getMember_email());
               helper.setSubject(subject);
               helper.setText(body, true);
               
               mailSender.send(message);
           } catch (Exception e) {
               e.printStackTrace();
           }
       });
    	
       
       return result;
    	
    }
    
    
    public void sendVerificationCode(String to) {
        String verificationCode = VerificationCodeGenerator.generateVerificationCode();
        long timestamp = System.currentTimeMillis();// 현재 시간// 인증 코드와 함께 생성 시간을 저장
     // 이메일을 소문자로 변환하여 저장
        verificationCodes.put(to.trim().toLowerCase(), new VerificationEntry(verificationCode, timestamp));


        
        

        String subject = "부산 ITWILL 재고관리 시스템 이메일 인증 코드";
//       여기서 태그를 꾸밀 수 있음.ㅍ verificationCode
        String body = "<!DOCTYPE html>"
                + "<html lang=\"ko\">"
                + "<head>"
                + "    <meta charset=\"UTF-8\">"
                + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
                + "</head>"
                + "<body style=\"font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0;\">"
                + "    <div style=\"background-color: #ffffff; border-radius: 8px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); max-width: 600px; margin: 20px auto; padding: 20px; text-align : center;\">"
                + "        <img src=\"https://lh3.googleusercontent.com/pw/AP1GczMRNpEAjBt6pDduaBvxXIuleQDM1gda--SrYnezTcYGk9wk4jmV2rdROa3nIN4P-EmVGmeQzuQf4XS1rs1t-ijbwfze581bv9WDNXhTs_6AOBN_htVtg_3-M-typzW4NXU0F1kXCaVsaCE6L-ow45M=w538-h80-s-no-gm?authuser=0\" alt=\"로고\" style=\"max-width: 50%; height: auto;\" >"
                + "        <h1 style=\"font-size: 24px; color: #333; border-top: 1px solid; margin: 12px; padding: 10px;\">이메일 인증</h1>"
                + "        <p style=\"font-size: 16px; line-height: 1.5; color: #555; margin: 5px 0;\">안녕하세요! <span style=\"color: #5a00d8; \">REMIND</span>  재고관리 시스템 입니다.</p>"
                + "        <p style=\"font-size: 16px; line-height: 1.5; color: #555; margin: 5px 0;\">다음 인증 코드를 입력하세요 : <div style=\"font-size: 20px; font-weight: bold; color: #007BFF; margin: 20px 0;\">" + verificationCode + "</div></p>"
                + "        <p style=\"font-size: 16px; line-height: 1.5; color: #555; margin: 5px 0;\">위 코드를 입력하여 인증을 완료해 주세요.</p>"
                + "        <p style=\"font-size: 16px; line-height: 1.5; color: #555; margin: 5px 0;\">감사합니다!</p>"
                + "    </div>"
                + "</body>"
                + "</html>";
        // 메일 전송을 쓰레드로 처리
        emailExecutor.submit(() -> {
            try {
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
                
                helper.setTo(to);
                helper.setSubject(subject);
                helper.setText(body, true);

                mailSender.send(message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        
        // 6분 후에 인증 코드를 삭제하는 작업 예약
        scheduler.schedule(() -> verificationCodes.remove(to), 6, TimeUnit.MINUTES);
    }

    public boolean verifyCode(String email, String code) {
    	VerificationEntry entry = verificationCodes.get(email.trim().toLowerCase());

        
        
        for (String key : verificationCodes.keySet()) {
        }
        if (entry != null) {
            // 5분 이내에 입력된 코드인지 확인
            if (System.currentTimeMillis() - entry.getTimestamp() <= TimeUnit.MINUTES.toMillis(5)) {
                // 코드 비교 (대소문자 무시 및 공백 제거)
                if (entry.getCode().equalsIgnoreCase(code.trim())) {
                    return true; // 인증 성공
                }
            }
        }
        return false; // 인증 실패
    }


    private static class VerificationEntry {
        private String code;
        private long timestamp;

        public VerificationEntry(String code, long timestamp) {
            this.code = code;
            this.timestamp = timestamp;
        }

        public String getCode() {
            return code;
        }

        public long getTimestamp() {
            return timestamp;
        }
    }
}