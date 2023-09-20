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
		projectCommunityDto.setProjectCommunityNo(rs.getInt("project_community_no"));
		projectCommunityDto.setProjectCommunityWriter(rs.getString("project_community_writer"));
		projectCommunityDto.setProjectCommunityTitle(rs.getString("Project_community_title"));
		projectCommunityDto.setProjectCommunityContent(rs.getString("Project_community_content"));
		projectCommunityDto.setProjectCommunityRegDate(rs.getDate("Project_community_reg_date"));
		projectCommunityDto.setProjectCommunityType(rs.getString("Project_community_type"));
		projectCommunityDto.setProjectCommunityReply(rs.getString("Project_community_reply"));
		return projectCommunityDto;
	}
}
