package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.MemberFollowDto;
import com.kh.springsemi.mapper.MemberFollowMapper;
import com.kh.springsemi.mapper.MemberMapper;

@Repository
public class MemberFollowDaoImpl implements MemberFollowDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MemberFollowMapper memberFollowMapper;
	
	@Autowired
	private MemberMapper memberMapper;

	@Override
	public void insert(MemberFollowDto memberFollowDto) {
		String sql = "insert into follow(follower_id, followee_id) values(?, ?)";
		Object[] data = {memberFollowDto.getFollowerId(), memberFollowDto.getFolloweeId()};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean delete(MemberFollowDto memberFollowDto) {
		String sql = "delete follow where follower_id = ? and followee_id = ?";
		Object[] data = {memberFollowDto.getFollowerId(), memberFollowDto.getFolloweeId()};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public boolean check(MemberFollowDto memberFollowDto) {
		String sql = "select * from follow where follower_id = ? and followee_id = ?";
		Object[] data = {memberFollowDto.getFollowerId(), memberFollowDto.getFolloweeId()};
		List<MemberFollowDto> list = jdbcTemplate.query(sql, memberFollowMapper, data);
		return list.isEmpty() ? false : true;
	}

	@Override
	public int count(String followeeId) {
		String sql ="select count(*) from follow where followee_id = ?";
		Object[] data = {followeeId};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}

	@Override
	public List<MemberDto> findByFollowerId(String followerId) {
		String sql = "select member.* "
						+ "from follow left outer join member "
						+ "on follow.followee_id = member.member_id "
						+ "where follow.follower_id = ? "
						+ "order by member.member_id desc";
		Object[] data = {followerId};
		return jdbcTemplate.query(sql, memberMapper, data);
	}
}
