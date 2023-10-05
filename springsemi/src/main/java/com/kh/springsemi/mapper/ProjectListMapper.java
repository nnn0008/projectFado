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
	projectListDto.setProjectTitle(rs.getString("project_title"));
	projectListDto.setProjectOwner(rs.getString("project_owner"));
	projectListDto.setProjectRegDate(rs.getDate("project_reg_date"));
	projectListDto.setProjectStartDate(rs.getDate("project_start_date"));
	projectListDto.setProjectEndDate(rs.getDate("project_end_date"));
	projectListDto.setProjectTotalPrice(rs.getInt("project_total_price"));
	projectListDto.setProjectGoalPrice(rs.getInt("project_goal_price"));
	projectListDto.setProjectReadcount(rs.getLong("project_readcount"));
	projectListDto.setProjectLikecount(rs.getInt("project_likecount"));
	projectListDto.setMajorCategoryType(rs.getString("major_category_type"));
	projectListDto.setMinorCategoryType(rs.getString("minor_category_type"));
	projectListDto.setJudgeStatus(rs.getString("judge_status"));
	projectListDto.setJudgeDate(rs.getDate("judge_date"));
	projectListDto.setAchievementRate(rs.getDouble("achievement_rate"));
	projectListDto.setPaymentDate(rs.getDate("payment_date"));
//	projectListDto.setProjectPeriod(rs.getInt("project_period"));
//	projectListDto.setProjectContent(rs.getString("project_content"));
//	projectListDto.setMinorCategoryNo(rs.getInt("minor_category_no"));
	return projectListDto;
	}
}
