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
	private String memberNickname; //작성자 닉네임
	
	public String getReviewWriterString() {
		if(reviewWriter == null)
			return "탈퇴한 사용자";
		return memberNickname;
	}
}
