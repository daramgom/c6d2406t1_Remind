package com.itwillbs.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.inject.Inject;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.domain.ProdVO;
import com.itwillbs.persistence.ProdDAO;


// @Service : 서비스 영역(비지니스 로직 영역) 에서의 동작을 구현하도록 설정
//			  root-context.xml에 빈(MemberService)으로 등록 사용.

/**
* 
* 비즈니스 영역, Action페이지, ~pro.jsp 동작을 처리하는 공간.
* => 컨트롤러와 DAO를 연결다리(접착제) / 완충영역
* => 고객사마다 유연한 대처가 가능.
*/

@Service
public class ProdServiceImpl implements ProdService {
	
	// ProdDAO 객체 주입
	@Inject
	private ProdDAO pdao;
	
	// private String uploadDir = "C:\\Users\\ITWILL\\git\\Team1\\teamproject\\src\\main\\webapp\\uploads"; // 업로드 경로
	private static final Logger logger = LoggerFactory.getLogger(ProdServiceImpl.class);
	
	
	// 제품등록
	@Override
	@Transactional
	public void insertProd(ProdVO vo, HttpServletRequest req) {
		
		imageUpload(vo, req); // 이미지 업로드
		genProdID(vo); // 제품식별코드 생성
		
		logger.debug("( •̀ ω •́ )✧ 컨트롤러 - 서비스 - DAO");
		pdao.insertProd(vo);
		logger.debug("( •̀ ω •́ )✧ DAO - 서비스 - 컨트롤러");
	}
	

	// 제품목록
	@Override
	public List<ProdVO> listProd() {
		logger.debug(" ( •̀ ω •́ )✧ Service : listProd() 실행 ");
		return pdao.listProd();
	}


	// 제품조회
	@Override
	public ProdVO findProd(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ Service : findProd(ProdVO vo) 실행 ");
		return pdao.findProd(vo);
	}
	
	@Override
	public List<ProdVO> findProdList(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ Service : findProdList(ProdVO vo) 실행 ");
		return pdao.findProdList(vo);
	}


	// 제품수정
	@Override
	@Transactional
	public void updateProd(ProdVO vo, HttpServletRequest req) {
		logger.debug("( •̀ ω •́ )✧ Service : updateProd(ProdVO vo) 실행 ");
		imageUpload(vo, req);
		pdao.updateProd(vo);
		logger.debug("( •̀ ω •́ )✧ Service : vo : "+vo);
	}
	
	
	// 제품삭제
	@Override
	public void deleteProd(ProdVO vo, HttpServletRequest req) {
		logger.debug("( •̀ ω •́ )✧ Service : deleteProd(ProdVO vo, HttpServletRequest req) 실행 ");
		pdao.deleteProd(vo);
	}
	
	
	// 재고이동
	@Override
	public List<ProdVO> transferSelect() {
		logger.debug("( •̀ ω •́ )✧ Service : transferSelect() 실행 ");
		return pdao.transferSelect();
	}

	// 재고이동
	@Override
	public List<ProdVO> transferSelect2(ProdVO vo) {
		logger.debug("( •̀ ω •́ )✧ Service : transferSelect2() 실행 ");
		return pdao.transferSelect2(vo);
	}
	
	
	
	
	
	
	
	// ***** 메서드 목록 *****
	


