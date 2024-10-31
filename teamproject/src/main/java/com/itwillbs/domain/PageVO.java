package com.itwillbs.domain;

/**
 * 페이징처리 1) 게시판의 글을 원하는 만큼 가져오기
 * 			  2) 페이지 하단에 페이징블럭
 * 			  3) 본문,수정,삭제 동작후 다시 원래 페이지로 이동
 * 
 *  페이징 처리 정보를 계산하는 객체 (1,2단계)
 *  
 *  - 시작페이지 번호 startPage
 *  - 끝페이지 번호	endPage
 *  - 전체 게시판 데이터 개수 totalCount
 *  - 이전페이지 prev
 *  - 다음페이지 next
 *  
 *  ex) 한번에 10개씩 출력, 총 글의 개수 122개 / 페이지블럭 개수 10개씩
 *  
 *  
 *   *page=3일때, startPage 1, endPage 10, next t, prev f
 *   *page=10일때, startPage 1, endPage 10, next t, prev f
 *   *page=12일때, startPage 11, endPage 20->13, next f, prev t
 *  
 *
 */
public class PageVO {
	
	private int startPage;				// 페이지블럭 시작번호
	private int endPage;				// 페이지블럭 끝번호
	private int totalCount;				// 총 글의 개수
	
	private boolean prev;				// 이전 버튼 사용여부
	private boolean next;				// 다음 버튼 사용여부
	
	private int pageBlock = 5;			// 페이지 블럭의 크기 1...10 11...20
	
//	private int page;					// 페이지 번호
//	private int pageSize;				// 페이지 출력개수
	private Criteria cri;
	
	
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		// 페이징처리에 필요한 정보를 계산
		calcData();
	} 
	
	private void calcData() {
		System.out.println("---------- 페이징 처리 정보 계산 ----------------");

		//endPage계산 = (int)올림(페이지번호 / 페이지블럭) * 페이지블럭
		endPage =  (int)(Math.ceil(cri.getPage() / (double)pageBlock) * pageBlock);
		
		//startPage계산 = endpage - 페이지블럭 + 1
		startPage = (endPage - pageBlock) + 1;
		
		//endPage 재계산(페이지 개수가 다른 경우)
		// 게시판 글개수에 따른 필요한 페이지수를 계산
		//int tmpEndPage =  totalCount/cri.getPageSize() +(totalCount%cri.getPageSize()==0? 0:1);
		int tmpEndPage =  (int)Math.ceil( (double)totalCount/cri.getPageSize() );
		
		if(tmpEndPage < endPage) { // 게시판 페이지수가 모자란경우 endPage 변경
			endPage = tmpEndPage;
		}
		
		
		// prev : 이전버튼   시작페이지번호 > 페이지블럭  true 
		//                   시작 페이지번호가 1인지 체크
		//prev = startPage == 1? false:true;
		prev = startPage != 1;
		
		// next : 다음버튼  끝페이지번호 * 페이지사이즈 >= totalCount
		//next = (endPage *  cri.getPageSize()) >= totalCount? false : true;
		next = (endPage *  cri.getPageSize()) < totalCount;
		
		
		System.out.println("---------- 페이징 처리 정보 계산 ----------------");
	}	
	
	public Criteria getCri() {
		return cri;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	
	// alt shift s + s
	@Override
	public String toString() {
		return "PageVO [startPage=" + startPage + ", endPage=" + endPage + ", totalCount=" + totalCount + ", prev="
				+ prev + ", next=" + next + ", pageBlock=" + pageBlock + ", cri=" + cri + "]";
	}
	

}
