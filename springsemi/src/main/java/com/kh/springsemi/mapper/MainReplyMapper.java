package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.MainReplyDto;

@Component
public class MainReplyMapper implements RowMapper<MainReplyDto>{

	@Override
	public MainReplyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MainReplyDto mainReplyDto = new MainReplyDto();
		mainReplyDto.setMainReplyNo(rs.getInt("main_reply_no"));
		mainReplyDto.setMainReplyWriter(rs.getString("main_reply_writer"));
		mainReplyDto.setMainReplyContent(rs.getString("main_reply_content"));
		mainReplyDto.setMainReplyTime(rs.getDate("main_reply_time"));
		mainReplyDto.setMainReplyOrigin(rs.getInt("main_reply_origin"));
		return mainReplyDto;
	}

}
