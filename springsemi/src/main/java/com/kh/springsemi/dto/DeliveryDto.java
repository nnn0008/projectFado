package com.kh.springsemi.dto;

import lombok.Data;

@Data
public class DeliveryDto {
	private int deliveryNo;
	private String deliveryMember, deliveryPost, deliveryAddr1, deliveryAddr2;
}
