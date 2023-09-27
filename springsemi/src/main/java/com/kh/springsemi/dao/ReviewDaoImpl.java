package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springsemi.dto.AttachDto;
import com.kh.springsemi.dto.ReviewDto;
import com.kh.springsemi.mapper.ReviewMapper;
import com.kh.springsemi.vo.PaginationVO;

@Repository
public class ReviewDaoImpl implements ReviewDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ReviewMapper reviewMapper;

	@Override
	public int sequence() {
		String sql = "select review_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(ReviewDto reviewDto) {
		String sql = "insert into review("
				+ "review_no, project_no, review_writer, review_content, review_star"
				+ ") "
				+ "values(?, ?, ?, ?, ?)";
		Object[] data = {reviewDto.getReviewNo(), reviewDto.getProjectNo(), reviewDto.getReviewWriter(),
						reviewDto.getReviewContent(), reviewDto.getReviewStar()};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean update(ReviewDto reviewDto) {
		String sql = "update review set review_content=?, review_star=? "
						+ "where review_no=?";
		Object[] data = {reviewDto.getReviewContent(), reviewDto.getReviewStar(), reviewDto.getReviewNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public boolean delete(int reviewNo) {
		String sql = "delete review where review_no=?";
		Object[] data = {reviewNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	
	@Override
	public ReviewDto selectOne(int reviewNo) {
		String sql = "select * from review where review_no=?";
		Object[] data = {reviewNo};
		List<ReviewDto> list = jdbcTemplate.query(sql, reviewMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<ReviewDto> selectList(@RequestParam int reviewNo) {
		String sql = "select * from review order by review_no desc";
		Object[] data = {reviewNo};
		return jdbcTemplate.query(sql, reviewMapper, data);
	}



	@Override
	public void connect(int reviewNo, int attachNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int countList(PaginationVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ReviewDto> selectListBypage(PaginationVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AttachDto findReviewPhoto(int reviewNo) {
		// TODO Auto-generated method stub
		return null;
	}

}
