package com.kh.springsemi.dao;

import com.kh.springsemi.dto.ProjectDto;

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
	
	//상세
	ProjectDto selectOne(int projectNo);
}
