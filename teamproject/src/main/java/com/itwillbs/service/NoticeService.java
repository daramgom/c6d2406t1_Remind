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
    NoticeVO getNotice(int noticeNo);

    // 공지사항 수정
    void updateNotice(NoticeVO notice);

    // 공지사항 삭제
    void deleteNotice(int noticeNo);

    // 조회 수 증가
    void incrementViewCount(int noticeNo);
}
