package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.ProjectSubPhotoDto;
import com.kh.springsemi.mapper.ProjectSubPhotoMapper;

@Repository
public class ProjectSubPhotoDaoImpl implements ProjectSubPhotoDao{
	@Autowired
	private ProjectSubPhotoMapper projectSubPhotoMapper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public void insert(ProjectSubPhotoDto projectSubPhotoDto) {
		String sql = "insert into project_subphoto values(?, ?)";
		Object[] data = {projectSubPhotoDto.getProjectNo(), projectSubPhotoDto.getAttachNo()};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public boolean delete(int projectNo) {
		String sql = "delete project_subphoto where project_no = ?";
		Object[] data = {projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public ProjectSubPhotoDto selectOne(int projectNo) {
		String sql = "select * from project_subphoto where project_no = ?";
		Object[] data = {projectNo};
		List<ProjectSubPhotoDto> list = jdbcTemplate.query(sql, projectSubPhotoMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
}
