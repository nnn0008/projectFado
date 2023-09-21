package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.MainCommunityListDto;

@Component
public class MainCommunityListMapper implements RowMapper<MainCommunityListDto>{

	@Override
	public MainCommunityListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MainCommunityListDto mainCommunityListDto = new MainCommunityListDto();
		mainCommunityListDto.setMainCommunityNo(rs.getInt("main_community_no"));
		mainCommunityListDto.setMainCommunityWriter(rs.getString("main_community_writer"));
		mainCommunityListDto.setMainCommunityTitle(rs.getString("main_community_title"));
		mainCommunityListDto.setMainCommunityRegDate(rs.getDate("main_community_reg_date"));
		mainCommunityListDto.setMainCommunityType(rs.getString("main_community_type"));
		mainCommunityListDto.setMemberNickname(rs.getString("member_nickname"));
		return mainCommunityListDto;
	}
		//listMapper = 게시글 상세 (내용/답글 제외)
}
