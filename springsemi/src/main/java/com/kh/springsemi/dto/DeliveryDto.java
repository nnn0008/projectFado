package com.kh.springsemi.dto;

import lombok.Data;

@Data
public class DeliveryDto {
	private int deliveryNo;
	private String deliveryMember, deliveryReceiver, deliveryPost, deliveryAddr1, deliveryAddr2, deliveryContact;
}
