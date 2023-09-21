package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.ProjectListDto;
//일단 만들어 두긴 했는데 쓸지 잘 모르겠음
@Component
public class ProjectListMapper implements RowMapper<ProjectListDto>{
@Override
public ProjectListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
	return null;
}
}