	// 제품식별코드 생성
	public void genProdID(ProdVO vo) {
	    String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	    StringBuilder codeSb = new StringBuilder();
	    Random random = new Random();
	    codeSb.append("P").append("-");
	    
	    for (int i = 0; i < 6; i++) {
	        int index = random.nextInt(characters.length());
	        codeSb.append(characters.charAt(index));
	    }
		
		codeSb.append("-").append(vo.getCompany_code());
        vo.setProd_id(codeSb.toString());
		codeSb.setLength(0);
	    
	 }
	// 제품식별코드 생성
	
	
	// 이미지 업로드
	// 이미지 업로드 처리후 파일 경로를 prod_image에 전달하려고 함
	public void imageUpload(ProdVO vo, HttpServletRequest req) {
	
		String uploadDir = req.getRealPath("/uploads");
		logger.debug("( •̀ ω •́ )✧ uploadDir : "+uploadDir);
		StringBuilder prodSb = new StringBuilder(); // 연결연산자 대신 문자열 연결하기 위해서 사용
		
		File dir = new File(uploadDir); // 업로드 디렉토리 객체 생성
		if(!dir.exists()) { // 디렉토리가 존재하지 않으면 생성하는 조건문
		    if (!dir.mkdirs()) { // 생성 성공하면 !true --> false로 if문 실행 X / 생성 실패하면 !false --> true로 if문 실행 O
		        logger.debug("디렉토리 생성 실패: " + uploadDir);
		    }
		}
		
		MultipartFile file = vo.getUploadfile(); // VO객체로 전달받은 MultipartFile 변수 전달
		if(!file.isEmpty()) {
			logger.debug("( •̀ ω •́ )✧ imageUpload(ProdVO vo, HttpServletRequest req) 실행 : 이미지가 변경됨 ");
			
			if(!vo.getProd_image().isEmpty()) {
				try { // 이미지 수정시 파일삭제
		            // VO에서 파일 경로 가져오기
		            String curFilePath = vo.getProd_image().replaceFirst("/uploads", "");
		            
		            // 상대 경로와 현재 작업 디렉토리를 결합하여 절대 경로 생성
		            Path path = Paths.get(uploadDir, curFilePath);
		            logger.debug("( •̀ ω •́ )✧ 절대경로 생성 path : "+path);
		            
		            // 파일 삭제
		            Files.delete(path);
		            logger.debug("( •̀ ω •́ )✧ 파일 삭제 성공");
		        } catch (NoSuchFileException e) {
		        	logger.debug("( •̀ ω •́ )✧ 파일이 없습니다");
		        } catch (IOException e) {
		        	logger.debug("( •̀ ω •́ )✧ 파일 삭제중 오류발생");
		        }
			}
			
			String orgFileName = file.getOriginalFilename();
			if(orgFileName.contains(".")) {
				// String fileExt = orgFileName.substring(orgFileName.lastIndexOf(".") + 1);
				// 파일 확장자를 얻기 위해 String 메서드 사용 --> 파일 이름 가져올 때 중복이 되어서 우선 제외
				
				UUID uuid = UUID.randomUUID(); // 파일 이름 저장시 중복방지를 위해 고유한 식별자 생성
				prodSb.append(dir).append(File.separator)// File.separator 파일 구분자(\) 반환
				.append(uuid.toString()).append("_").append(orgFileName);
				// File desFile = new File(dir, uuid.toString() + "_" + orgFileName); // 파일 저장 경로 생성
				File desFile = new File(prodSb.toString()); // 파일 저장 경로 생성
				prodSb.setLength(0); // 데이터 비우기 처리
				
				prodSb.append("/uploads/").append(uuid.toString())
				.append("_").append(orgFileName);// 업로드한 파일의 URL 경로 설정
				// String imageUrl = "/uploads/" + uuid.toString() + "_" + orgFileName; // 웹에서 접근할 수 있는 경로
				vo.setProd_image(prodSb.toString()); // VO에 경로 저장
				prodSb.setLength(0); // 데이터 비우기 처리
				
				try {
					file.transferTo(desFile);// 파일복사 메서드
				} catch (IllegalStateException e) {
					e.printStackTrace();
					logger.debug("파일 저장 실패1");
				} catch (IOException e) {
					e.printStackTrace();
					logger.debug("파일 저장 실패2");
				}
			}
		} else {
			logger.debug("( •̀ ω •́ )✧ imageUpload(ProdVO vo, HttpServletRequest req) 실행 : 이미지가 변경되지 않음 ");
			if(vo.getProd_image().isEmpty()) {
				try { // 이미지 수정시 파일삭제
		            // VO에서 파일 경로 가져오기
		            String curFilePath = vo.getTemp_image().replaceFirst("/uploads", "");
		            logger.debug("( •̀ ω •́ )✧ 절대경로 생성 curFilePath : "+curFilePath);
		            // 상대 경로와 현재 작업 디렉토리를 결합하여 절대 경로 생성
		            Path path = Paths.get(uploadDir, curFilePath);
		            logger.debug("( •̀ ω •́ )✧ 절대경로 생성 path : "+path);
		            
		            // 파일 삭제
		            Files.delete(path);
		            logger.debug("( •̀ ω •́ )✧ 파일 삭제 성공");
		        } catch (NoSuchFileException e) {
		        	logger.debug("( •̀ ω •́ )✧ 파일이 없습니다");
		        } catch (IOException e) {
		        	logger.debug("( •̀ ω •́ )✧ 파일 삭제중 오류발생");
		        }
			}
		}
	}
	// 이미지 업로드
	
	
	
	
	
	
	
	// ***** 메서드 목록 *****
	
	
	

}
