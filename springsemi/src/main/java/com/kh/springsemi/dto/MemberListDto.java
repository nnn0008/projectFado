package com.kh.springsemi.dto;

import lombok.Data;

@Data
public class MemberListDto {
	private String memberId, memberPw, memberNickname;
	private String memberBirth; 
	private String memberContact, memberEmail;
	private String memberLevel; 
	private int memberPoint;
	private String block; //차단여부 
}
