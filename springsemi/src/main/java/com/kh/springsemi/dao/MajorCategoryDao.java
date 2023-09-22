package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.MajorCategoryDto;

public interface MajorCategoryDao {
	//등록
	int sequence();
	void insert(MajorCategoryDto majorCategoryDto);
	
	//삭제	
	boolean delete(int majorCategoryNo);
	
	//수정
	boolean update(MajorCategoryDto majorCategoryDto);
	
	//목록
	List<MajorCategoryDto> selectList();
	
	//선택
	MajorCategoryDto selectOne(int majorCategoryNo);
}
