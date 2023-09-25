package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.MainCommunityDto;

@Component
public class MainCommunityMapper implements RowMapper<MainCommunityDto>{

	@Override
	public MainCommunityDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MainCommunityDto mainCommunityDto = new MainCommunityDto();
		mainCommunityDto.setMainCommunityNo(rs.getInt("main_community_no"));
		mainCommunityDto.setMainCommunityWriter(rs.getString("main_community_writer"));
		mainCommunityDto.setMainCommunityTitle(rs.getString("main_community_title"));
		mainCommunityDto.setMainCommunityContent(rs.getString("main_community_content"));
		mainCommunityDto.setMainCommunityRegDate(rs.getDate("main_community_reg_date"));
		mainCommunityDto.setMainCommunityType(rs.getString("main_community_type"));
		return mainCommunityDto;
	}

}
