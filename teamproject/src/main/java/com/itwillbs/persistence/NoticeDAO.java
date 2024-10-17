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

    // 조회 수 증가
    void incrementViewCount(int noticeNo);
}
