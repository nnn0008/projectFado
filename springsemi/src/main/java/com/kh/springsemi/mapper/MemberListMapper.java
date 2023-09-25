package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.MemberListDto;

@Component
public class MemberListMapper implements RowMapper<MemberListDto>{

	@Override
	public MemberListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberListDto memberListDto = new MemberListDto();
		memberListDto.setMemberId(rs.getString("member_id"));
		memberListDto.setMemberPw(rs.getString("member_pw"));
		memberListDto.setMemberNickname(rs.getString("member_nickname"));
		memberListDto.setMemberBirth(rs.getString("member_birth"));
		memberListDto.setMemberContact(rs.getString("member_contact"));
		memberListDto.setMemberEmail(rs.getString("member_email"));
		memberListDto.setMemberLevel(rs.getString("member_level"));
		memberListDto.setMemberPoint(rs.getInt("member_point"));
		memberListDto.setBlock(rs.getString("block"));
		
		return memberListDto;
	}
}
