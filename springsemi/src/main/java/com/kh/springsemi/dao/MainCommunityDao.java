package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.MainCommunityDto;
import com.kh.springsemi.dto.MainCommunityListDto;
import com.kh.springsemi.vo.CommunityPaginationVO;

public interface MainCommunityDao {

	int sequence();  //시퀀스 등록
	void insert(MainCommunityDto mainCommunityDto);  //커뮤니티 등록
	MainCommunityDto selectOne(int mainCommunityNo); //커뮤니티 상세 페이지
	
	
	List<MainCommunityListDto> selectNoticeList(CommunityPaginationVO vo); //커뮤니티 리스트(공지사항)
	List<MainCommunityListDto> selectQnAList(CommunityPaginationVO vo);  //커뮤니티 리스트(qna)
	
	
	boolean update(MainCommunityDto mainCommunityDto); //커뮤니티 수정
	boolean delete(int mainCommunutyNo); //커뮤니티 삭제
	
	
	int countNoticeList(CommunityPaginationVO vo); //notice리스트 카운트 
	int countQnAList(CommunityPaginationVO vo); //qna 리스트 카운트
	
	
	
	
}
