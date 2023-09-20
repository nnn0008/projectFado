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
}
