package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.kh.springsemi.dto.FollowDto;

public class FollowMapper implements RowMapper<FollowDto>{
	@Override
	public FollowDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		FollowDto followDto = new FollowDto();
		followDto.setFollowerId(rs.getString("follower_id"));
		followDto.setFolloweeId(rs.getString("followee_id"));
		followDto.setFollowDate(rs.getDate("follow_date"));
		return followDto;
	}
}
