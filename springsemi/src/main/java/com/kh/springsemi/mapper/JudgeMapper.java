package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.kh.springsemi.dto.JudgeDto;

public class JudgeMapper implements RowMapper<JudgeDto>{
	@Override
	public JudgeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		JudgeDto judgeDto = new JudgeDto();
		judgeDto.setJudgeNo(rs.getInt("judge_no"));
		judgeDto.setProjectNo(rs.getInt("project_no"));
		judgeDto.setJudgeStatus(rs.getString("judge_status"));
		judgeDto.setJudgeDate(rs.getDate("judge_date"));
		return judgeDto;
	}
}
