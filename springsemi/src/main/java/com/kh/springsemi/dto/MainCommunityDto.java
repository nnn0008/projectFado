package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MainCommunityDto {
	private int mainCommunityNo;
	private String mainCommunityWriter;
	private String mainCommunityTitle;
	private String mainCommunityContent;
	private Date mainCommunityRegDate;
	private String mainCommunityType;
	private String memberNickname;
	
	
	public String getMainCommunityWriterString() {
		if(mainCommunityWriter == null)
			return "탈퇴한 사용자";
		return memberNickname;
	}
}
