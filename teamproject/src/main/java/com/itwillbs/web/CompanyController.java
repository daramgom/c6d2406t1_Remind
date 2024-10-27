package com.itwillbs.web;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/company/*")
public class CompanyController {

    @Autowired
    private CompanyService companyService;

    // 거래처 목록 조회
    @GetMapping("/companyList")
    public String list(Model model) {
        List<CompanyVO> companyList = companyService.getCompanyList();
        model.addAttribute("companyList", companyList);
        return "companyList"; // JSP 페이지 경로
    }

    // 거래처 추가 폼
    @GetMapping("/companyInsert")
    public String addForm() {
        return "companyInsert"; // 거래처 추가 JSP 페이지 경로
    }

    // 거래처 추가 처리
    @PostMapping("/companyInsert")
    public String addCompany(@ModelAttribute CompanyVO company) {
        companyService.registerCompany(company);
        return "redirect:/company/companyList"; // 추가 후 목록 페이지로 리다이렉트
    }
    // 거래처 조회
    @GetMapping("/view/{companyCode}")
    public String viewCompany(@PathVariable String companyCode, Model model) {
        CompanyVO company = companyService.getCompanyByCode(companyCode);
        model.addAttribute("company", company);
        return "companyView";
    }
    // 거래처 수정 폼
    @GetMapping("/edit/{companyCode}")
    public String editForm(@PathVariable String companyCode, Model model) {
        CompanyVO company = companyService.getCompanyByCode(companyCode);
        model.addAttribute("company", company);
        return "companyEdit";
    }

    // 거래처 수정 처리
    @PostMapping("/edit")
    public String editCompany(@ModelAttribute CompanyVO company) {
        companyService.updateCompany(company);
        return "redirect:/company/companyList"; // 수정 후 목록 페이지로 리다이렉트
    }

    // 거래처 삭제 처리 (논리적 삭제)
    @PostMapping("/delete")
    public String updateCompanyStatus(@RequestParam("company_code") String companyCode) {
        companyService.updateCompanyStatus(companyCode, "02"); // "02"는 삭제 상태를 나타냄
        return "redirect:/company/companyList"; // 삭제 후 목록 페이지로 리다이렉트
    }
}