package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ProjectReplyDto {
	private int projectReplyNo;
	private String projectReplyWriter;
	private String projectReplyContent;
	private Date projectReplyTime;
	private int projectReplyOrigin;
	private String memberNickname;
	
	public String getProjectReplyWriterString() {
		if(projectReplyWriter == null)
			return "탈퇴한 사용자";
		return memberNickname;
	}
}
