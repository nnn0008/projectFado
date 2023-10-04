package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.ReviewListDto;

@Component
public class ReviewListMapper implements RowMapper<ReviewListDto>{

	@Override
	public ReviewListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReviewListDto reviewListDto = new ReviewListDto();
		reviewListDto.setReviewNo(rs.getInt("review_no"));
		reviewListDto.setReviewWriter(rs.getString("review_writer"));
		reviewListDto.setReviewContent(rs.getString("review_content"));
		reviewListDto.setReviewRegDate(rs.getDate("review_reg_Date"));
		reviewListDto.setProjectNo(rs.getInt("project_no"));
		reviewListDto.setMemberNickname(rs.getString("member_nick_name"));
		reviewListDto.setAttachNo(rs.getInt("attach_no"));
		return reviewListDto;
	}

}
