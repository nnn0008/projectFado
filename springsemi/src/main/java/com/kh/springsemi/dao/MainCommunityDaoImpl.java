package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.MainCommunityDto;
import com.kh.springsemi.dto.MainCommunityListDto;
import com.kh.springsemi.mapper.MainCommunityListMapper;
import com.kh.springsemi.mapper.MainCommunityMapper;
import com.kh.springsemi.vo.CommunityPaginationVO;

@Repository
public class MainCommunityDaoImpl implements MainCommunityDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MainCommunityMapper mainCommunityMapper;
	
	@Autowired
	private MainCommunityListMapper mainCommunityListMapper;
	
	
	
	@Override
	public int sequence() {  //메인 커뮤니티 시퀀스 등록 
		String sql = "select main_community_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	

	@Override
	public void insert(MainCommunityDto mainCommunityDto) {  //메인 커뮤니티 등록
		String sql = "insert into main_community("
				+ "main_community_no, main_community_writer, main_community_title, "
				+ "main_community_content, main_community_type) "
				+ "values(?, ?, ?, ?, ?)";
		Object[] data = {
				mainCommunityDto.getMainCommunityNo(), mainCommunityDto.getMainCommunityWriter(),
				mainCommunityDto.getMainCommunityTitle(), mainCommunityDto.getMainCommunityContent(),
				mainCommunityDto.getMainCommunityType()
				};
		jdbcTemplate.update(sql, data);
	}


	@Override
	public List<MainCommunityListDto> selectNoticeList(CommunityPaginationVO vo) {  //메인 커뮤니티 목록 페이지
		if(vo.isSearch()) {  //검색할때
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from main_community_list "
						+ "where instr(main_community_title, ?) > 0 "
						+ "and main_community_type = '공지사항' "
					+ "order by main_community_no asc"
				+ ")TMP"
			+ ") where rn between ? and ?";
			Object[] data = {vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, mainCommunityListMapper, data);
		}
		else {  //검색 없이 목록
			String sql = "select * from (select rownum rn, TMP.* from ("
		            + "select * from main_community_list "
		            + "where main_community_type = '공지사항' " // 여기에 조건 추가
		            + "order by main_community_no desc) TMP) "
		            + "where rn between ? and ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, mainCommunityListMapper, data);
		}
	}
	
	
	@Override
	public List<MainCommunityListDto> selectQnAList(CommunityPaginationVO vo) {  //메인 커뮤니티 목록 페이지 qna
		if(vo.isSearch()) {  //검색할때
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from main_community_list "
						+ "where instr(main_community_title, ?) > 0 "
						+ "and main_community_type = 'Q&A' "
					+ "order by main_community_no asc"
				+ ")TMP"
			+ ") where rn between ? and ?";
			Object[] data = {vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, mainCommunityListMapper, data);
		}
		else {  //검색 없이 목록
			String sql = "select * from (select rownum rn, TMP.* from ("
		            + "select * from main_community_list "
		            + "where main_community_type = 'Q&A' " // 여기에 조건 추가
		            + "order by main_community_no desc) TMP) "
		            + "where rn between ? and ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, mainCommunityListMapper, data);
		}
	}
	
	
	
	
	
	@Override
	public MainCommunityDto selectOne(int mainCommunityNo) {  //상세 페이지
		String sql = "select * from main_community where main_community_no=?";
		Object[] data = {mainCommunityNo};
		List<MainCommunityDto> list = jdbcTemplate.query(sql, mainCommunityMapper, data); 
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public boolean update(MainCommunityDto mainCommunityDto) {  //메인 커뮤니티 수정
		String sql = "update main_community set main_community_title=?,"
				+ " main_community_content=? where main_community_no=?";
		Object[] data = {mainCommunityDto.getMainCommunityTitle(), mainCommunityDto.getMainCommunityContent(),
						mainCommunityDto.getMainCommunityNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public boolean delete(int mainCommunityNo) {  //메인 커뮤니티 삭제
		String sql = "delete main_community where main_community_no=?";
		Object[] data = {mainCommunityNo};
		return jdbcTemplate.update(sql, data) > 0;
	}




	@Override
	public int countNoticeList(CommunityPaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from main_community where instr(main_community_title, ?) > 0";
			Object[] data = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {
			String sql = "select count(*) from main_community where main_community_type = '공지사항'";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}


	@Override
	public int countQnAList(CommunityPaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from main_community where instr(main_community_title, ?) > 0";
			Object[] data = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		} 
		else {
			String sql = "select count(*) from main_community where main_community_type = 'Q&A'";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	


}
