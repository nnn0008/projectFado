package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.DeliveryDto;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.vo.PaginationVO;

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
//	List<MemberListDto> selectListByPage2(PaginationVO vo);
	
	
//	차단+해제 기능 
	void insertBlock(String memberId);
	boolean deleteBlock(String memberId);
	

}
