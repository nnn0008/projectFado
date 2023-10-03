package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.ProjectPhotoDto;
import com.kh.springsemi.mapper.ProjectPhotoMapper;

@Repository
public class ProjectPhotoDaoImpl implements ProjectPhotoDao{
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ProjectPhotoMapper projectPhotoMapper;
	
	@Override
	public void insert(ProjectPhotoDto projectPhotoDto) {
		String sql = "insert into project_photo values (?, ?)";
		Object[] data = {projectPhotoDto.getProjectNo(), projectPhotoDto.getAttachNo()};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public boolean delete(int projectNo) {
		String sql = "delete project_photo where project_no = ?";
		Object[] data = {projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public ProjectPhotoDto selectOne(int projectNo) {
		String sql = "select * from project_photo where project_no = ?";
		Object[] data = {projectNo};
		List<ProjectPhotoDto> list = jdbcTemplate.query(sql, projectPhotoMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
}
