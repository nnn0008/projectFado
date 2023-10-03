package com.kh.springsemi.dao;

import java.util.List;


import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.ProjectListDto;
import com.kh.springsemi.vo.PaginationVO;

public interface ProjectDao {
	//CRUD
	//프로젝트 등록
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
	List<ProjectListDto> selectListByPage(int page);
	List<ProjectListDto> selectListByPage(String keyword, int page);
	
	//개수를 구하는 명령
	int countList(); //목록일 때
	int countList(String keyword); //검색일 때
	
	//검색
	List<ProjectListDto> selectList(String keyword);
	
	//프로젝트 사진 관련 기능
	void insertPhoto(int projectNo, int attachNo);
	boolean deletePhoto(int projectNo);
	Integer findPhoto(int projectNo);
}
