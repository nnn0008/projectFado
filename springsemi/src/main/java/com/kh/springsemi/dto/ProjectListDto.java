package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ProjectListDto {
	private int projectNo;
	private String projectTitle;
	private String projectOwner;
	private Date projectRegDate;
	private Date projectStartDate;
	private Date projectEndDate;
	private int projectTotalPrice;
	private int projectGoalPrice;
	private long projectReadcount;
	private int projectLikecount;
	private String majorCategoryType;
	private String minorCategoryType;
	private String judgeStatus;
	private Date judgeDate;
	private double achievementRate;
	private Date paymentDate;
//	private int projectPeriod;
//	private int minorCategoryNo;
}
