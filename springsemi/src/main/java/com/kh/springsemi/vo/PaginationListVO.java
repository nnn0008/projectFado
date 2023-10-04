package com.kh.springsemi.vo;

import lombok.Data;

@Data
public class PaginationListVO {
	//검색
	private String keyword; //검색단어
	private int page = 1; //현재 페이지 번호
	private int size = 8; //보여줄 게시판 글의 수
	private int count; //전체 글 수
	private int navigatorSize = 10; //하단의 네비게이터 표시 개수
	
	public boolean isSearch() {
		return keyword != null;
	}
	public int getBegin() {
		return (page-1) / navigatorSize * navigatorSize + 1;
	}
	public int getEnd() {
		int end = getBegin() + navigatorSize - 1;
		return Math.min(getPageCount(), end);
	}
	public boolean isFirst() {
		return getBegin() == 1;
	}
	public boolean isLast() {
		return getEnd() >= getPageCount();
	}
	public int getPageCount() {
		return (count - 1) / size + 1;
	}
	public String getPrevQueryString() {
		if(isSearch()) {
			return "page=" + (getBegin() - 1) + "&keyword=" + keyword;
		}
		else {
			return "page=" + (getBegin() - 1);
		}
	}
	public String getNextQueryString() {
		if(isSearch()) {
			return "page=" + (getEnd() + 1) + "&size=" + size + "&keyword=" + keyword;
		}
		else {
			return "page=" + (getEnd() + 1 + "&size=" + size);
		}
	}
	public String getQueryString(int page) {
		if(isSearch()) {
			return "page=" + page + "&size=" + size + "&keyword=" + keyword;
		}
		else {
			return "page=" + page;
		}
	}
	public int getStartRow() {
		return getFinishRow() - (size - 1);
	}
	public int getFinishRow() {
		return page * size;
	}
	
}
