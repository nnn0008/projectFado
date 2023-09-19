package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.kh.springsemi.dto.RewardDto;

public class RewardMapper implements RowMapper<RewardDto> {
	@Override
	public RewardDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		RewardDto rewardDto = new RewardDto();
		rewardDto.setRewardNo(rs.getInt("reward_no"));
		rewardDto.setProjectNo(rs.getInt("project_no"));
		rewardDto.setRewardName(rs.getString("reward_name"));
		rewardDto.setRewardType(rs.getInt("reward_type"));
		rewardDto.setRewardPrice(rs.getInt("reward_price"));
		rewardDto.setRewardContent(rs.getString("reward_content"));
		return null;
	}
}
