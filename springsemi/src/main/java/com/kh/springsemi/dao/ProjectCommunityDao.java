package com.kh.springsemi.dao;


import com.kh.springsemi.dto.ProjectCommunityDto;

public interface ProjectCommunityDao {

	void insert(ProjectCommunityDto projectcommunityDto);
	ProjectCommunityDto selectOne(int projectCommunityNo);
	boolean update(ProjectCommunityDto projectCommunityDto);
	boolean delete(int projectCommunityNo);
	
}
