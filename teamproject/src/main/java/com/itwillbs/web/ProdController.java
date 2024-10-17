package com.itwillbs.web;
//@RequestMapping(value = "/member/*")
//	--> 특정 동작의 형태를 구분 (*.me, *.bo, *.do)

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

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

import com.itwillbs.domain.ProdVO;
import com.itwillbs.persistence.ProdDAO;
import com.itwillbs.service.ProdService;

// servlet-context.xml
// <context:component-scan base-package="com.itwillbs.web" />

@Controller
@RequestMapping(value = "/prod/*")
public class ProdController {
	
	// 객체 주입 --> 이후 서비스 영역에서 동작 구현
	// @Inject
	// private ProdDAO pdao;
	
	// 생성자 주입
	private ProdService pService;
	
	public ProdController(ProdService pService) {
		this.pService = pService;
	}
	private static final Logger logger = LoggerFactory.getLogger(ProdController.class);
	
	
	// 제품등록 - 정보입력 페이지
	// http://localhost:8088/prod/insert
	@RequestMapping(value = "/insert",method = RequestMethod.GET)
	public void insertProdGet() {
		logger.debug(" ( •̀ ω •́ )✧ /prod/insert -> insertProdGet() 실행 ");
		logger.debug(" ( •̀ ω •́ )✧ 연결된 뷰(jsp)를 보여주기 ");
		// 페이지 이동(X) --> 스프링이 자동으로 연결
		logger.debug(" ( •̀ ω •́ )✧ /views/prod/insert.jsp 뷰페이지 연결 ");
	}
	
	// 제품등록 - 정보처리
	@RequestMapping(value = "/insert",method = RequestMethod.POST)
	public void insertProdPost(ProdVO vo, HttpServletRequest req) {
		logger.debug(" ( •̀ ω •́ )✧ /prod/insert -> insertProdPost() 실행 ");
		// 한글 인코딩 처리
		// 	--> web.xml filter 처리
		
		// 전달정보(파라메터) 저장
		logger.debug(" ( •̀ ω •́ )✧ vo : "+vo);
		
		// DB 객체 생성 - 제품 등록
		// ProdDAO 객체 생성 --> 객체 주입
		// pdao.insertProd(vo);
		
		// ProdService 객체를 주입 -> 해당동작 수행
		pService.insertProd(vo,req);
		logger.debug(" ( •̀ ω •́ )✧ 제품등록 성공 ");
		
	}
	
	
	// 제품 목록 페이지
	// http://localhost:8088/prod/list
	@GetMapping(value = "/list")
	public void listProdGet(Model model) {
		logger.debug(" ( •̀ ω •́ )✧ /prod/list -> listProdGet(Model model) 실행 ");
		// 서비스 -> DAO : 제품목록조회
		List<ProdVO> plistVO = pService.listProd();
		logger.debug(" ( •̀ ω •́ )✧ plistVO : "+plistVO);
		
		model.addAttribute("plistVO",plistVO);
		// 서비스에서 가져온 데이터를 연결된 뷰페이지에 전달해서 출력
	}
	
	
	// 제품 조회
	@PostMapping(value = "/find")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> findProdPost(@RequestBody ProdVO vo) {
	    logger.debug("( •̀ ω •́ )✧ ProdController : findProdPost(@RequestBody ProdVO vo) 실행 ");
	    List<ProdVO> stockListVO = pService.findProdList(vo);
	    ProdVO prodVO = pService.findProd(vo);
	    logger.debug("( •̀ ω •́ )✧ ProdController : prodVO : "+prodVO);
	    Map<String, Object> response = new HashMap<>();
	    response.put("stockListVO", stockListVO);
	    response.put("prodVO", prodVO);
	    
	    return ResponseEntity.ok(response);
	}
	
	
	// 제품 수정
	@PostMapping(value = "/update")
	public String updateProdPost(ProdVO vo, HttpServletRequest req) {
		logger.debug("( •̀ ω •́ )✧ ProdController : updateProdPost(ProdVO vo) 실행 ");
		logger.debug("( •̀ ω •́ )✧ ProdController : vo "+vo);
		pService.updateProd(vo, req);
		return "/prod/list";
	}
	
	
	// 제품 삭제
	@PostMapping(value = "/delete")
	public String deleteProdPost(ProdVO vo, HttpServletRequest req) {
		logger.debug("( •̀ ω •́ )✧ ProdController : deleteProdPost(ProdVO vo, HttpServletRequest req) 실행 ");
		logger.debug("( •̀ ω •́ )✧ ProdController : vo "+vo);
		pService.deleteProd(vo, req);
		return "/prod/list";
	}

	
	// 재고 이동(get)
	// http://localhost:8088/prod/transfer
	@GetMapping(value = "/transfer")
	public void transferProdGet(ProdVO vo, HttpServletRequest req) {
		logger.debug("( •̀ ω •́ )✧ ProdController : transferProdGet(ProdVO vo, HttpServletRequest req) 실행 ");
		
	}
	
	// 재고 이동(post)
	@PostMapping(value = "/transferSelect")
	@ResponseBody
	public ResponseEntity<List<ProdVO>> transferSelectPost() {
	    logger.debug("( •̀ ω •́ )✧ ProdController : transferSelectPost() 실행 ");
	    List<ProdVO> transferListVO = pService.transferSelect();
	    logger.debug("( •̀ ω •́ )✧ ProdController : transferListVO : " + transferListVO);
	    
	    return ResponseEntity.ok(transferListVO);
	}
	
	// 재고 이동(post)
	@PostMapping(value = "/transferSelect2")
	@ResponseBody
	public ResponseEntity<List<ProdVO>> transferSelectPost2(@RequestBody ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ ProdController : transferSelectPost2() 실행 ");
		List<ProdVO> transferList2VO = pService.transferSelect2(vo);
		logger.debug("( •̀ ω •́ )✧ ProdController : transferList2VO : " + transferList2VO);
		
		return ResponseEntity.ok(transferList2VO);
	}
	
	
	
	
}
