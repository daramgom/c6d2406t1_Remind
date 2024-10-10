package com.itwillbs.web;


import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.login.SNSLogin;
import com.itwillbs.login.SnsValue;
import com.itwillbs.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Inject
	private SnsValue naverSns;
	
	@Inject
	private UserService service;
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	// http://localhost:8088/login
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String snsLogin(Model model) {
		logger.info(" Login page ");
		SNSLogin snsLogin = new SNSLogin(naverSns);
		
		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
		
		return "login";
	}
	
	@RequestMapping(value = "/auth/naver/callback", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginCallback(@RequestParam String code, HttpSession session) throws Exception {
	    SNSLogin snsLogin = new SNSLogin(naverSns);
	    UserVO snsUser = snsLogin.getUserProfile(code);
	    
	    logger.info("Profile >> " + snsUser);
	    
	    // DB에서 사용자 정보 가져오기
	    MemberVO member = service.getBySns(snsUser.getTel());
	    System.out.println("member : " + member);
	    
	    if (member == null) {
	    	session.setAttribute("isFirstVisit", true);
	        return "redirect:/notify"; // notify 페이지로 리다이렉트
	    } 
	    
	    session.setAttribute("isFirstVisit", false);
	    session.setAttribute("id", member.getMember_id());
	    return "redirect:/main"; // 메인 페이지로 리다이렉트
	}
	
		// http://localhost:8088/notify
		@RequestMapping(value = "/notify", method = RequestMethod.GET)
		public void notifyGET(HttpSession session) {
			
			logger.info(" notify ");
			// 세션 값을 false로 변경
			
		}
	
}
