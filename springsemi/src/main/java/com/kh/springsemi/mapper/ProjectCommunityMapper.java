package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.ProjectCommunityDto;

@Component
public class ProjectCommunityMapper implements RowMapper<ProjectCommunityDto> {

	@Override
	public ProjectCommunityDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ProjectCommunityDto projectCommunityDto = new ProjectCommunityDto();
		projectCommunityDto.setProjectCommunityTitle(rs.getString("ProjectCommunity_title"));
		projectCommunityDto.setProjectCommunityContent(rs.getString("ProjectCommunity_content"));
		projectCommunityDto.setProjectCommunityType(rs.getString("ProjectCommunity_type"));
		projectCommunityDto.setProjectCommunityReply(rs.getString("ProjectCommunity_reply"));
		projectCommunityDto.setProjectCommunityRegDate(rs.getDate("ProjectCommunity_regdate"));
		return projectCommunityDto;
	}
}
