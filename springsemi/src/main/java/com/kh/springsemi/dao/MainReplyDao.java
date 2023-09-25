package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.MainReplyDto;

public interface MainReplyDao {

	int sequence();
	void insert(MainReplyDto mainReplyDto);
	List<MainReplyDto> selectList(int replyOrigin);
	MainReplyDto selectOne(int mainReplyNo);
	boolean delete(int mainReplyNo);
	boolean update(MainReplyDto mainReplyDto);
}
