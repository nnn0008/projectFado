package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.JudgeDto;
import com.kh.springsemi.dto.ProjectDto;

public interface JudgeDao {
	//등록
	int sequence();
	void insert(JudgeDto judgeDto);
	
	//수정
	boolean update(JudgeDto judgeDto);
	boolean updateByProjectNo(JudgeDto judgeDto);
	
	//삭제
	boolean delete(int judgeNo);
	
	//목록
	List<JudgeDto> selectList();
	
	//상세
	JudgeDto selectOne(int judgeNo);
	JudgeDto selectOneByProjectNo(int projectNo);
}
