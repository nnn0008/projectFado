package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class OrdersDto {
	private int ordersNo;
	private String ordersPerson;
	private Date ordersDate;
	private String ordersReward;
	private int ordersPrice;
	private String ordersStatus;
}
