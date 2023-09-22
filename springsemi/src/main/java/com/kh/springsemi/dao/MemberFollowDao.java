package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.MemberFollowDto;

public interface MemberFollowDao {
	void insert(MemberFollowDto memberFollowDto);
	boolean delete(MemberFollowDto memberFollowDto);
	boolean check(MemberFollowDto memberFollowDto);
	int count(String followeeId);
	List<MemberDto> findByFollowerId(String followerId);
	
}
