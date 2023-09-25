package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberDto {
	private String memberId, memberPw, memberNickname;
	private String memberBirth; 
	private String memberContact, memberEmail;
	private String memberLevel; 
	private int memberPoint;
	private Date memberJoin;
	private Date memberLastLogin;
	private Date memberChangePw;
}
