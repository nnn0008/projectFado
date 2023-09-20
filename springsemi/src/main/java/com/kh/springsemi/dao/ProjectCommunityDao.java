package com.kh.springsemi.dao;


import java.util.List;

import com.kh.springsemi.dto.ProjectCommunityDto;
import com.kh.springsemi.vo.PaginationVO;

public interface ProjectCommunityDao {

	int sequence(); //시퀀스 등록
	void insert(ProjectCommunityDto projectcommunityDto);  //커뮤니티 등록
	ProjectCommunityDto selectOne(int projectCommunityNo);  //커뮤니티 상세 페이지
	List<ProjectCommunityDto> selectList(PaginationVO vo);  //커뮤니티 리스트(목록 및 검색 페이지) 
	boolean update(ProjectCommunityDto projectCommunityDto);  //커뮤니티 수정
	boolean delete(int projectCommunityNo);  //커뮤니티 삭제
	
}
