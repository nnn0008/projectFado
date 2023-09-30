package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewDto {
	private int reviewNo;
	private int projectNo;
	private String reviewWriter;
	private String reviewContent;
	private Date reviewRegDate; 
}
