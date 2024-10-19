package com.itwillbs.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.NoticeVO;
import com.itwillbs.service.NoticeService;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {

    private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

    @Autowired
    private NoticeService noticeService;

    // 공지사항 목록 조회
    @GetMapping("/noticeList")
    public String list(Model model) {
        List<NoticeVO> noticeList = noticeService.getNotices();
        model.addAttribute("noticeList", noticeList);
        logger.info("공지사항 목록 조회, 총 {} 건", noticeList.size());
        return "noticeList"; // JSP 페이지 경로
    }

    // 공지사항 추가 폼
    @GetMapping("/noticeInsert")
    public String addForm() {
        logger.info("공지사항 추가 폼 요청");
        return "noticeInsert"; // 공지사항 추가 JSP 페이지 경로
    }

    // 공지사항 추가 처리
    @PostMapping("/noticeInsert")
    public String addNotice(NoticeVO notice) {
        logger.info("공지사항 추가 요청, 제목: {}, 작성자: {}", notice.getTitle(), notice.getWriter());
        noticeService.addNotice(notice);
        logger.info("공지사항 추가 완료, 제목: {}", notice.getTitle());
        return "redirect:/notice/noticeList"; // 추가 후 목록 페이지로 리다이렉트
    }

    // 본문 내용 보기
    @GetMapping("/view")
    public String viewNotice(@RequestParam("no") int noticeNo, Model model) {
        NoticeVO notice = noticeService.getNotice(noticeNo);
        model.addAttribute("notice", notice);
        logger.info("공지사항 조회, ID: {}", noticeNo);
        return "noticeView"; // 공지사항 상세 JSP 페이지 경로
    }

 // 공지사항 수정 폼
    @GetMapping("/noticeEdit")
    public String editForm(@RequestParam("no") int noticeNo, Model model) {
        // 수정할 공지사항 정보를 조회
        NoticeVO notice = noticeService.getNoticeById(noticeNo);
        model.addAttribute("notice", notice);
        logger.info("공지사항 수정 폼 요청, ID: {}", noticeNo);
        return "noticeEdit"; // 공지사항 수정 JSP 페이지 경로
    }


 // 공지사항 수정 처리
    @PostMapping("/edit")
    public String editNotice(@ModelAttribute NoticeVO notice) {
        // 공지사항 수정 서비스 호출
        noticeService.updateNotice(notice);
        logger.info("공지사항 수정 완료, ID: {}", notice.getNo());
        return "redirect:/notice/noticeList"; // 수정 후 목록 페이지로 리다이렉트
    }


    // 공지사항 삭제 처리
    @PostMapping("/delete")
    public String deleteNotice(@RequestParam("no") int noticeNo) {
        noticeService.deleteNotice(noticeNo);
        logger.info("공지사항 삭제 요청, ID: {}", noticeNo);
        return "redirect:/notice/noticeList"; // 삭제 후 목록 페이지로 리다이렉트
    }
}
