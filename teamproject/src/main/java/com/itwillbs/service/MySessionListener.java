package com.itwillbs.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.servlet.annotation.WebListener;

import org.springframework.stereotype.Component;

@Component
@WebListener
public class MySessionListener  {

	 // 세션 체크 키를 저장할 맵
    private static final Map<String, String> sessions = new ConcurrentHashMap<>();


    // 사용자 ID와 세션 체크 키를 추가하는 메서드
    public void addSession(String userId, String sessionCheckKey) {
        sessions.put(userId, sessionCheckKey); // 사용자 ID를 키로 사용
    }
    
    
    // 세션 체크 키 검증 메서드
    public boolean validateSessionKey(String userId, String sessionCheckKey) {
        // 사용자 ID로 세션 체크 키를 가져와서 비교
        String storedSessionKey = sessions.get(userId); // 사용자 ID로 저장된 세션 체크 키 가져오기
        boolean result = storedSessionKey != null && storedSessionKey.equals(sessionCheckKey); // 세션 체크 키가 일치하는지 확인
        return result;
    }
    
}
