package com.kh.springsemi.dao;

import com.kh.springsemi.dto.MemberDto;

public interface MemberDao {
	//C
	void insert(MemberDto memberDto);
	//R
	MemberDto selectOne(String memberId);
	//U
	boolean updateMemberPw(String memberId, String changePw);
	boolean updateMemberInfo(MemberDto memberDto);
	//D
	boolean delete(String memberId);
}
