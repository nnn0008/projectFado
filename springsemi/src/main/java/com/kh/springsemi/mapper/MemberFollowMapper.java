package com.kh.springsemi.mapper;

import java.sql.ResultSet;

import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.MemberFollowDto;

@Component
public class MemberFollowMapper implements RowMapper<MemberFollowDto>{
	@Override
	public MemberFollowDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberFollowDto followDto = new MemberFollowDto();
		followDto.setFollowerId(rs.getString("follower_id"));
		followDto.setFolloweeId(rs.getString("followee_id"));
		followDto.setFollowDate(rs.getDate("follow_date"));
		return followDto;
	}
}
