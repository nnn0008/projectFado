package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.MajorCategoryDto;
import com.kh.springsemi.mapper.MajorCategoryMapper;

@Repository
public class MajorCategoryDaoImpl implements MajorCategoryDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MajorCategoryMapper majorCategoryMapper;
	
	@Override
	public int sequence() {
		String sql = "select majorcategory_seq.nextval from dual";
		
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(MajorCategoryDto majorCategoryDto) {
		String sql = "insert into majorcategory(major_category_no, major_category_type) values(?, ?)";
		Object[] data = {majorCategoryDto.getMajorCategoryNo(), majorCategoryDto.getMajorCategoryType()};
		
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public boolean update(MajorCategoryDto majorCategoryDto) {
		String sql = "update majorcategory set major_category_type = ? where major_category_no = ?";
		Object[] data = {majorCategoryDto.getMajorCategoryType(), majorCategoryDto.getMajorCategoryNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public boolean delete(int majorCategoryNo) {
		String sql = "delete majorcategory where major_category_no = ?";
		Object[] data = {majorCategoryNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public List<MajorCategoryDto> selectList() {
		String sql = "select * from majorcategory order by major_category_no asc";
		return jdbcTemplate.query(sql, majorCategoryMapper);
	}
	
	@Override
	public MajorCategoryDto selectOne(int majorCategoryNo) {
		String sql = "select * from majorcategory where major_category_no = ?";
		Object[] data = {majorCategoryNo};
		List<MajorCategoryDto> list = jdbcTemplate.query(sql, majorCategoryMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	@Override
	public MajorCategoryDto selectOne(String majorCategoryType) {
		String sql = "select * from majorcategory where major_category_type = ?";
		Object[] data = {majorCategoryType};
		List<MajorCategoryDto> list = jdbcTemplate.query(sql, majorCategoryMapper, data); 
		return list.isEmpty() ? null : list.get(0);
	}
	
	@Override
	public boolean updateMajorCategoryCount() {
		String sql = "select count(*) from majorcategory";
		return jdbcTemplate.update(sql) > 0;
	}
}
