package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ProjectDto {
	private int projectNo;
	private String projectTitle;
	private int projectGoalPrice;
	private int projectTotalPrice;
	private Date projectStartDate;
	private Date projectEndDate;
	//private int projectPeriod;
	private String projectCategory;
	private Date projectRegDate;
	private String projectContent;
	private String projectOwner;
}
