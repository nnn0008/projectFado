package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.ProjectLikeDto;

@Component
public class ProjectLikeMapper implements RowMapper<ProjectLikeDto>{
	
	@Override
	public ProjectLikeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ProjectLikeDto projectLikeDto = new ProjectLikeDto();
		projectLikeDto.setMemberId(rs.getString("member_id"));
		projectLikeDto.setProjectNo(rs.getInt("project_no"));
		return projectLikeDto;
	}

}
