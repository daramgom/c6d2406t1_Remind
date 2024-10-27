package com.itwillbs.persistence;

import java.util.List;
import com.itwillbs.domain.NoticeVO;

/**
 * 
 * tbl_notice 테이블의 데이터를 활용하는 동작을 정의 
 *  
 */
public interface NoticeDAO {
    
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

    // 고정된 공지사항 조회
    List<NoticeVO> getPinnedNotices();

    // 공지사항 고정 상태 업데이트
    void updatePinnedStatus(int noticeNo, boolean pinned);
    
    // Pinned 상태를 설정하는 메서드 추가
    void pinNotice(int noticeNo, boolean pinned);
}
