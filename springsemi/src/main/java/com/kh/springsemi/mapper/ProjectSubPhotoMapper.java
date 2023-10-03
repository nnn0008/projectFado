package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.ProjectSubPhotoDto;
@Component
public class ProjectSubPhotoMapper implements RowMapper<ProjectSubPhotoDto>{
	@Override
	public ProjectSubPhotoDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ProjectSubPhotoDto projectSubPhotoDto = new ProjectSubPhotoDto();
		projectSubPhotoDto.setProjectNo(rs.getInt("project_no"));
		projectSubPhotoDto.setAttachNo(rs.getInt("attach_no"));
		return projectSubPhotoDto;
	}
			
}
