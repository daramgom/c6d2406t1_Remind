package com.itwillbs.web;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.service.CompanyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/company/*")
public class CompanyController {

    private static final Logger logger = LoggerFactory.getLogger(CompanyController.class);

    @Autowired
    private CompanyService companyService; // CompanyService 주입

    // 거래처 목록 조회
    @GetMapping("/companyList")
    public String list(Model model) {
        logger.info("거래처 목록 조회 요청");
        
        List<CompanyVO> companyList = companyService.getCompanyList();
        model.addAttribute("companyList", companyList);
        
        logger.info("거래처 목록 조회 완료, 목록 크기: {}", companyList.size());
        return "companyList"; // JSP 페이지로 이동
    }

    // 거래처 등록 폼
    @GetMapping("/companyInsert")
    public String registerForm() {
        logger.info("거래처 등록 폼 요청");
        return "companyInsert"; // JSP 페이지로 이동
    }

    // 거래처 등록 처리
    @PostMapping("/companyInsert")
    public String register(@ModelAttribute CompanyVO company) {
        logger.info("거래처 등록 요청, 거래처 코드: {}", company.getCompany_code());
        companyService.registerCompany(company); // 거래처 등록
        logger.info("거래처 등록 완료, 거래처 코드: {}", company.getCompany_code());
        return "redirect:/company/companyList"; // 등록 후 목록으로 리다이렉트
    }

    // 거래처 상세 조회
    @GetMapping("/view/{companyCode}")
    public String view(@PathVariable("companyCode") String companyCode, Model model) {
        logger.info("거래처 상세 조회 요청, 거래처 코드: {}", companyCode);
        
        CompanyVO company = companyService.getCompanyByCode(companyCode);
        model.addAttribute("company", company);
        
        logger.info("거래처 상세 조회 완료, 거래처 코드: {}", companyCode);
        return "companyView"; // JSP 페이지로 이동
    }

    // 거래처 수정 폼
    @GetMapping("/edit/{companyCode}")
    public String editForm(@PathVariable("companyCode") String companyCode, Model model) {
        logger.info("거래처 수정 폼 요청, 거래처 코드: {}", companyCode);
        
        CompanyVO company = companyService.getCompanyByCode(companyCode);
        model.addAttribute("company", company);
        
        logger.info("거래처 수정 폼 조회 완료, 거래처 코드: {}", companyCode);
        return "companyEdit"; // JSP 페이지로 이동
    }

    // 거래처 수정 처리
    @PostMapping("/edit")
    public String edit(@ModelAttribute CompanyVO company) {
        logger.info("거래처 수정 요청, 거래처 코드: {}", company.getCompany_code());
        
        companyService.updateCompany(company); // 거래처 수정
        logger.info("거래처 수정 완료, 거래처 코드: {}", company.getCompany_code());
        
        return "redirect:/company/view/" + company.getCompany_code(); // 수정 후 상세 조회로 리다이렉트
    }

    // 거래처 삭제 처리
    @PostMapping("/delete/{companyCode}")
    public String delete(@PathVariable("companyCode") int companyCode) {
        logger.info("거래처 삭제 요청, 거래처 코드: {}", companyCode);
        
        companyService.deleteCompany(companyCode); // 거래처 삭제
        logger.info("거래처 삭제 완료, 거래처 코드: {}", companyCode);
        
        return "redirect:/company/companyList"; // 삭제 후 목록으로 리다이렉트
    }
}
