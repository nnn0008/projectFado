package com.kh.springsemi.dao;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.ProjectListAttachDto;
import com.kh.springsemi.dto.ProjectListDto;
import com.kh.springsemi.mapper.ProjectListAttachMapper;
import com.kh.springsemi.mapper.ProjectListMapper;
import com.kh.springsemi.mapper.ProjectMapper;
import com.kh.springsemi.mapper.ServiceVOMapper;
import com.kh.springsemi.vo.PaginationListVO;
import com.kh.springsemi.vo.ServiceVO;

@Repository
public class ProjectDaoImpl implements ProjectDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ProjectMapper projectMapper;
	
	@Autowired
	private ProjectListMapper projectListMapper;
	
	@Autowired
	private JudgeDao judgeDao;
	
	@Autowired
	private ProjectListAttachMapper projectListAttachMapper;
	
	//프로젝트 등록(판매자가)
	@Override
	public int sequence() {
		String sql = "select project_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(ProjectDto projectDto) {
		Date endDate = projectDto.getCalculateEndDate();
		projectDto.setProjectEndDate(endDate);
//		int minorNo = minorCategoryDto.getMinorCategoryNo();
//		projectDto.setMinorCategoryNo(minorNo);
		String sql = "insert into project(project_no, project_title, project_goal_price, project_start_date, "
				+ "project_owner, project_end_date, project_period, minor_category_no) values(?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {projectDto.getProjectNo(), projectDto.getProjectTitle(), projectDto.getProjectGoalPrice(),
				projectDto.getProjectStartDate(), projectDto.getProjectOwner(), 
				endDate, projectDto.getProjectPeriod(), projectDto.getMinorCategoryNo()};
		 
		jdbcTemplate.update(sql, data);
	}
	
	//프로젝트 삭제(판매자가)
	@Override
	public boolean delete(int projectNo) {
		String sql = "delete project where project_no = ?";
		Object[] data = {projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//프로젝트 수정(관리자, 판매자)
	@Override
	public boolean update(ProjectDto projectDto) {
		String sql = "update project set project_title = ?, project_goal_price = ?, project_start_date = ?, project_end_date = ?, "
				+ "where project_no = ?";
		Object[] data = {projectDto.getProjectTitle(), projectDto.getProjectGoalPrice(), projectDto.getProjectStartDate(), projectDto.getProjectEndDate(),
				projectDto.getProjectNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//프로젝트 상세(모든 회원, 비회원)
	@Override
	public ProjectDto selectOne(int projectNo) {
		String sql = "select * from project where project_no = ?";
		Object[] data = {projectNo}; 
		List<ProjectDto> list = jdbcTemplate.query(sql, projectMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	@Override
	public ProjectListDto selectOneByProjectList(int projectNo) {
		String sql = "select * from project_list where project_no = ?";
		Object[] data = {projectNo};
		List<ProjectListDto> list = jdbcTemplate.query(sql, projectListMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public boolean updateProjectReadcount(int projectNo) {
		String sql = "update project set project_readcount = project_readcount + 1 where project_no=?";
		Object[] data = {projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}	
	
	@Override
	public boolean plusProjectLikecount(int projectNo) {
		String sql = "update project set project_likecount = project_likecount + 1 where project_no=?";
		Object[] data = {projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public boolean plusProjectTotalPrice(int ordersPrice, int projectNo) {
		String sql = "update project set project_total_price = project_total_price + ? where project_no = ?";
		Object[] data = {ordersPrice, projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
//	@Override
//	public List<ProjectListAttachDto> selectList() {
//		String sql = "select * from project_list order by project_no desc";
//		return jdbcTemplate.query(sql, projectListAttachMapper);
//	}

	@Override
	public List<ProjectListAttachDto> selectListByPageByAttach(int page) {
		int begin = page * 10 - 9;
		int end = page * 10;
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select * from project_list_attach "
								+ "order by project_no desc"
							+ ") TMP"
						+ ") where rn between ? and ?";
		Object[] data = {begin, end};
		return jdbcTemplate.query(sql, projectListAttachMapper, data);
	}
	
	@Override
	public List<ProjectListAttachDto> selectListByPageByAttach(String keyword, int page) {
		int begin = page * 10 - 9;
		int end = page * 10;
		String sql = "select * from("
							+ "select rownum rn, TMP.* from( "
								+ "select * from project_list_attach "
								+ "where "
								+ "instr(minor_category_type, ?) > 0 or "
								+ "instr(project_owner, ?) > 0 or "
								+ "instr(project_title, ?) > 0 or "
								+ "instr(major_category_type, ?) > 0 "
								+ "order by project_no desc"
							+ ")TMP"
						+ ") where rn between ? and ?";
		Object[] data = {keyword, keyword, keyword, keyword, begin, end};
		return jdbcTemplate.query(sql, projectListAttachMapper, data);
	}
	@Override
	public List<ProjectListDto> selectList() {
		String sql = "select * from project_list order by project_no desc";
		return jdbcTemplate.query(sql, projectListMapper);
	}
	
	@Override
	public List<ProjectListDto> selectListByPage(int page) {
		int begin = page * 10 - 9;
		int end = page * 10;
		String sql = "select * from("
								+ "select rownum rn, TMP.* from("
									+	"select * from project_list_attach "
									+ "order by project_no desc"
								+ ")TMP"
							+ ") where rn between ? and ? ";
		Object[] data = {begin, end};
		return jdbcTemplate.query(sql, projectListMapper, data);
	}
	
	@Override
	public List<ProjectListDto> selectListByPage(String keyword, int page) {
		int begin = page * 10 - 9;
		int end = page * 10;
		String sql = "select * from("
				+ "select rownum rn, TMP.* from("
					+	"select * from project_list where "
					+ "instr(minor_category_type, ?) > 0 or "
					+ "instr(project_owner, ?) > 0 or "
					+ "instr(project_title, ?) > 0 or "
					+ "instr(major_category_type, ?) > 0 "
					+ "order by project_no desc"
				+ ")TMP"
			+ ") where rn between ? and ?";
		Object[] data = {keyword, keyword, keyword, keyword, begin, end};
		return jdbcTemplate.query(sql, projectListMapper, data);
	}
	
	@Override
	public List<ProjectListAttachDto> selectList(String keyword) {
		String sql = "select * from project_list where "
				+ "instr(minor_category_type, ?) > 0 or "
				+ "instr(project_owner, ?) > 0 or "
				+ "instr(project_title, ?) > 0 or "
				+ "instr(major_category_type, ?) > 0 "
				+ "order by project_no desc";
		Object[] data = {keyword, keyword, keyword, keyword};
		return jdbcTemplate.query(sql, projectListAttachMapper, data);
	}
	
	@Override
	public int countList() {
		String sql = "select count (*) from project_list";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public int countList(String keyword) {
		String sql = "select count(*) from project_list where "
				+ "instr(minor_category_type, ?) > 0 or "
				+ "instr(project_owner, ?) > 0 or "
				+ "instr(project_title, ?) > 0 or "
				+ "instr(major_category_type, ?) > 0";
		Object[] data = {keyword, keyword, keyword, keyword};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}

	public boolean minusProjectLikecount(int projectNo) {
		String sql = "update project set project_likecount = project_likecount - 1 where project_no=?";
		Object[] data = {projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//프로필 관련 기능
	@Override
	public void insertPhoto(int projectNo, int attachNo) {
		String sql = "insert into project_photo values(?, ?)";
		Object[] data = {projectNo, attachNo};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public boolean deletePhoto(int projectNo) {
		String sql = "delete project_photo where project_no = ?";
		Object[] data = {projectNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public Integer findPhoto(int projectNo) {
		String sql = "select attach_no from project_photo where project_no = ?";
		Object[] data = {projectNo};
		return jdbcTemplate.queryForObject(sql, Integer.class, data);
	}
	
	//카테고리 별
	@Override
	public List<ProjectListDto> selectListByMajorCategory(String majorCategory) {
		String sql = "select * from project_list where major_category = ? order by project_no desc";
		Object[] data = {majorCategory}; 
		return jdbcTemplate.query(sql, projectListMapper, data);
	}
	
	@Override
	public int countList(PaginationListVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from project_list where instr(major_category_type, ?) > 0";
			Object[] data = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {
			String sql = "select count(*) from project_list";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	//조회수
	@Override
	public List<ProjectListAttachDto> selectListByReadCount(PaginationListVO vo) {
		String sql = "select * from("
				+ "	select rownum rn, TMP.* from("
				+ "			select * from project_list pl "
				+ "			left outer join project_photo pp on pl.project_no = pp.project_no "
				+ "			order by project_readcount desc"
				+ "	)TMP"
				+ ") where rn between ? and ?";
		return jdbcTemplate.query(sql, projectListAttachMapper, vo.getStartRow(), vo.getFinishRow());
	}
	
	//좋아요
	@Override
	public List<ProjectListAttachDto> selectListByLikeCount(PaginationListVO vo) {
//		int begin = vo.getPage() * 10 - 9;
//		int end = vo.getPage() * 10;
		String sql = "select * from("
						+ "	select rownum rn, TMP.* from("
						+ "			select * from project_list pl "
						+ "			left outer join project_photo pp on pl.project_no = pp.project_no "
						+ "			order by project_likecount desc"
						+ "	)TMP"
						+ ") where rn between ? and ?";
//		Object[] data = {begin, end};
		return jdbcTemplate.query(sql, projectListAttachMapper, vo.getStartRow(), vo.getFinishRow());
	}
	
	//달성률 순서
	@Override
	public List<ProjectListAttachDto> selectListByAchievementRate(PaginationListVO vo) {
		String sql = "select * from("
				+ "	select rownum rn, TMP.* from("
				+ "			select * from project_list pl "
				+ "			left outer join project_photo pp on pl.project_no = pp.project_no "
				+ "			order by achievement_rate desc"
				+ "	)TMP"
				+ ") where rn between ? and ?";
		return jdbcTemplate.query(sql, projectListAttachMapper, vo.getStartRow(), vo.getFinishRow());
	}

	@Override
	public List<ProjectListAttachDto> selectList(PaginationListVO vo) {
		String sql = "select * from("
				+ "	select rownum rn, TMP.* from("
				+ "			select * from project_list pl "
				+ "			left outer join project_photo pp on pl.project_no = pp.project_no "
				+ "	)TMP"
				+ ") where rn between ? and ?";
		return jdbcTemplate.query(sql, projectListAttachMapper, vo.getStartRow(), vo.getFinishRow());
	}
	
}
