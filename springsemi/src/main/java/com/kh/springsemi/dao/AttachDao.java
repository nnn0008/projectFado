package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.AttachDto;

public interface AttachDao {
	int sequence();
	void insert(AttachDto attachDto);
	boolean delete(int attachNo);
	AttachDto selectOne(int attachNo);
	List<AttachDto> selectList();
}
