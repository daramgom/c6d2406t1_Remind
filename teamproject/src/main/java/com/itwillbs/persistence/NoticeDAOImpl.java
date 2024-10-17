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
    public void incrementViewCount(int noticeNo) {
        sqlSession.update(NAMESPACE + ".incrementViewCount", noticeNo);
    }
}

