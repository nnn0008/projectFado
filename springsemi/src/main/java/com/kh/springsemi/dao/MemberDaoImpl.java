package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.DeliveryDto;
import com.kh.springsemi.dto.MemberBlockDto;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.MemberFollowDto;
import com.kh.springsemi.dto.MemberListDto;
import com.kh.springsemi.mapper.MemberBlockMapper;
import com.kh.springsemi.mapper.MemberFollowMapper;
import com.kh.springsemi.mapper.MemberListMapper;
import com.kh.springsemi.mapper.MemberMapper;
import com.kh.springsemi.vo.PaginationVO;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private MemberListMapper memberListMapper;
	
	@Autowired
	private MemberBlockMapper memberBlockMapper;
	
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
					+ "set member_pw=?, member_change_pw = sysdate "
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
	
	@Override
	public boolean updateMemberLogin(String memberId) {
		String sql = "update member set member_last_login = sysdate where member_id = ?";
		Object[] data = {memberId};
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
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	@Override
	public List<MemberDto> selectListByPage(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select * from member "
									+ "where instr("+vo.getType()+", ?) > 0 "
									+ "and member_level != '관리자' " 
									+ "order by "+vo.getType()+" asc"
								+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, memberMapper, data);
		}
		else {
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
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
	

//	관리자 회원수정  
	@Override
	public boolean updateMemberInfoByAdmin(MemberDto memberDto) {
		String sql = "update member set "
							+ "member_nickname = ?, "
							+ "member_contact = ?,"
							+ "member_email = ?, "
							+ "member_birth = ?, "
							+ "member_level = ?, "
							+ "member_point = ? "
						+ "where member_id = ?";
		Object[] data = {
			memberDto.getMemberNickname(), memberDto.getMemberContact(), 
			memberDto.getMemberEmail(), memberDto.getMemberBirth(), 
			memberDto.getMemberLevel(), memberDto.getMemberPoint(),
			memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public List<MemberListDto> selectListByPage2(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select * from member_list "
									+ "where instr("+vo.getType()+", ?) > 0 "
									+ "and member_level != '관리자' " 
									+ "order by "+vo.getType()+" asc"
								+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, memberListMapper, data);
		}
		else {
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
						+ "select * from member_list "
						+ "where member_level != '관리자' " 
						+ "order by member_id asc"
					+ ")TMP"
				+ ") where rn between ? and ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, memberListMapper, data);
			}
		
		}
	
	//회원 프로필 관련 기능
	//프로필 등록
	@Override
	public void insertProfile(String memberId, int attachNo) {
		String sql = "insert into member_profile values(?, ?)";
		Object[] data = {memberId, attachNo};
		jdbcTemplate.update(sql,data);
	}

	@Override
	public boolean deleteProfile(String memberId) {
		String sql = "delete member_profile where member_id=?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public Integer findProfile(String memberId) {
		String sql = "select attach_no from member_profile "
				+ "where member_id=?";
		Object[] data = {memberId};
		try {
			return jdbcTemplate.queryForObject(sql, Integer.class, data);
		} 
		catch(Exception e) {
			return null; //예외 발생 시 null로 대체하여 반환
		}
	}

	@Override
	public MemberDto selectOneByMemberNickname(String memberNickname) {
		String sql = "select * from member where member_nickname = ?";
		Object[] data = {memberNickname};
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//회원 팔로우 관련 기능
	
	@Autowired
	private MemberFollowMapper memberFollowMapper;

	@Override
	public void insertFollow(MemberFollowDto memberFollowDto) {
		String sql = "insert into follow(follower_id, followee_id) values(?, ?)";
		Object[] data = {memberFollowDto.getFollowerId(), memberFollowDto.getFolloweeId()};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean deleteFollow(MemberFollowDto memberFollowDto) {
		String sql = "delete follow where follower_id =? and followee_id = ?";
		Object[] data = {memberFollowDto.getFollowerId(), memberFollowDto.getFolloweeId()};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public boolean check(MemberFollowDto memberFollowDto) {
		String sql = "select * from follow_list where follower_id = ? and followee_id = ?";
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
	
	@Override
	public int countFollowList(PaginationVO vo) {
		String sql = "select count(*) from follow_list";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public List<MemberFollowDto> selectFollowListByPage(PaginationVO vo, String followerId) {
		String sql = "select * from (select rownum rn, TMP.* from (select * from follow_list where follower_id = ? order by follow_date desc)TMP) where rn between ? and ?";
		Object[] data = {followerId, vo.getStartRow(), vo.getFinishRow()};
		return jdbcTemplate.query(sql, memberFollowMapper, data);
	}
	
	@Override
	public List<MemberFollowDto> selectFollowingList(MemberFollowDto memberFollowDto) {
		String sql ="select * from follow_list where follower_id = ? and followee_id = ?";
		Object[] data = {memberFollowDto.getFollowerId(), memberFollowDto.getFolloweeId()};
		return jdbcTemplate.query(sql,  memberFollowMapper, data);
	}
	
	public MemberFollowDto selectOneByFollowerId(String followerId) {
		String sql = "select * from follow_list where follower_id = ?";
		Object[] data = {followerId};
		List<MemberFollowDto> list = jdbcTemplate.query(sql, memberFollowMapper, data);
		return list.isEmpty() ? null : list.get(0);
 	}
	
	@Override
	public boolean updateFollow(String followerId, String followeeId) {
		String sql ="select * from follow_list where follower_id = ? and followee_id = ?";
		Object[] data = {followerId, followeeId};                                             
		return jdbcTemplate.update(sql, data) > 0; 
	}
	
	@Override
	public List<MemberBlockDto> selectBlockList() {
		String sql = "select * from member_block order by block_time asc";
		return jdbcTemplate.query(sql, memberBlockMapper);
	}
	
	@Override
	public MemberBlockDto selectBlockOne(String memberId) {
		String sql = "select * from member_block where member_id = ?";
		Object[] data = {memberId};
		List<MemberBlockDto> list = 
					jdbcTemplate.query(sql, memberBlockMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
}
