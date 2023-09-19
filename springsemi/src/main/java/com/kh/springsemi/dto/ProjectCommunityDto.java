package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ProjectCommunityDto {

	private String projectCommunityTitle,
	projectCommunityContent,
	projectCommunityType,
	projectCommunityReply;
	private Date projectCommunityRegDate;
	private int projectCommunityNo;
	
}
