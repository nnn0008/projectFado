package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ProjectCommunityDto {
	private int projectCommunityNo;
	private String projectCommunityWriter;
	private String projectCommunityTitle;
	private String projectCommunityContent;
	private Date projectCommunityRegDate;
	private String projectCommunityType;
	private String projectCommunityReply;
	private String memberNickname; //작성자 닉네임
	
	public String getProjectCommunityWriterString() {
		if(projectCommunityWriter == null)
			return "탈퇴한 사용자";
		return memberNickname;
	}
	
}
