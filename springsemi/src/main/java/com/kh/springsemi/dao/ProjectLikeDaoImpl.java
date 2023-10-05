package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.ProjectLikeDto;
import com.kh.springsemi.mapper.ProjectLikeMapper;
import com.kh.springsemi.mapper.ProjectMapper;

@Repository
public class ProjectLikeDaoImpl implements ProjectLikeDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ProjectLikeMapper projectLikeMapper;
	
	@Autowired
	private ProjectMapper projectMapper;

	@Override
	public void insert(ProjectLikeDto projectLikeDto) {
		String sql = "insert into project_like(member_id, project_no) values(?, ?)";
		Object[] data = {projectLikeDto.getMemberId(), projectLikeDto.getProjectNo()};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean delete(ProjectLikeDto projectLikeDto) {
		String sql = "delete project_like where member_id = ? and project_no = ?";
		Object[] data = {projectLikeDto.getMemberId(), projectLikeDto.getProjectNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public boolean check(ProjectLikeDto projectLikeDto) {
		String sql = "select * from project_like where member_id = ? and project_no = ?";
		Object[] data = {projectLikeDto.getMemberId(), projectLikeDto.getProjectNo()};
		List<ProjectLikeDto> list = jdbcTemplate.query(sql, projectLikeMapper, data);
		return list.isEmpty() ? false : true;
	}

	@Override
	public int count(int projectNo) {
		String sql = "select count(*) from project_like where project_no = ?";
		Object[] data = {projectNo};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}

	@Override
	public List<ProjectDto> findByMemberId(String memberId) {
		String sql = "select project.* "
					+ "from project_like left outer join project on project_like.project_no = project.project_no "
					+ "where project_like.member_id = ? order by project.project_no desc";
		Object[] data = {memberId};
		return jdbcTemplate.query(sql, projectMapper, data);
	}

}
