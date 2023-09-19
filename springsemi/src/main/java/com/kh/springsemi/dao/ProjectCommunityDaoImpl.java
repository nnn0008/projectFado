package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.ProjectCommunityDto;
import com.kh.springsemi.mapper.ProjectCommunityMapper;

@Repository
public class ProjectCommunityDaoImpl {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ProjectCommunityMapper projectcommunityMapper; 
	
	
//	@Override
//	public void insert(ProjectCommunityDto projectCommunityDto) {
//		String sql = "insert into projectCommunity("
//				+ "projectCommunity_no "
//				+ "projectCommunity_title "
//				+ "projectCommunity_content "
//				+ "projectCommunity reg_date "
//				+ "projectCommunity_type "
//				+ "projectCommunity_reply)";
//		Object[] data = {
//				projectCommunityDto.getProjectCommunityNo(),
//				projectCommunityDto.getProjectCommunityTitle(),
//				projectCommunityDto.getProjectCommunityContent(),
//				projectCommunityDto.getProjectCommunityRegDate(),
//				projectCommunityDto.getProjectCommunityType(),
//				projectCommunityDto.getProjectCommunityReply(),		
//		};
//				jdbcTemplate.update(sql,data);
//	}
//	
//	@Override
//	public ProjectCommunityDto selectOne(int projectCommunityNo) {
//		String sql = "select * from projectCommunity where projectCommunity_no = ?";
//		Object[] data = {projectCommunityNo};
//		List<ProjectCommunityDto> list = jdbcTemplate.query(sql, projectcommunityMapper, data);
//		return list.isEmpty() ? null : list.get(0);
//	}
}
