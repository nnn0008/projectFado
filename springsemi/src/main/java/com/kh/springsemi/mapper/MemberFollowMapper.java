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
		MemberFollowDto memberFollowDto = new MemberFollowDto();
		memberFollowDto.setFollowerId(rs.getString("follower_id"));
		memberFollowDto.setFolloweeId(rs.getString("followee_id"));
		memberFollowDto.setFollowDate(rs.getDate("follow_date"));
		memberFollowDto.setFollowYN(rs.getString("follow_YN"));
		return memberFollowDto;
	}
}
