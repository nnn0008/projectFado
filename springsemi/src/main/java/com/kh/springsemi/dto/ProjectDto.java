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
	private int projectDuration;
	private String projectCategory;
	private Date projectRegDate;
	private String projectContent;
	private String projectOwner;
	private long projectReadcount;
	
	public Date getCalculateEndDate() {
		LocalDate start = projectStartDate.toLocalDate();
		LocalDate end = start.plusDays(projectDuration);
		return Date.valueOf(end);
	}
}
