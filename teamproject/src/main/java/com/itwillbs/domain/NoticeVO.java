package com.itwillbs.domain;

import java.util.Date;

/**
 * 공지사항 데이터 객체
 */
public class NoticeVO {
    private int no;                 // 공지사항 번호
    private String title;           // 제목
    private String content;         // 내용
    private Date regdate;           // 등록일
    private Date fixdate;           // 수정일
    private String writer;          // 작성자
    private boolean pinned;         // 고정 여부 추가

    // Getters and Setters
    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getRegdate() {
        return regdate;
    }

    public void setRegdate(Date regdate) {
        this.regdate = regdate;
    }

    public Date getFixdate() {
        return fixdate;
    }

    public void setFixdate(Date fixdate) {
        this.fixdate = fixdate;
    }

    public String getWriter() {
        return writer; // 작성자 getter
    }

    public void setWriter(String writer) {
        this.writer = writer; // 작성자 setter
    }

    public boolean isPinned() { // pinned getter
        return pinned;
    }

    public void setPinned(boolean pinned) { // pinned setter
        this.pinned = pinned;
    }

    // 유효성 검사 메소드 추가
    public void validate() {
        if (title == null || title.isEmpty()) {
            throw new IllegalArgumentException("제목은 필수 입력 항목입니다.");
        }
        if (content == null || content.isEmpty()) {
            throw new IllegalArgumentException("내용은 필수 입력 항목입니다.");
        }
        if (writer == null || writer.isEmpty()) {
            throw new IllegalArgumentException("작성자는 필수 입력 항목입니다.");
        }
    }
}
