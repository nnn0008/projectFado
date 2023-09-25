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
}
