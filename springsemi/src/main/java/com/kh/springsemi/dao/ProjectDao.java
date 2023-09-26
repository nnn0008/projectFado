package com.kh.springsemi.dao;

import java.util.List;


import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.ProjectListDto;
import com.kh.springsemi.vo.PaginationVO;

public interface ProjectDao {
	//CRUD
	//C 프로젝트 등록
	int sequence();
	void insert(ProjectDto projectDto);
	
	//삭제
	boolean delete(int projectNo);
	
	//수정
	boolean update(ProjectDto projectDto);
	boolean updateProjectReadcount(int projectNo);
	boolean plusProjectLikecount(int projectNo);
	boolean minusProjectLikecount(int projectNo);
	
	//상세
	ProjectDto selectOne(int projectNo);
	
	//목록
	List<ProjectListDto> selectList();
	
	//관리자 프로젝트리스트 관리 
	int countList(PaginationVO vo);
	
//	List<ProjectDto> selectListByPage(PaginationVO vo);
	//관리자용 목록
//	List<ProjectListDto> selectListForAdmin();
	
	//검색
	List<ProjectListDto> selectList(String keyword);
	
}
