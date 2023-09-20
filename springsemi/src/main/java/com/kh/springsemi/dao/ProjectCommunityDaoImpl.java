package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.ProjectCommunityDto;
import com.kh.springsemi.mapper.ProjectCommunityMapper;
import com.kh.springsemi.vo.PaginationVO;

@Repository
public class ProjectCommunityDaoImpl implements ProjectCommunityDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ProjectCommunityMapper projectCommunityMapper; 
	
	
	
	@Override
	public int sequence() {  //프로젝트 커뮤니티 시퀀스 등록 
		String sql = "select project_community_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(ProjectCommunityDto projectCommunityDto) {  //프로젝트 커뮤니티 등록
		String sql = "insert into project_community("
				+ "project_community_no, project_community_writer, project_community_title, "
				+ "project_community_content, project_community_type) values(?, ?, ?, ?, ?)";
		Object[] data = {
				projectCommunityDto.getProjectCommunityNo(), projectCommunityDto.getProjectCommunityWriter(),
				projectCommunityDto.getProjectCommunityTitle(), projectCommunityDto.getProjectCommunityContent(),
				projectCommunityDto.getProjectCommunityType()
		};
				jdbcTemplate.update(sql,data);
	}
	
	
	@Override
	public List<ProjectCommunityDto> selectList(PaginationVO vo) {  //프로젝트 커뮤니티 목록 페이지
		if(vo.isSearch()) {
			String sql = "select * from(select rownum rn, TMP.* from ("
					+ "select * from project_community_list where instr("+vo.getType()+", ?) > 0 "
							+ "order by " +vo.getType()+" asc)TMP) where rn between ? and ?)";
			Object[] data = {vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, projectCommunityMapper, data);
		}
		else {
			String sql = "select * from(select rownum rn, TMP.* from ("
					+ "select * from project_community_list "
					+ "order by project_community_no asc)TMP) "
					+ "where rn between ? and ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, projectCommunityMapper, data);
		}
	}
	
	
	@Override
	public ProjectCommunityDto selectOne(int projectCommunityNo) { //프로젝트 커뮤니티 상세
		String sql = "select * from project_community where project_community_no=?";
		Object[] data = {projectCommunityNo};
		List<ProjectCommunityDto> list = jdbcTemplate.query(sql, projectCommunityMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}



	@Override
	public boolean update(ProjectCommunityDto projectCommunityDto) {  //프로젝트 커뮤니티 수정
		String sql = "update project_community set project_community_title=?, "
				+ "project_community_content=? where project_community_no=?";
		Object[] data = {projectCommunityDto.getProjectCommunityTitle(), projectCommunityDto.getProjectCommunityContent()};
		return jdbcTemplate.update(sql, data) > 0;
	}

	
	@Override
	public boolean delete(int projectCommunityNo) {  //프로젝트 커뮤니티 삭제
		String sql = "delete project_community where project_community_no=?";
		Object[] data = {projectCommunityNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
}
