package com.kh.springsemi.dao;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.ProjectListDto;
import com.kh.springsemi.mapper.ProjectListMapper;
import com.kh.springsemi.mapper.ProjectMapper;

@Repository
public class ProjectDaoImpl implements ProjectDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ProjectMapper projectMapper;
	
	@Autowired
	private ProjectListMapper projectListMapper;
	
	@Autowired
	private JudgeDao judgeDao;
	
	//프로젝트 등록(판매자가)
	@Override
	public int sequence() {
		String sql = "select project_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(ProjectDto projectDto) {
		Date endDate = projectDto.getCalculateEndDate();
		projectDto.setProjectEndDate(endDate);
//		int minorNo = minorCategoryDto.getMinorCategoryNo();
//		projectDto.setMinorCategoryNo(minorNo);
		String sql = "insert into project(project_no, project_title, project_goal_price, project_start_date, "
				+ "project_content, project_owner, project_end_date, project_period, minor_category_no) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {projectDto.getProjectNo(), projectDto.getProjectTitle(), projectDto.getProjectGoalPrice(),
				projectDto.getProjectStartDate(),projectDto.getProjectContent(), projectDto.getProjectOwner(), 
				endDate, projectDto.getProjectPeriod(), projectDto.getMinorCategoryNo()};
		 
		jdbcTemplate.update(sql, data);
	}
	
	//프로젝트 삭제(판매자가)
	@Override
	public boolean delete(int projectNo) {
		String sql = "delete project where project_no = ?";
		Object[] data = {projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//프로젝트 수정(관리자, 판매자)
	@Override
	public boolean update(ProjectDto projectDto) {
		String sql = "update project set project_title = ?, project_goal_price = ?, project_start_date = ?, project_end_date = ?, "
				+ "project_content = ? where project_no = ?";
		Object[] data = {projectDto.getProjectTitle(), projectDto.getProjectGoalPrice(), projectDto.getProjectStartDate(), projectDto.getProjectEndDate(),
				projectDto.getProjectContent(), projectDto.getProjectNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//프로젝트 상세(모든 회원, 비회원)
	@Override
	public ProjectDto selectOne(int projectNo) {
		String sql = "select * from project where project_no = ?";
		Object[] data = {projectNo};
		List<ProjectDto> list = jdbcTemplate.query(sql, projectMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	//프로젝트 리스트
	@Override
	public List<ProjectListDto> selectList() {
		String sql = "select * from project_list order by project_no desc";
		return jdbcTemplate.query(sql, projectListMapper);
	}

	@Override
	public boolean updateProjectReadcount(int projectNo) {
		String sql = "update project set project_readcount = project_readcount + 1 where project_no=?";
		Object[] data = {projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}	
	
	@Override
	public boolean plusProjectLikecount(int projectNo) {
		String sql = "update project set project_likecount = project_likecount + 1 where project_no=?";
		Object[] data = {projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public boolean minusProjectLikecount(int projectNo) {
		String sql = "update project set project_likecount = project_likecount - 1 where project_no=?";
		Object[] data = {projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public List<ProjectListDto> selectListForAdmin() {
		String sql = "select * from project order by project_no asc";
		return null;
	}
	
}
