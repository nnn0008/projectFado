package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.ReviewDto;

public interface ReviewDao {
	int sequence();
	void insert(ReviewDto reviewDto);
	boolean update(ReviewDto reviewDto);
	boolean delete(int reviewNo);
	List<ReviewDto> selectList();
}
