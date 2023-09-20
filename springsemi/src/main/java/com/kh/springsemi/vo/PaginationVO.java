package com.kh.springsemi.vo;

import lombok.Data;

@Data
public class PaginationVO {

	private String type, keyword;
	private int page = 1;
	private int size = 10;
	private int count;
	private int navigatorSize = 10;
	
	
	public boolean isSearch() {
		return type != null && keyword !=null;
	}
	
	
	public int getBegin() {
		return (page-1)/navigatorSize*navigatorSize+1;
	}
	
	
	public int getEnd() {
		int end = getBegin() + navigatorSize - 1;
		return Math.min(getPageCount(), end);
	}
	
	
	public boolean isFirst() {
		return getBegin() == 1;
	}
	
	
	public String getPrevQueryString() {
		if(isSearch()) {
			return "page=" + (getBegin()-1) + "&type=" + type + "&keyword=" + keyword;
		}
		else {
			return "page=" + (getBegin()-1);
		}
	}
	
	
	public int getPageCount() {
		return (count-1) / size + 1;
	}
	
	
	public boolean isLast() {
		return getEnd() > getPageCount();
	}
	
	
	public String getNextQueryString() {
		if(isSearch()) {
			return "page=" + (getEnd()+1) + "&size=" + size + "&type=" + "&keyword=" + keyword;
		}
		else {
			return "page=" + (getEnd()+1 + "&size=" + size);
		}
	}
	
	
	public String getQueryString(int page) {
		if(isSearch()) {  //검색이면
			return "page=" + (page) + "&size=" + size +  "&=type" + type + "&keyword=" + keyword;
		}
		else { //목록이면
			return "page=" + page;
		}
	}
	
	public int getStartRow() {
		return getFinishRow() - (size-1);
	}
	public int getFinishRow() {
		return page * size;
	}
	
	
}
