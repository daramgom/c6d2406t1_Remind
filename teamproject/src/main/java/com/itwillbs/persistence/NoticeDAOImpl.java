package com.itwillbs.persistence;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.itwillbs.domain.NoticeVO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.itwillbs.mapper.NoticeMapper"; // MyBatis 매퍼 XML의 네임스페이스

    @Override
    public void addNotice(NoticeVO notice) {
        sqlSession.insert(NAMESPACE + ".addNotice", notice);
    }

    @Override
    public List<NoticeVO> getNotices() {
        return sqlSession.selectList(NAMESPACE + ".getNotices");
    }

    @Override
    public NoticeVO getNotice(int noticeNo) {
        return sqlSession.selectOne(NAMESPACE + ".getNotice", noticeNo);
    }

    @Override
    public void updateNotice(NoticeVO notice) {
        sqlSession.update(NAMESPACE + ".updateNotice", notice);
    }

    @Override
    public void deleteNotice(int noticeNo) {
        sqlSession.delete(NAMESPACE + ".deleteNotice", noticeNo);
    }

    @Override
    public List<NoticeVO> getPinnedNotices() {
        return sqlSession.selectList(NAMESPACE + ".getPinnedNotices");
    }

    @Override
    public void updatePinnedStatus(int noticeNo, boolean pinned) {
        sqlSession.update(NAMESPACE + ".updatePinnedStatus", 
                          new PinnedStatusUpdate(noticeNo, pinned ? 1 : 0));
    }

    // Pinned 상태를 설정하는 메서드 추가
    @Override
    public void pinNotice(int noticeNo, boolean pinned) {
        updatePinnedStatus(noticeNo, pinned);
    }

    // 내부 클래스 또는 DTO를 사용하여 noticeNo와 pinned 상태를 함께 전달
    private static class PinnedStatusUpdate {
        private int noticeNo;
        private int pinned;

        public PinnedStatusUpdate(int noticeNo, int pinned) {
            this.noticeNo = noticeNo;
            this.pinned = pinned;
        }

        public int getNoticeNo() {
            return noticeNo;
        }

        public int getPinned() {
            return pinned;
        }
    }
}
