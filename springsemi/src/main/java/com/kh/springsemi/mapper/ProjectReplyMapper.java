package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.ProjectReplyDto;

@Component
public class ProjectReplyMapper implements RowMapper<ProjectReplyDto>{

	@Override
	public ProjectReplyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ProjectReplyDto projectReplyDto = new ProjectReplyDto();
		projectReplyDto.setProjectReplyNo(rs.getInt("project_reply_no"));
		projectReplyDto.setProjectReplyWriter(rs.getString("project_reply_writer"));
		projectReplyDto.setProjectReplyContent(rs.getString("project_reply_content"));
		projectReplyDto.setProjectReplyTime(rs.getDate("project_reply_time"));
		projectReplyDto.setProjectReplyOrigin(rs.getInt("project_reply_origin"));
		return projectReplyDto;
	}

}
