package com.itwillbs.web;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.CordersVO;
import com.itwillbs.domain.MainVO;
import com.itwillbs.service.MainService;

@Controller
@RequestMapping(value = "/*")
public class MainController {
	private MainService mService;
	
	public MainController(MainService mService) {
		this.mService = mService;
	}
	
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@RequestMapping(value = "/main",method = RequestMethod.GET)
	public void mainPageGET(Model model, HttpSession session) {
		logger.debug("( •̀ ω •́ )✧ MainController : /main -> mainPageGET(Model model)실행");
		MainVO vo = mService.getQty();
		model.addAttribute("MainQty", vo);
		logger.debug("( •̀ ω •́ )✧ MainController : vo : "+vo);
	}
	
	@PostMapping(value = "/main")
	@ResponseBody
	public ResponseEntity<List<MainVO>> mainPagePOST() {
		logger.debug("( •̀ ω •́ )✧ MainController : /main -> mainPagePOST(Model model)실행");
		List<MainVO> dayList = mService.dayQty();
		logger.debug("( •̀ ω •́ )✧ MainController : dayList : "+dayList.size());
		return ResponseEntity.ok(dayList);
	}
	
	
    @GetMapping("/cmain")
    public String cmainGET(Model model) {
    	logger.debug("( •̀ ω •́ )✧ MainController : /cmain -> cmainGET(Model model)실행");
    	
    	
    	
        return "cmain";
    }
	
	
}
