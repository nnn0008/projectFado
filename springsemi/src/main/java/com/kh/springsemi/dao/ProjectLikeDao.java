package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.ProjectLikeDto;

public interface ProjectLikeDao {
	void insert(ProjectLikeDto projectLikeDto);
	boolean delete(ProjectLikeDto projectLikeDto);
	boolean check(ProjectLikeDto projectLikeDto);
	int count(int projectNo);
	List<ProjectDto> findByMemberId(String memberId);
}
