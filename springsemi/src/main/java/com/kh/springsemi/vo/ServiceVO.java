package com.kh.springsemi.vo;

import lombok.Data;

@Data
public class ServiceVO {
	private String memberId;
	private int memberPoint;
	private int ordersNo;
	private int ordersPrice;
	private String ordersStatus;
}
