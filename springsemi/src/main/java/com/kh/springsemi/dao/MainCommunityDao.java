package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.MainCommunityDto;
import com.kh.springsemi.dto.MainCommunityListDto;
import com.kh.springsemi.vo.PaginationVO;

public interface MainCommunityDao {

	int sequence();  //시퀀스 등록
	void insert(MainCommunityDto mainCommunityDto);  //커뮤니티 등록
	MainCommunityDto selectOne(int mainCommunityNo); //커뮤니티 상세 페이지
	List<MainCommunityListDto> selectList(PaginationVO vo); //커뮤니티 리스트(목록 및 검색 페이지)
	boolean update(MainCommunityDto mainCommunityDto); //커뮤니티 수정
	boolean delete(int mainCommunutyNo); //커뮤니티 삭제
	
	
	int countList(PaginationVO vo); //리스트 구현을 위한 
}
