package com.itwillbs.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.stereotype.Component;

@Component
@WebListener
public class MySessionListener implements HttpSessionListener {

	 // 세션 체크 키를 저장할 맵
    private static final Map<String, String> sessions = new ConcurrentHashMap<>();

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        // 세션 생성 시 별도 처리 없음
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        // 세션 종료 시 해당 세션 체크 키 삭제
        sessions.values().removeIf(key -> key.equals(session.getId())); // 예: 세션 ID와 비교
    }

    // 사용자 ID와 세션 체크 키를 추가하는 메서드
    public void addSession(String userId, String sessionCheckKey) {
        sessions.put(userId, sessionCheckKey); // 사용자 ID를 키로 사용
    }
    
    
    // 세션 체크 키 검증 메서드
    public boolean validateSessionKey(String userId, String sessionCheckKey) {
    	System.out.println("result : 제발 " + sessions );
    	System.out.println("result : 제발 " + sessionCheckKey );
        // 사용자 ID로 세션 체크 키를 가져와서 비교
        String storedSessionKey = sessions.get(userId); // 사용자 ID로 저장된 세션 체크 키 가져오기
        boolean result = storedSessionKey != null && storedSessionKey.equals(sessionCheckKey); // 세션 체크 키가 일치하는지 확인
        System.out.println("result : 제발 " + result );
        return result;
    }
    
}
