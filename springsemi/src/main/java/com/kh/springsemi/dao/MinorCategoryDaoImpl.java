package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.MinorCategoryDto;
import com.kh.springsemi.mapper.MinorCategoryMapper;

@Repository
public class MinorCategoryDaoImpl implements MinorCategoryDao{
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MinorCategoryMapper minorCategoryMapper;
	
	@Override
	public int sequence() {
		String sql = "select minorcategory_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(MinorCategoryDto minorCategoryDto) {
		String sql = "insert into minorcategory(minor_category_no, major_category_no, minor_category_type) "
				+ "values(?, ?, ?)";
		Object[] data = {minorCategoryDto.getMinorCategoryNo(), minorCategoryDto.getMajorCategoryNo(), minorCategoryDto.getMinorCategoryType()};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public boolean delete(int minorCategoryNo) {
		String sql = "delete minorcategory where minor_category_no = ?";
		Object[] data = {minorCategoryNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public boolean update(MinorCategoryDto minorCategoryDto) {
		String sql = "update minorcategory set minor_category_type = ? where minor_category_no = ?";
		Object[] data = {minorCategoryDto.getMinorCategoryType(), minorCategoryDto.getMinorCategoryNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public List<MinorCategoryDto> selectList() {
		String sql = "select * from minorcategory order by minor_category_no asc";
		return jdbcTemplate.query(sql, minorCategoryMapper);
	}
	
	@Override
	public MinorCategoryDto selectOne(int minorCategoryNo) {
		String sql = "select * from minorcategory where minor_category_no = ?";
		Object[] data = {minorCategoryNo};
		List<MinorCategoryDto> list = jdbcTemplate.query(sql, minorCategoryMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
}
