package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.MinorCategoryDto;

@Component
public class MinorCategoryMapper implements RowMapper<MinorCategoryDto>{
	@Override
	public MinorCategoryDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MinorCategoryDto minorCategoryDto = new MinorCategoryDto();
		minorCategoryDto.setMinorCategoryNo(rs.getInt("minor_category_no"));
		minorCategoryDto.setMajorCategoryNo(rs.getInt("major_category_no"));
		minorCategoryDto.setMinorCategoryType(rs.getString("minor_category_type"));
		return minorCategoryDto;
	}
}
