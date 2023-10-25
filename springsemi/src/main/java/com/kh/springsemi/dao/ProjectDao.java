package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.ProjectListAttachDto;
import com.kh.springsemi.dto.ProjectListDto;
import com.kh.springsemi.vo.PaginationListVO;

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
	boolean plusProjectTotalPrice(int ordersPrice, int projectNo);
	
	//상세
	ProjectDto selectOne(int projectNo);
	ProjectListDto selectOneByProjectList(int projectNo);
	
//	//목록
	List<ProjectListDto> selectList();
	List<ProjectListDto> selectListByPage(int page);
	List<ProjectListDto> selectListByPage(String keyword, int page);
	
	//사진이 포함된 목록
//	List<ProjectListAttachDto> selectList();
	List<ProjectListAttachDto> selectListByPageByAttach(int page);
	List<ProjectListAttachDto> selectListByPageByAttach(String keyword, int page);
	
//	List<ProjectListDto> selectList();
//	List<ProjectListDto> selectListByPage(int page);
//	List<ProjectListDto> selectListByPage(String keyword, int page);
	
	List<ProjectListAttachDto> selectList(String keyword);
	//심사를 통과한 프로젝트 개수
	int countListJudgePass();
	int countListJudgePass(String keyword);
	int countListJudgePass(PaginationListVO vo);
	
	//개수를 구하는 명령 - 관리자가 사용하는
	int countList(); //목록일 때 
	int countList(String keyword); //검색일 때
	int countList(PaginationListVO vo);
	//검색
	
	//프로젝트 사진 관련 기능
	void insertPhoto(int projectNo, int attachNo);
	boolean deletePhoto(int projectNo);
	Integer findPhoto(int projectNo);
	
	//프로젝트 메인화면에 보여주는 기능(좋아요, 카테고리, 조회순)
//	List<ProjectListAttachDto> selectListByLikeCount(int page);
//	List<ProjectListAttachDto> selectListByLikeCount(String keyword, int page);
	List<ProjectListAttachDto> selectListByLikeCount(PaginationListVO vo);
	List<ProjectListAttachDto> selectListByReadCount(PaginationListVO vo);
	List<ProjectListAttachDto> selectListByAchievementRate(PaginationListVO vo);
	List<ProjectListDto> selectListByMajorCategory(String majorCategory);
	List<ProjectListAttachDto> selectList(PaginationListVO vo);
	
	//프로젝트 기간이 끝났을 때, 펀딩 성공 / 실패를 보여주기
	boolean fundingSuccess();
	boolean fundingFail();
	
}
