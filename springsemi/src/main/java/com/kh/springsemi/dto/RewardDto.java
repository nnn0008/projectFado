package com.kh.springsemi.dto;

import lombok.Data;

@Data
public class RewardDto {
	private int rewardNo;
	private int projectNo;
	private String rewardName;
	private int rewardType;
	private int rewardPrice;
}
