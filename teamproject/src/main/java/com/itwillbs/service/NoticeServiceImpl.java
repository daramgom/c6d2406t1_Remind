package com.itwillbs.service;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.itwillbs.domain.NoticeVO;
import com.itwillbs.persistence.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeDAO noticeDAO;

    private static final Logger logger = LoggerFactory.getLogger(NoticeServiceImpl.class);

    @Override
    public void addNotice(NoticeVO notice) {
        logger.debug("공지사항 추가 메서드 호출: addNotice(NoticeVO notice)");

        // 파라미터 로그 추가
        logger.debug("제목: {}", notice.getTitle());
        logger.debug("내용: {}", notice.getContent());
        logger.debug("작성자: {}", notice.getWriter());
       
        noticeDAO.addNotice(notice);
    }

    @Override
    public List<NoticeVO> getNotices() {
        logger.debug("모든 공지사항 조회 메서드 호출: getNotices()");
        return noticeDAO.getNotices();
    }

    @Override
    public NoticeVO getNotice(int noticeNo) {
        logger.debug("특정 공지사항 조회 메서드 호출: getNotice(int noticeNo) - 번호: " + noticeNo);
        return noticeDAO.getNotice(noticeNo);
    }

    // 새로운 메서드 추가
    @Override
    public NoticeVO getNoticeById(int noticeNo) {
        logger.debug("ID로 공지사항 조회 메서드 호출: getNoticeById(int noticeNo) - 번호: " + noticeNo);
        return noticeDAO.getNotice(noticeNo); // DAO에서 동일한 메서드 사용
    }

    @Override
    public void updateNotice(NoticeVO notice) {
        logger.debug("공지사항 수정 메서드 호출: updateNotice(NoticeVO notice)");
        noticeDAO.updateNotice(notice);
    }

    @Override
    public void deleteNotice(int noticeNo) {
        logger.debug("공지사항 삭제 메서드 호출: deleteNotice(int noticeNo) - 번호: " + noticeNo);
        noticeDAO.deleteNotice(noticeNo);
    }

    // Pinned 기능 추가
    @Override
    public void pinNotice(int noticeNo, boolean pinned) {
        logger.debug("공지사항 Pinned 상태 설정 메서드 호출: pinNotice(int noticeNo, boolean pinned) - 번호: " + noticeNo + ", Pinned: " + pinned);
        noticeDAO.pinNotice(noticeNo, pinned);
    }

    @Override
    public List<NoticeVO> getPinnedNotices() {
        logger.debug("Pinned 공지사항 조회 메서드 호출: getPinnedNotices()");
        return noticeDAO.getPinnedNotices();
    }
}
