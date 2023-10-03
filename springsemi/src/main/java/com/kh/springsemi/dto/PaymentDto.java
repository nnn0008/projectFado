package com.kh.springsemi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class PaymentDto {
	private int paymentNo;
	private int ordersNo;
	private String paymentStatus;
	private Date paymentDate;
}
