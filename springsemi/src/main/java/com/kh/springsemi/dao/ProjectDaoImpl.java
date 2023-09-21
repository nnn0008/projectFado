package com.kh.springsemi.dao;

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
	
	//프로젝트 등록(판매자가)
	@Override
	public int sequence() {
		String sql = "select project_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	@Override
	public void insert(ProjectDto projectDto) {
		String sql = "insert into project(project_no, project_title, project_goal_price, project_start_date, "
				+ "project_end_date, project_category, project_content, project_owner) values(?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {projectDto.getProjectNo(), projectDto.getProjectTitle(), projectDto.getProjectGoalPrice(),
				projectDto.getProjectStartDate(), projectDto.getProjectEndDate(),
				projectDto.getProjectCategory(), projectDto.getProjectContent(), projectDto.getProjectOwner()};
		
		jdbcTemplate.update(sql, data);
	}
	//프로젝트 삭제(판매자가)
	@Override
	public boolean delete(int projectNo) {
		String sql = "delete project where project_no = ?";
		Object[] data = {projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	//프로젝트 수정(관리자가)
	@Override
	public boolean update(ProjectDto projectDto) {
		String sql = "update project set project_title = ?, project_goal_price = ?, project_total_price = ?, project_start_date = ?, project_end_date = ?, project_category = ?, "
				+ "project_content = ? where project_no = ?";
		Object[] data = {projectDto.getProjectTitle(), projectDto.getProjectGoalPrice(), projectDto.getProjectTotalPrice(), projectDto.getProjectStartDate(), projectDto.getProjectEndDate(),
				projectDto.getProjectCategory(), projectDto.getProjectContent(), projectDto.getProjectNo()};
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
	
	//프로젝트 리스트보기(관리자)
	@Override
	public List<ProjectListDto> selectList() {
		String sql = "select * from project order by project_no desc";
		return jdbcTemplate.query(sql, projectListMapper);
	}
		
}
