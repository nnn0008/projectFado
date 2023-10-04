package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.RewardDto;
import com.kh.springsemi.mapper.RewardMapper;

@Repository
public class RewardDaoImpl implements RewardDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private RewardMapper rewardMapper;
	
	@Override
	public int sequence() {
		String sql = "select reward_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(RewardDto rewardDto) {
		String sql = "insert into reward(reward_no, project_no, reward_type, reward_price) values(?, ?, ?, ?)";
		Object[] data = {rewardDto.getRewardNo(),rewardDto.getProjectNo() , rewardDto.getRewardType(), rewardDto.getRewardPrice()};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean updateInfo(RewardDto rewardDto) {
		String sql = "update reward set reward_type=?, reward_price=? where reward_no=?";
		Object[] data = { rewardDto.getRewardType(), rewardDto.getRewardPrice(), rewardDto.getRewardNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public boolean delete(int rewardNo) {
		String sql = "delete reward where reward_no=?";
		Object[] data = {rewardNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public List<RewardDto> selectListByProjectNo(int projectNo) {
		String sql = "select * from reward where project_no = ?";
		Object[] data = {projectNo};
		return jdbcTemplate.query(sql, rewardMapper, data);
	}
	
	@Override
	public RewardDto selectOne(int rewardNo) {
		String sql = "select * from reward where reward_no = ?";
		Object[] data = {rewardNo};
		List<RewardDto> list = jdbcTemplate.query(sql, rewardMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

}
