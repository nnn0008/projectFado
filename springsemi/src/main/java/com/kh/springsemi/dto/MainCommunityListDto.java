package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MainCommunityListDto {
	private int mainCommunityNo;
	private String mainCommunityWriter;
	private String mainCommunityTitle;
	private Date mainCommunityRegDate;
	private String mainCommunityType;
	private String memberNickname;   //작성자 닉네임 출력
	
	public String getMainCommunityWriterString() {
		if(mainCommunityWriter == null) 
			return "탈퇴한 사용자";
		return memberNickname;
		}
	}

