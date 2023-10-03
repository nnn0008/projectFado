package com.kh.springsemi.dao;


import java.util.List;

import com.kh.springsemi.dto.ProjectCommunityDto;
import com.kh.springsemi.vo.CommunityPaginationVO;
import com.kh.springsemi.vo.PaginationVO;

public interface ProjectCommunityDao {

	int sequence(); //시퀀스 등록
	void insert(ProjectCommunityDto projectcommunityDto);  //커뮤니티 등록
	ProjectCommunityDto selectOne(int projectCommunityNo);  //커뮤니티 상세 페이지
	
	
//	List<ProjectCommunityDto> selectNoticeList(CommunityPaginationVO vo);  //커뮤니티 리스트(목록 및 검색 페이지) 
//	List<ProjectCommunityDto> selectQnAList(CommunityPaginationVO vo);
	
	
	List<ProjectCommunityDto> selectNoticeList(int projectNo);  //커뮤니티 리스트(목록 및 검색 페이지) 
	List<ProjectCommunityDto> selectQnAList(int projectNo);
	
	boolean update(ProjectCommunityDto projectCommunityDto);  //커뮤니티 수정
	boolean delete(int projectCommunityNo);  //커뮤니티 삭제
	
	
	
//	int countNoticeList(CommunityPaginationVO vo); //notice리스트 카운트
//	int countQnAList(CommunityPaginationVO vo); //qna 리스트 카운트
}
