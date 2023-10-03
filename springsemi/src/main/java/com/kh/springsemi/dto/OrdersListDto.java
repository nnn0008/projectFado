package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class OrdersListDto {
	private int projectNo;
	private String projectTitle;
	private String projectOwner;
	private int projectTotalPrice;
	private int projectGoalPrice;
	private Date projectEndDate;
	private String majorCategoryType;
	private String minorCategoryType;
	private String memberNickname;
	private String memberContact, memberEmail;
	private int memberPoint;
	private int deliveryNo;
	private String deliveryReceiver, deliveryPost, deliveryAddr1, deliveryAddr2, deliveryContact;
	private Date ordersDate;
	private String ordersReward;
	private int ordersPrice;
	private String ordersStatus;
}
