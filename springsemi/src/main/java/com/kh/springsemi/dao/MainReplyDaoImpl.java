package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.MainReplyDto;
import com.kh.springsemi.mapper.MainReplyMapper;

@Repository
public class MainReplyDaoImpl implements MainReplyDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MainReplyMapper mainReplyMapper;
	
	
	
	
	@Override
	public int sequence() {
		String sql = "select main_reply_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(MainReplyDto mainReplyDto) {
		String sql = "insert into main_reply("
				+ "main_reply_no, main_reply_writer, main_reply_content, "
				+ "main_reply_origin) "
				+ "values(?,?,?,?)";
		Object[] data = {
				mainReplyDto.getMainReplyNo(), mainReplyDto.getMainReplyWriter(),
				mainReplyDto.getMainReplyContent(), mainReplyDto.getMainReplyOrigin()
		};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public List<MainReplyDto> selectList(int mainReplyOrigin) {
		String sql = "select * from main_reply where main_reply_origin=? order by main_reply_no asc";
		Object[] data = {mainReplyOrigin};
		return jdbcTemplate.query(sql, mainReplyMapper, data);
	}

	@Override
	public MainReplyDto selectOne(int mainReplyNo) {
		String sql = "select * from main_reply where main_reply_no = ?";
		Object[] data = {mainReplyNo};
		List<MainReplyDto> list = jdbcTemplate.query(sql, mainReplyMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public boolean delete(int mainReplyNo) {
		String sql = "delete main_reply where main_reply_no = ?";
		Object[] data = {mainReplyNo};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public boolean update(MainReplyDto mainReplyDto) {
		String sql = "update main_reply set main_reply_content = ? where main_reply_no = ?";
		Object[] data = {mainReplyDto.getMainReplyContent(), mainReplyDto.getMainReplyNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}

}
