package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.ProjectPhotoDto;

public interface ProjectPhotoDao {
	void insert(ProjectPhotoDto projectPhotoDto);
	boolean delete(int projectNo);
	ProjectPhotoDto selectOne(int projectNo);
	List<ProjectPhotoDto> selectList();
}
