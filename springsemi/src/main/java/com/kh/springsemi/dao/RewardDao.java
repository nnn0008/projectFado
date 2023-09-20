package com.kh.springsemi.dao;

import com.kh.springsemi.dto.RewardDto;

public interface RewardDao {
	int sequence();
	void insert(RewardDto rewardDto);
	boolean updateInfo(RewardDto rewardDto);
	boolean delete(int rewardNo);
}