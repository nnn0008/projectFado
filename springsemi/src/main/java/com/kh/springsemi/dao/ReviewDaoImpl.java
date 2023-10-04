package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springsemi.dto.AttachDto;
import com.kh.springsemi.dto.ReviewDto;
import com.kh.springsemi.dto.ReviewListDto;
import com.kh.springsemi.mapper.AttachMapper;
import com.kh.springsemi.mapper.ReviewListMapper;
import com.kh.springsemi.mapper.ReviewMapper;

@Repository
public class ReviewDaoImpl implements ReviewDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private ReviewListMapper reviewListMapper;

	@Override
	public int sequence() {
		String sql = "select review_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(ReviewDto reviewDto) {
		String sql = "insert into review("
				+ "review_no, project_no, review_writer, review_content"
				+ ") "
				+ "values(?, ?, ?, ?)";
		Object[] data = {reviewDto.getReviewNo(), reviewDto.getProjectNo(),
				reviewDto.getReviewWriter(), reviewDto.getReviewContent()};
		jdbcTemplate.update(sql, data);
	}
	

	@Override
	public void connect(int reviewNo, int attachNo) {
		String sql = "insert into review_photo values(?, ?)";
		Object[] data = {reviewNo, attachNo};
		jdbcTemplate.update(sql, data);
		
	}

	@Override
	public AttachDto findReviewPhoto(int reviewNo) {
		String sql = "select * from attach where attach_no = ("
				+ "select attach_no from review_photo "
				+ "where review_no = ?)";
		Object[] data = {reviewNo};
		List<AttachDto> list = jdbcTemplate.query(sql, attachMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<ReviewListDto> selectList(@RequestParam int projectNo) {
		String sql = "SELECT * FROM review_list LEFT OUTER JOIN review_photo rp "
				+ "ON review_list.review_no = rp.REVIEW_NO "
				+ "WHERE review_list.PROJECT_NO = ?";
		Object[] data = {projectNo};
		return jdbcTemplate.query(sql, reviewListMapper, data);
	}

	@Override
	public ReviewDto selectOne(int reviewNo) {
		String sql = "select review.*, review_photo.attach_no "
				+ "from review "
				+ "left outer join review_photo on review.review_no = review_photo.review_no "
				+ "where review.review_no = ?";
		Object[] data = {reviewNo};
		List<ReviewDto> list = jdbcTemplate.query(sql, reviewMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	@Override
	public boolean update(ReviewDto reviewDto) {
		String sql = "update review set review_content=? where review_no=?";
		Object[] data = {reviewDto.getReviewContent(), reviewDto.getReviewNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public boolean delete(int reviewNo) {
		String sql = "delete review where review_no=?";
		Object[] data = {reviewNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	



}
