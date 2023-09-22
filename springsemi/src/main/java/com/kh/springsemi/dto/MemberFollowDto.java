package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberFollowDto {
	private String followerId;
	private String followeeId;
	private Date followDate;
}
