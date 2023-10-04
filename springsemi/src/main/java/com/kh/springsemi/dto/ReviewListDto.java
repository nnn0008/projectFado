package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewListDto {
	private int reviewNo;
	private String reviewWriter;
	private String reviewContent;
	private Date reviewRegDate;
	private int projectNo;
	private String memberNickname;
	private int attachNo;
	
	public String getReviewWriterString() {
		if(reviewWriter == null)
			return "탈퇴한 사용자";
		return memberNickname;
	}
}