package com.itwillbs.web;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.scribejava.core.model.Response;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.oned.Code128Writer;
import com.google.zxing.qrcode.QRCodeWriter;
import com.itwillbs.domain.ProdVO;
import com.itwillbs.persistence.ProdDAO;
import com.itwillbs.service.ProdService;


@Controller
@RequestMapping(value = "/prod/*")
public class ProdController {
	
	private ProdService pService;
	
	public ProdController(ProdService pService) {
		this.pService = pService;
	}
	private static final Logger logger = LoggerFactory.getLogger(ProdController.class);
	
	
	// 제품등록 - 정보입력 페이지
	// http://localhost:8088/prod/insert
	@RequestMapping(value = "/insert",method = RequestMethod.GET)
	public void insertProdGet(Model model) {
		logger.debug(" ( •̀ ω •́ )✧ /prod/insert -> insertProdGet() 실행 ");
		List<ProdVO> companyList = pService.insertList();
		model.addAttribute("companyList", companyList);
		logger.debug(" ( •̀ ω •́ )✧ /views/prod/insert.jsp 뷰페이지 연결 ");
	}
	
	// 제품등록 - 정보처리
	@RequestMapping(value = "/insert",method = RequestMethod.POST)
	public void insertProdPost(ProdVO vo, HttpServletRequest req) {
		logger.debug(" ( •̀ ω •́ )✧ /prod/insert -> insertProdPost() 실행 ");
		logger.debug(" ( •̀ ω •́ )✧ vo : "+vo);
		
		pService.insertProd(vo,req);
		logger.debug(" ( •̀ ω •́ )✧ 제품등록 성공 ");
		
	}
	
	
	// 제품 목록 페이지
	// http://localhost:8088/prod/list
	@GetMapping(value = "/list")
	public void listProdGet(Model model) {
		logger.debug(" ( •̀ ω •́ )✧ /prod/list -> listProdGet(Model model) 실행 ");
		List<ProdVO> plistVO = pService.listProd();
		logger.debug(" ( •̀ ω •́ )✧ plistVO : "+plistVO.size());
		
		model.addAttribute("plistVO",plistVO);
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
	
	// 제품 바코드
    @PostMapping("/genCode")
    public void generateCode(@RequestParam String prod_id, @RequestParam String option, 
    		@RequestParam String imgUrl, HttpServletResponse res) throws IOException, WriterException {
        
    	BufferedImage image = null;

        if ("barcode".equals(option)) {
            Code128Writer barcodeWriter = new Code128Writer();
            BitMatrix bitMatrix = barcodeWriter.encode(prod_id, BarcodeFormat.CODE_128, 300, 100);
            image = MatrixToImageWriter.toBufferedImage(bitMatrix);
        } else if ("qrcode".equals(option)) {
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(imgUrl, BarcodeFormat.QR_CODE, 300, 300);
            image = MatrixToImageWriter.toBufferedImage(bitMatrix);
        }

        res.setContentType("image/png");
        ImageIO.write(image, "PNG", res.getOutputStream());
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
	public String deleteProdPost(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ ProdController : deleteProdPost(ProdVO vo, HttpServletRequest req) 실행 ");
		logger.debug("( •̀ ω •́ )✧ ProdController : vo "+vo);
		pService.deleteProd(vo);
		return "/prod/list";
	}

	
	// 재고 이동 신청(get)
	// http://localhost:8088/prod/transfer
	@GetMapping(value = "/transfer")
	public void transferProdGet() {
		logger.debug("( •̀ ω •́ )✧ ProdController : transferProdGet() 실행 ");
	}
	
	// 재고 이동 신청(post)
	@PostMapping(value = "/transfer")
	@ResponseBody
	public ResponseEntity<Map<String, String>> transferProdPost(ProdVO vo, HttpServletRequest req) {
		logger.debug("( •̀ ω •́ )✧ ProdController : transferProdPost(ProdVO vo, HttpServletRequest req) 실행 ");
		vo.setProd_reguser((String) req.getSession().getAttribute("id"));
		int result = pService.transferProd(vo);

		Map<String, String> response = new HashMap<>();
		if (result > 0) {
			response.put("status", "success");
			response.put("message", "제품 이동 신청되었습니다.");
			return ResponseEntity.ok(response);
		} else {
			response.put("status", "error");
			response.put("message", "제품 이동 신청이 실패했습니다!");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}
	
	// 재고 이동 선택(post)
	@PostMapping(value = "/transferSelect")
	@ResponseBody
	public ResponseEntity<List<ProdVO>> transferSelectPost() {
	    logger.debug("( •̀ ω •́ )✧ ProdController : transferSelectPost() 실행 ");
	    List<ProdVO> transferListVO = pService.transferSelect();
	    logger.debug("( •̀ ω •́ )✧ ProdController : transferListVO : " + transferListVO.size());
	    
	    return ResponseEntity.ok(transferListVO);
	}
	
	// 재고 이동 제품 창고 정보(post)
	@PostMapping(value = "/transferFind")
	@ResponseBody
	public ResponseEntity<List<ProdVO>>transferFindPost(@RequestBody ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ ProdController : transferListPost() 실행");
		List<ProdVO> transferFindList = pService.findProdList(vo);
		
		return ResponseEntity.ok(transferFindList);
	}
	
	// 재고 이동 선택2(post)
	@PostMapping(value = "/transferSelect2")
	@ResponseBody
	public ResponseEntity<List<ProdVO>> transferSelectPost2(@RequestBody ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ ProdController : transferSelectPost2() 실행 ");
		List<ProdVO> transferList2VO = pService.transferSelect2(vo);
		logger.debug("( •̀ ω •́ )✧ ProdController : transferList2VO : " + transferList2VO.size());
		
		return ResponseEntity.ok(transferList2VO);
	}
	
	// 재고 이동 선택3(post)
	@PostMapping(value = "/transferSelect3")
	@ResponseBody
	public ResponseEntity<List<ProdVO>> transferSelectPost3() {
		logger.debug("( •̀ ω •́ )✧ ProdController : transferSelectPost3() 실행 ");
	    List<ProdVO> transferList3VO = pService.transferSelect3();
	    logger.debug("( •̀ ω •́ )✧ ProdController : transferList3VO : " + transferList3VO);

	    return ResponseEntity.ok(transferList3VO);
	}
	
	
	// 재고이동이력(get)
	@GetMapping(value = "/movestock")
	public void movestockGet(ProdVO vo, Model model) {
		logger.debug("( •̀ ω •́ )✧ ProdController : movestockGet(ProdVO vo, RedirectAttributes rttr) 실행");
		List<ProdVO> moveList = pService.moveStockList(vo);
		
		model.addAttribute("moveList", moveList);
	}
	
	// 재고이동이력승인(post)
	@PostMapping("/movestock")
	public ResponseEntity<String> movestockPost(@RequestBody List<ProdVO> moveList) {
		logger.debug("( •̀ ω •́ )✧ ProdController : movestockPost(@RequestBody List<ProdVO> moveList) 실행 ");
		logger.debug("( •̀ ω •́ )✧ moveList : "+moveList.size());
		int result = pService.moveStock(moveList);
		
		if(result>0) {
			return ResponseEntity.ok("재고 이동이 승인되었습니다.");
		}
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("재고 이동 승인에 실패하였습니다.");
	}
	
	// 재고이동이력취소(post)
	@PostMapping("/movestockcancel")
	public ResponseEntity<String> movestockcancelPost(@RequestBody List<ProdVO> moveList) {
		logger.debug("( •̀ ω •́ )✧ ProdController : movestockcancelPost(@RequestBody List<ProdVO> moveList) 실행 ");
		logger.debug("( •̀ ω •́ )✧ moveList : "+moveList.size());
		int result = pService.moveStockCancel(moveList);
		
		if(result>0) {
			return ResponseEntity.ok("재고 이동이 취소되었습니다.");
		}
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("재고 이동 취소에 실패하였습니다.");
	}
	
	// 재고이동알람
	@PostMapping(value = "/movestockalert")
	@ResponseBody
	public ResponseEntity<List<ProdVO>> moveStockAlertPost() {
		logger.debug("( •̀ ω •́ )✧ ProdController : moveStockAlertPost() 실행 ");
		List<ProdVO> moveStockAlertList = pService.moveStockAlert();
		return ResponseEntity.ok(moveStockAlertList);
	}
	
	
	// 재고 알람 설정(GET)
	// http://localhost:8088/prod/stockalert
	@GetMapping(value = "/stockalert")
	public void stockalertGet(Model model) {
		logger.debug("( •̀ ω •́ )✧ ProdController : stockalertGet() 실행 ");
		List<ProdVO> stockList = pService.setStockList();
		logger.debug(" ( •̀ ω •́ )✧ stockList : "+stockList.size());
		model.addAttribute("stockList",stockList);
	}

	// 재고 알람 리스트(POST)
	@PostMapping(value = "/stockalertdata")
	@ResponseBody
	public ResponseEntity<List<ProdVO>> stockalertPost() {
		logger.debug("( •̀ ω •́ )✧ ProdController : stockalertPost() 실행 ");
		List<ProdVO> stockList = pService.setStockList();
		logger.debug(" ( •̀ ω •́ )✧ stockList : "+stockList.size());
		return ResponseEntity.ok(stockList);
	}

	// 재고 알람 설정(POST)
	@PostMapping(value = "/stockalert")
	public String stockalertPost(ProdVO vo, RedirectAttributes rttr) {
		logger.debug("( •̀ ω •́ )✧ ProdController : stockalertPost() 실행 ");
		
		int result = pService.setStock(vo);
		if(result > 0) {
			rttr.addFlashAttribute("trans_message", "적정재고수량 알람이 설정되었습니다");
		} else {
			rttr.addFlashAttribute("trans_error", "적정재고수량 알람 설정에 실패했습니다");
		}
		return "redirect:/prod/stockalert";
	}
	
	
	
	
	
	
	
}
