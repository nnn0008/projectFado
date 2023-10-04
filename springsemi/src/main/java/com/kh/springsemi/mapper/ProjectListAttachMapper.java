package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.ProjectListAttachDto;
//일단 만들어 두긴 했는데 쓸지 잘 모르겠음
@Component
public class ProjectListAttachMapper implements RowMapper<ProjectListAttachDto>{
@Override
public ProjectListAttachDto mapRow(ResultSet rs, int rowNum) throws SQLException {
	ProjectListAttachDto projectListAttachDto = new ProjectListAttachDto();
	projectListAttachDto.setProjectNo(rs.getInt("project_no"));
	projectListAttachDto.setProjectTitle(rs.getString("project_title"));
	projectListAttachDto.setProjectOwner(rs.getString("project_owner"));
	projectListAttachDto.setProjectRegDate(rs.getDate("project_reg_date"));
	projectListAttachDto.setProjectStartDate(rs.getDate("project_start_date"));
	projectListAttachDto.setProjectEndDate(rs.getDate("project_end_date"));
	projectListAttachDto.setProjectTotalPrice(rs.getInt("project_total_price"));
	projectListAttachDto.setProjectGoalPrice(rs.getInt("project_goal_price"));
	projectListAttachDto.setProjectReadcount(rs.getLong("project_readcount"));
	projectListAttachDto.setProjectLikecount(rs.getInt("project_likecount"));
	projectListAttachDto.setMajorCategoryType(rs.getString("major_category_type"));
	projectListAttachDto.setMinorCategoryType(rs.getString("minor_category_type"));
	projectListAttachDto.setJudgeStatus(rs.getString("judge_status"));
	projectListAttachDto.setJudgeDate(rs.getDate("judge_date"));
	projectListAttachDto.setAchievementRate(rs.getDouble("achievement_rate"));
	projectListAttachDto.setAttachNo(rs.getInt("attach_no"));
//	projectListAttachDto.setProjectPeriod(rs.getInt("project_period"));
//	projectListAttachDto.setProjectContent(rs.getString("project_content"));
//	projectListAttachDto.setMinorCategoryNo(rs.getInt("minor_category_no"));
	return projectListAttachDto;
	}
}
