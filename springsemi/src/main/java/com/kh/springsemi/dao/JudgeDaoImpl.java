package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.JudgeDto;
import com.kh.springsemi.mapper.JudgeMapper;

@Repository
public class JudgeDaoImpl implements JudgeDao{
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private JudgeMapper judgeMapper;

	//등록
	@Override
	public int sequence() {
		String sql = "select judge_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(JudgeDto judgeDto) {
		String sql = "insert into judge(judge_no, project_no) values(?, ?)";
		Object[] data = {judgeDto.getJudgeNo(), judgeDto.getProjectNo()};
		jdbcTemplate.update(sql, data);
	}
	
	//수정
	@Override
	public boolean update(JudgeDto judgeDto) {
		String sql = "update judge set judge_date = sysdate, judge_status = ? where judge_no = ?";
		Object[] data = {judgeDto.getJudgeStatus(), judgeDto.getJudgeNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public boolean updateByProjectNo(JudgeDto judgeDto) {
		String sql = "update judge set judge_date = sysdate, judge_status = ? where project_no = ?";
		Object[] data = {judgeDto.getJudgeStatus(), judgeDto.getProjectNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//삭제
	@Override
	public boolean delete(int judgeNo) {
		String sql = "delete judge where judge_no = ?";
		Object[] data = {judgeNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//목록
	@Override
	public List<JudgeDto> selectList() {
		String sql = "select * from judge order by judge_no desc";
		return jdbcTemplate.query(sql, judgeMapper);
	}
	
	//상세
	@Override
	public JudgeDto selectOne(int judgeNo) {
		String sql = "select * from judge where judge_no = ?";
		Object[] data = {judgeNo};
		List<JudgeDto> list = jdbcTemplate.query(sql, judgeMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	@Override
	public JudgeDto selectOneByProjectNo(int projectNo) {
		String sql = "select * from judge where project_no = ?";
		Object[] data = {projectNo};
		List<JudgeDto> list = jdbcTemplate.query(sql, judgeMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
}
