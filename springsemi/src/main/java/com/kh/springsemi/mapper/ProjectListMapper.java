package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.ProjectListDto;
//일단 만들어 두긴 했는데 쓸지 잘 모르겠음
@Component
public class ProjectListMapper implements RowMapper<ProjectListDto>{
@Override
public ProjectListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
	ProjectListDto projectListDto = new ProjectListDto();
	projectListDto.setProjectNo(rs.getInt("project_no"));
	projectListDto.setProjectTitle(rs.getString("project_Title"));
	projectListDto.setProjectGoalPrice(rs.getInt("project_goal_price"));
	projectListDto.setProjectTotalPrice(rs.getInt("project_total_price"));
	projectListDto.setProjectStartDate(rs.getDate("project_start_date"));
	projectListDto.setProjectEndDate(rs.getDate("project_end_date"));
//	projectListDto.setProjectPeriod(rs.getInt("project_period"));
	projectListDto.setProjectCategory(rs.getString("project_category"));
	projectListDto.setProjectRegDate(rs.getDate("project_reg_date"));
//	projectListDto.setProjectContent(rs.getString("project_content"));
	projectListDto.setProjectOwner(rs.getString("project_owner"));
	projectListDto.setProjectReadcount(rs.getLong("project_readcount"));
	return projectListDto;
	}
}
