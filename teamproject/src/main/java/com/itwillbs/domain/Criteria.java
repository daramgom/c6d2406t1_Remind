package com.itwillbs.domain;
/*
 *  페이징 처리위해 생성한 객체
 */

public class Criteria {

	private int page;		// 페이지정보
	private int pageSize;	// 페이지크기
	
	private int totalCount;   // 총 회원 수
	
	// private int startPage // 디비에서 limit 조회시 사용되는 변수
	
	public Criteria() { // 기본값 1페이지에 10개씩 출력
		this.page = 1;
		this.pageSize = 10;
	}
	
	// getter/setter
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	public void setPageSize(int pageSize) {
		
		if(pageSize <= 0 || pageSize > 100) {
			this.pageSize = 10;
		}
		this.pageSize = pageSize;
	}
	
	// mapper에서 #{0000} 사용할 때 전달되는 객체의 get0000 메서드 호출
	public int getStartPage() {
		// 페이지 정보를 받아서 limit 실행에 필요한 인덱스로 변환
		// 1-0 / 2-10 / 3-20 / 4-30 ...
		// 페이지에 따른 시작 위치(인덱스 계산)
		// this.page = (this.page - 1) * this.pageSize;
		// return this.page -->
		/*
		오류발생 이유: mapper PreparedStatement 객체 쿼리 실행1 #{startPage} getStartPage 실행1 --> page : 0이 됨 
		pstmt setint(getStartPage()) 실행2 --> page : -10이 됨
		sql 쿼리(limit)에 page : -10 값을 적용하니 오류 발생 limit -10,10
		*/
		return (this.page - 1) * this.pageSize;
	}
	public int getPage() { // -> 페이지 번호를 리턴
		return page;
	}
	public int getPageSize() {
		return pageSize;
	}
	@Override
	public String toString() {
		return super.toString();
	}
	 // 총 회원 수의 세터와 게터
    public int getTotalCount() {
        return totalCount;
    }
	
	  public void setTotalCount(int totalCount) {
	        this.totalCount = totalCount;
	    }
	
}