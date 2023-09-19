package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class JudgeDto {
	private int judgeNo;
	private int projectNo;
	private String judgeStatus;
	private Date judgeDate;
}
