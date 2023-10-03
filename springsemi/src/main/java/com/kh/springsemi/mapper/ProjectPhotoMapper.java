package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.ProjectPhotoDto;

@Component
public class ProjectPhotoMapper implements RowMapper<ProjectPhotoDto>{
	@Override
	public ProjectPhotoDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ProjectPhotoDto projectPhotoDto = new ProjectPhotoDto();
		projectPhotoDto.setProjectNo(rs.getInt("project_no"));
		projectPhotoDto.setAttachNo(rs.getInt("attach_no"));
		return projectPhotoDto;
	}
}
