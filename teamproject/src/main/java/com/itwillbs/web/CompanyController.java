package com.itwillbs.web;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
        return "companyList";
    }

    // 거래처 추가 폼
    @GetMapping("/companyInsert")
    public String addForm() {
        return "companyInsert";
    }

    // 거래처 추가 처리
    @PostMapping("/companyInsert")
    public String addCompany(@ModelAttribute CompanyVO company) {
        companyService.registerCompany(company);
        return "redirect:/company/companyList";
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
        return "redirect:/company/companyList";
    }

    // 거래처 삭제 처리 (GET 요청 - 주의: 보안상 권장되지 않음)
    @GetMapping("/delete/{companyCode}")
    public String deleteCompanyGet(@PathVariable String companyCode) {
        companyService.updateCompanyStatus(companyCode, "02");
        return "redirect:/company/companyList";
    }

    // 거래처 삭제 처리 (POST 요청 - 권장)
    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<String> deleteCompanyPost(@RequestBody CompanyVO company) {
        System.out.print(company.getCompany_code() + "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \n");
        companyService.updateCompanyStatus(company.getCompany_code(), "02");
        return ResponseEntity.ok("삭제가 완료되었습니다."); // 성공 메시지 반환
    }

//    // 기존의 POST 방식 삭제 처리 (파라미터로 받는 방식)
//    @PostMapping("/delete/")
//    public String updateCompanyStatus(@RequestParam("company_code") String companyCode) {
//        companyService.updateCompanyStatus(companyCode, "02");
//        return "redirect:/company/companyList";
//    }
}