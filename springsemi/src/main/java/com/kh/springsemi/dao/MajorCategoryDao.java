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
	List<MajorCategoryDto> selectListByMajorCategoryNo(int majorCategoryNo);
	//선택
	MajorCategoryDto selectOne(int majorCategoryNo);
	
	//이름을 받아서 번호를 선택하는 메소드
	MajorCategoryDto selectOne(String majorCategoryType);
	
	//카테고리가 추가되거나 삭제될 시에 현재 남은 대분류 카테고리를 갱신하여 보여주기
	int updateMajorCategoryCount();
}
