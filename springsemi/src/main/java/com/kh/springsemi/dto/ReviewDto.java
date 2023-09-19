package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewDto {
	private int reviewNo;
	private int projectNo;
	private String reviewWriter;
	private String reviewTitle;
	private String reviewContent;
	private int reviewStar;
	private Date reviewRegDate; 
}
