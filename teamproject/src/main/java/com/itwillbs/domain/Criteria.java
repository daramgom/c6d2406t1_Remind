package com.itwillbs.domain;

/**
 *  페이징 처리위해 생성한 객체
 */
public class Criteria {
	
	private int page;			//페이지번호
	private int pageSize;		//페이지크기
	
	private String keyword;
	
	public Criteria() { 		// 기본값 1페이지에 10개씩 출력
		this.page = 1;
		this.pageSize = 10;
	}
	
	// get/set
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return;
		}
		
		this.page = page;
	}
	
	public void setPageSize(int pageSize) {
		
		if(pageSize <= 0 || pageSize >= 100) {
			this.pageSize = 10;
			return;
		}
		
		this.pageSize = pageSize;
	}
	
	// mapper에서 #{ㅇㅇㅇㅇ} 사용할때 전달되는 객체의 getㅇㅇㅇㅇ 메서드 호출
	public int getStartPage() {
		// 페이지 정보를 받아서 limit 실행에 필요한 인덱스로 변환
		// 1-0 / 2-10 / 3-20 / 4-30 ....
		// 페이지에 따른 시작 위치(인덱스)계산
		
//		page = (page - 1) * pageSize;
//		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//		System.out.println(page);
//		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//		return page;
		return (page - 1) * pageSize;
	}
	
	public int getPage() { // => 페이지번호를 리턴 
		return page;
	}
	public int getPageSize() {
		return pageSize;
	}
	
	
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", pageSize=" + pageSize + "]";
	}
	
	public String getKeyword() {
		return keyword;
	}
	
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	

}
