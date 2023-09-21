package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.DeliveryDto;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.mapper.DeliveryMapper;
import com.kh.springsemi.mapper.MemberMapper;
import com.kh.springsemi.vo.PaginationVO;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MemberMapper memberMapper;
	
	// 회원
	
	//회원가입
	@Override
	public void insert(MemberDto memberDto) {
		String sql = "insert into member("
				+ "member_id, member_pw, member_nickname, member_birth, "
				+ "member_contact, member_email"
				+ ") values (?, ?, ?, ?, ?, ?)";
		
		Object[] data = {
				memberDto.getMemberId(), memberDto.getMemberPw(),
				memberDto.getMemberNickname(), memberDto.getMemberBirth(),
				memberDto.getMemberContact(), memberDto.getMemberEmail(),
		};
		jdbcTemplate.update(sql, data);
	}

	//회원상세
	@Override
	public MemberDto selectOne(String memberId) {
		String sql = "select * from member where member_id = ?";
		Object[] data = {memberId};
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	//회원비밀번호변경
	@Override
	public boolean updateMemberPw(String memberId, String changePw) {
			String sql = "update member "
					+ "set member_pw=? "
					+ "where member_id=?";
			Object[] data = {changePw, memberId};
			return jdbcTemplate.update(sql, data) > 0;
	}

	//회원개인정보변경
	@Override
	public boolean updateMemberInfo(MemberDto memberDto) {
		String sql = "update member set "
				+ "member_nickname=?, member_birth=?, member_contact=?, member_email=? "
				+ "where member_id=?";
		Object[] data = {
				memberDto.getMemberNickname(), memberDto.getMemberBirth(),
				memberDto.getMemberContact(), memberDto.getMemberEmail(),
				memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}

	//회원탈퇴
	@Override
	public boolean delete(String memberId) {
		String sql = "delete member where member_id=?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql,data) > 0;
	}


	//배송지
	//배송지번호 시퀀스
	@Override
	public int sequence() {
		String sql = "select delivery_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(DeliveryDto deliveryDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public DeliveryDto selectOne(int deliveryNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean updateAddress(DeliveryDto deliveryDto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(int deliveryNo) {
		// TODO Auto-generated method stub
		return false;
	}
	
	@Override
	public int countList(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from member "
					+ "where instr("+vo.getType()+", ?) > 0 "
							+ "and member_level != '관리자'";
			Object[] data = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {
			String sql = "select count(*) from member "
					+ "where member_level != '관리자'";
			return jdbcTemplate.queryForObject(sql,int.class);
		}
	}
	@Override
	public List<MemberDto> selectListByPage(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "seleect * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from member "
					+ "where instr("+vo.getType()+", ?) > 0 "
					+ "and member_level != '관리자' "
					+ "order by "+vo.getType()+ "asc "
					+ ")TMP "
					+ ") where rn between ? and ?";
			Object[] data = {vo.getKeyword(),vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, memberMapper, data);
		}
		else {
			String sql = "select * from ( "
					+ "select rownum rn , TMP.* from( "
					+ "select * from member "
					+ "where member_level != '관리자' "
					+ "order by member_id asc"
					+ ")TMP"
					+ ") where rn between ? and ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, memberMapper, data);			
		}
	}
	
//	차단+해제 기능 
	@Override
	public void insertBlock(String memberId) {
		String sql = "insert into member_block (member_id) values(?)";
		Object[] data = {memberId};
		jdbcTemplate.update(sql,data);
	}
	
	@Override
	public boolean deleteBlock(String memberId) {
		String sql = "delete member_block where member_id =?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql,data) > 0;
		
	}
}
