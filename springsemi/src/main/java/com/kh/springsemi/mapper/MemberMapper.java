package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.MemberDto;

@Component
public class MemberMapper implements RowMapper<MemberDto>{

	@Override
	public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberId(rs.getString("member_id"));
		memberDto.setMemberPw(rs.getString("member_pw"));
		memberDto.setMemberNickname(rs.getString("member_nickname"));
		memberDto.setMemberBirth(rs.getString("member_birth"));
		memberDto.setMemberContact(rs.getString("member_contact"));
		memberDto.setMemberEmail(rs.getString("member_email"));
		memberDto.setMemberLevel(rs.getString("member_level"));
		memberDto.setMemberPoint(rs.getInt("member_point"));
		memberDto.setMemberJoin(rs.getDate("member_join"));
		memberDto.setMemberLastLogin(rs.getDate("member_last_login"));
		memberDto.setMemberChangePw(rs.getDate("member_change_pw"));
		return memberDto;
	}
}
