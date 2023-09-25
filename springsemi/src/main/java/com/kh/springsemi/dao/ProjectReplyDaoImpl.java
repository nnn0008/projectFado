package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.ProjectReplyDto;
import com.kh.springsemi.mapper.ProjectReplyMapper;

@Repository
public class ProjectReplyDaoImpl implements ProjectReplyDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ProjectReplyMapper projectReplyMapper;
	
	
	
	
	@Override
	public int sequence() {
		String sql = "select project_reply_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(ProjectReplyDto projectReplyDto) {
		String sql = "insert into project_reply("
				+ "project_reply_no, project_reply_writer, project_reply_content, "
				+ "project_reply_origin) "
				+ "values(?,?,?,?)";
		Object[] data = {
				projectReplyDto.getProjectReplyNo(), projectReplyDto.getProjectReplyWriter(),
				projectReplyDto.getProjectReplyContent(), projectReplyDto.getProjectReplyOrigin()
		};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public List<ProjectReplyDto> selectList(int projectReplyOrigin) {
		String sql = "select * from project_reply where project_reply_origin=? order by project_reply_no asc";
		Object[] data = {projectReplyOrigin};
		return jdbcTemplate.query(sql, projectReplyMapper, data);
	}

	@Override
	public ProjectReplyDto selectOne(int projectReplyNo) {
		String sql = "select * from project_reply where project_reply_no = ?";
		Object[] data = {projectReplyNo};
		List<ProjectReplyDto> list = jdbcTemplate.query(sql, projectReplyMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public boolean delete(int projectReplyNo) {
		String sql = "delete project_reply where project_reply_no = ?";
		Object[] data = {projectReplyNo};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public boolean update(ProjectReplyDto projectReplyDto) {
		String sql = "update project_reply set project_reply_content = ? where project_reply_no = ?";
		Object[] data = {projectReplyDto.getProjectReplyContent(), projectReplyDto.getProjectReplyNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}

}
