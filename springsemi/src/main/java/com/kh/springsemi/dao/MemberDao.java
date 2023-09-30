package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.DeliveryDto;
import com.kh.springsemi.dto.MemberBlockDto;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.MemberFollowDto;
import com.kh.springsemi.dto.MemberListDto;
import com.kh.springsemi.vo.PaginationVO;

public interface MemberDao {
	//C - 회원 등록
	void insert(MemberDto memberDto);
	//R - 회원 상세
	MemberDto selectOne(String memberId);
	//U - 회원 비밀번호 수정, 개인정보 수정, 로그인 시간 수정
	boolean updateMemberPw(String memberId, String changePw);
	boolean updateMemberInfo(MemberDto memberDto);
	boolean updateMemberLogin(String memberId);
	//D - 회원 삭제
	boolean delete(String memberId);
	//관리자 회원 정보 수정 
	boolean updateMemberInfoByAdmin(MemberDto memberDto);

	
	//배송지번호 시퀀스
	int sequence();
	//C - 배송지 등록
	void insert(DeliveryDto deliveryDto);
	//R - 배송지 상세
	DeliveryDto selectOne(int deliveryNo);
	//U - 배송지 수정
	boolean updateAddress(DeliveryDto deliveryDto);
	//D - 배송지 삭제
	boolean delete(int deliveryNo);
	
	
	int countList(PaginationVO vo);
	List<MemberDto> selectListByPage(PaginationVO vo);
	List<MemberListDto> selectListByPage2(PaginationVO vo);
	
	
//	차단+해제 기능 
	void insertBlock(String memberId);
	boolean deleteBlock(String memberId);
	
	List<MemberBlockDto> selectBlockList();
	MemberBlockDto selectBlockOne(String memberId);
	
// 회원 프로필 관련 기능
	void insertProfile(String memberId, int attachNo);
	boolean deleteProfile(String memberId);
	Integer findProfile(String memberId);
	MemberDto selectOneByMemberNickname(String memberNickname);
	
// 회원 팔로우 관련 기능	
	void insertFollow(MemberFollowDto memberFollowDto);
	boolean deleteFollow(MemberFollowDto memberFollowDto);
	boolean check(MemberFollowDto memberFollowDto);
	int count(String followeeId);
	int countFollowList(PaginationVO vo, String followerId);
	List<MemberFollowDto> selectFollowListByPage(PaginationVO vo, String followerId);
	
	MemberFollowDto selectOneByFollowerId(String followerId);
	List<MemberDto> findByFollowerId(String followerId);
	List<MemberFollowDto> selectFollowingList(MemberFollowDto memberFollowDto);
	boolean updateFollow(String followerId, String followeeId);
}
