package com.kh.springsemi.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.RewardDto;

@Repository
public class RewardDaoImpl implements RewardDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public int sequence() {
		String sql = "select reward_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(RewardDto rewardDto) {
		String sql = "insert into reward(reward_name, reward_type, reward_price)"
							+ " values(?, ?, ?)";
		Object[] data = {rewardDto.getRewardName(), rewardDto.getRewardType(),
								rewardDto.getRewardPrice()};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean updateInfo(RewardDto rewardDto) {
		String sql = "update reward set reward_name=?, reward_type=?, reward_price=? "
							+ "where reward_no=?";
		Object[] data = {rewardDto.getRewardName(), rewardDto.getRewardType(),
								rewardDto.getRewardPrice(), rewardDto.getRewardNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public boolean delete(int rewardNo) {
		String sql = "delete reward where reward_no=?";
		Object[] data = {rewardNo};
		return jdbcTemplate.update(sql, data) > 0;
	}

}
