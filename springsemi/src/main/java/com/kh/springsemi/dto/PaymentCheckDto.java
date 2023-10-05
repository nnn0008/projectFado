package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class PaymentCheckDto {
	private String memberId;
	private int memberPoint;
	private String memberEmail;
	private String memberContact;
	private int ordersNo;
	private int ordersPrice;
	private int projectNo;
	private Date paymentDate;
	private int paymentNo;
	private String paymentStatus;	
}
