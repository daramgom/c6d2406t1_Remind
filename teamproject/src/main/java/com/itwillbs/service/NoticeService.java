package com.itwillbs.service;

import java.util.List;
import com.itwillbs.domain.NoticeVO;

/**
 * 공지사항 관련 비즈니스 로직을 정의하는 서비스 인터페이스
 */
public interface NoticeService {

    // 공지사항 추가
    void addNotice(NoticeVO notice);

    // 모든 공지사항 조회
    List<NoticeVO> getNotices();

    // 특정 공지사항 조회
    NoticeVO getNotice(int noticeNo); // 기존 메서드 유지

    // 공지사항 ID로 조회 (새로운 메서드 추가)
    NoticeVO getNoticeById(int noticeNo); 

    // 공지사항 수정
    void updateNotice(NoticeVO notice);

    // 공지사항 삭제
    void deleteNotice(int noticeNo);

    // 공지사항 Pinned 상태 설정
    void pinNotice(int noticeNo, boolean pinned);

    // Pinned 공지사항 조회
    List<NoticeVO> getPinnedNotices();
}
