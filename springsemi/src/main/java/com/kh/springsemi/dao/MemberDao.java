package com.kh.springsemi.dao;

import com.kh.springsemi.dto.MemberDto;

public interface MemberDao {
	//C - 회원 등록
	void insert(MemberDto memberDto);
	//R - 회원 상세
	MemberDto selectOne(String memberId);
	//U - 회원 비밀번호 수정, 개인정보 수정
	boolean updateMemberPw(String memberId, String changePw);
	boolean updateMemberInfo(MemberDto memberDto);
	//D - 회원 삭제
	boolean delete(String memberId);
}
