package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.ProjectReplyDto;

public interface ProjectReplyDao {

	int sequence();
	void insert(ProjectReplyDto projectReplyDto);
	List<ProjectReplyDto> selectList(int replyOrigin);
	ProjectReplyDto selectOne(int projectReplyNo);
	boolean delete(int projectReplyNo);
	boolean update(ProjectReplyDto projectReplyDto);
}
