package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MainReplyDto {
	private int mainReplyNo;
	private String mainReplyWriter;
	private String mainReplyContent;
	private Date mainReplyTime;
	private int mainReplyOrigin;
}
