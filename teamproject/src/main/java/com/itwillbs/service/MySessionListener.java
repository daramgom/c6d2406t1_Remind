package com.itwillbs.service;


import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;

public class MySessionListener implements HttpSessionListener {

	 @Autowired
	    private MemberService memberService; // 서비스 의존성 주입

	    @Override
	    public void sessionCreated(HttpSessionEvent se) {
	        // 세션 생성 시 처리
	        System.out.println("세션 생성: " + se.getSession().getId());
	    }

	    @Override
	    public void sessionDestroyed(HttpSessionEvent se) {
	        // 세션 종료 시 처리
	        HttpSession session = se.getSession();
	        String userId = (String) session.getAttribute("id"); // 세션에서 사용자 ID 가져오기

	        if (userId != null) {
	            memberService.logout(userId); // 서비스 메서드를 호출하여 세션 제거
	            System.out.println("세션 종료: " + session.getId() + " 사용자 ID: " + userId);
	        } else {
	            System.out.println("세션 종료: " + session.getId() + " (사용자 ID 없음)");
	        }
	    }
}