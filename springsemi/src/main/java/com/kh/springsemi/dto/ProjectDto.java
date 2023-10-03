package com.kh.springsemi.dto;

import java.sql.Date;
import java.time.LocalDate;

import lombok.Data;

@Data
public class ProjectDto {
	private int projectNo;
	private String projectTitle;
	private int projectGoalPrice;
	private int projectTotalPrice;
	private Date projectStartDate;
	private Date projectEndDate;
	private int projectPeriod;
	private Date projectRegDate;
//	private String projectContent;
	private String projectOwner;
	private long projectReadcount;
	private int minorCategoryNo;
//	private int judgeNo;
	
	//프로젝트 종료일을 계산하는 가상의 getter 메소드
	public Date getCalculateEndDate() {
		LocalDate start = projectStartDate.toLocalDate();
		LocalDate end = start.plusDays(projectPeriod);
		return Date.valueOf(end);
	}
}
