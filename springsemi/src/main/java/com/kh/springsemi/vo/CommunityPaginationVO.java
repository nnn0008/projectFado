package com.kh.springsemi.vo;

import lombok.Data;

@Data
public class CommunityPaginationVO {

		//검색 분류 및 키워드
		private String keyword; //검색 분류 및 키워드
		private int page = 1; //현재 페이지 번호  private in page = 1;  < 이런식으로 페이지 지정이 가능하다 (기본 : 1)
		private int size = 10; //보여줄 게시판의 글 수 (기본 : 10)
		private int count; //전체 글 수 
		private int navigatorSize = 10; //하단 네비게이터 표시 개수(기본 : 10)

		
		public boolean isSearch() {
			return keyword != null;
		}
		public int getBegin() { //첫 시작 번호를 알 수 있는 메소드 생성
			return (page-1)/navigatorSize*navigatorSize+1;
		}
		public int getEnd() { //끝 번호를 알 수 있는 메소드 생성
			int end = getBegin() + navigatorSize - 1;
			return Math.min(getPageCount(), end);
		}
		public boolean isFirst() {
			return getBegin() == 1;
		}
		public int getPageCount() {
			return (count-1) / size +1;
		}
		public boolean isLast() {
			return getEnd() >= getPageCount();
		}
		
		
		public String getPrevQueryString() {
			if(isSearch()) {  //검색이면
				return "page=" + (getBegin()-1) + "&keyword=" + keyword;
			}
			else { //목록이면
				return "page=" + (getBegin()-1);
			}
		}
		public String getNextQueryString() {
			if(isSearch()) {  //검색이면
				return "page=" + (getEnd()+1) + "&size=" + size + "&keyword=" + keyword;
			}
			else { //목록이면
				return "page=" + (getEnd()+1 + "&size=" + size);
			}
		}
		public String getQueryString(int page) {
			if(isSearch()) {  //검색이면
				return "page=" + (page) + "&size=" + size + "&keyword=" + keyword;
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

