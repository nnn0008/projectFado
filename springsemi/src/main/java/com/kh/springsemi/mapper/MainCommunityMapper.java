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
		mainCommunityDto.setMainCommunityNo(rowNum);
		mainCommunityDto.setMainCommunityWriter(null);
		mainCommunityDto.setMainCommunityTitle(null);
//		mainCommunityDto.set
//		mainCommunityDto
//		mainCommunityDto
//		mainCommunityDto
		return mainCommunityDto;
	}

}
