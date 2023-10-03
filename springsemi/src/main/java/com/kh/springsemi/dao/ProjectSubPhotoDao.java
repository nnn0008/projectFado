package com.kh.springsemi.dao;

import com.kh.springsemi.dto.ProjectSubPhotoDto;

public interface ProjectSubPhotoDao {
	void insert(ProjectSubPhotoDto projectSubPhotoDto);
	boolean delete(int projectNo);
	ProjectSubPhotoDto selectOne(int projectNo);
}
