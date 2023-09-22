package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.MajorCategoryDto;

@Component
public class MajorCategoryMapper implements RowMapper<MajorCategoryDto>{
	@Override
	public MajorCategoryDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MajorCategoryDto majorCategoryDto = new MajorCategoryDto();
		majorCategoryDto.setMajorCategoryNo(rs.getInt("major_category_no"));
		majorCategoryDto.setMajorCategoryType(rs.getString("major_category_type"));
		return majorCategoryDto;
	}
}
