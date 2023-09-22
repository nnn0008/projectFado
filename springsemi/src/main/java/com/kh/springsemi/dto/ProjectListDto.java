package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ProjectListDto {
	private int projectNo;
	private String projectTitle;
	private int projectGoalPrice;
	private int projectTotalPrice;
	private Date projectStartDate;
	private Date projectEndDate;
	private Date projectRegDate;
//	private String projectContent;
	private String projectOwner;
	private long projectReadcount;
}
