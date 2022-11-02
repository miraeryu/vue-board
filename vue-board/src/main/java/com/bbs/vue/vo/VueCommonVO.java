package com.bbs.vue.vo;

public class VueCommonVO {
	

	// 검색 기능
	private String category;		// 검색 카테고리
	
	private String keyword;			// 검색 키워드
	
	//페이징
	private int viewPage = 5;		// 1페이지에 보여지는 글 개수
	
	private int allPostCnt;			// 전체 게시글 개수
	
	private int nowPage;			// 현재페이지 - 1
	
	private int displayPage = 3;	//한 화면에 보이는 페이지 개수
	
	//페이징 관련 연산
	
	private int maxPageCnt;			// 전체 페이지 개수
	
	private int startRow;			// 시작행
	
	private int startPage;			// 해당 블럭의 첫번째 페이지
	
	private int endPage;			// 해당 블럭의 마지막 페이지
	
	boolean prev;
	
	boolean next;


	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getViewPage() {
		return viewPage;
	}

	public void setViewPage(int viewPage) {
		this.viewPage = viewPage;
	}

	public int getAllPostCnt() {
		return allPostCnt;
	}

	public void setAllPostCnt(int allPostCnt) {
		this.allPostCnt = allPostCnt;
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getDisplayPage() {
		return displayPage;
	}

	public void setDisplayPage(int displayPage) {
		this.displayPage = displayPage;
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

	public int getMaxPageCnt() {
		maxPageCnt = (int) Math.ceil((double) allPostCnt / (double)viewPage);
		return maxPageCnt;
	}
	
	public int getStartRow() {
		startRow = (nowPage - 1) * 5;
		return startRow;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	

}
