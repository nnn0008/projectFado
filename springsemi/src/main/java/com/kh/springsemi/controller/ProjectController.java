 package com.kh.springsemi.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springsemi.dao.JudgeDao;
import com.kh.springsemi.dao.MajorCategoryDao;
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.MinorCategoryDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dto.JudgeDto;
import com.kh.springsemi.dto.MajorCategoryDto;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.MemberFollowDto;
import com.kh.springsemi.dto.MinorCategoryDto;
import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.ProjectListDto;
import com.kh.springsemi.error.AuthorityException;
import com.kh.springsemi.error.NoTargetException;
import com.kh.springsemi.mapper.JudgeMapper;

@Controller
@RequestMapping("/project")
public class ProjectController {
	
	@Autowired
	private ProjectDao projectDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MajorCategoryDao majorCategoryDao;
	
	@Autowired
	private MinorCategoryDao minorCategoryDao;
	
	@Autowired
	private JudgeDao judgeDao;
	
	@Autowired
	private JudgeMapper judgeMapper;
	
	//프로젝트 등록
	@GetMapping("/write")
	public String write(Model majorModel, Model minorModel) {
		List<MajorCategoryDto> majorList = majorCategoryDao.selectList();
		majorModel.addAttribute("majorList", majorList);
		List<MinorCategoryDto> minorList = minorCategoryDao.selectList();
		minorModel.addAttribute("minorList", minorList);
		return "/WEB-INF/views/project/write.jsp";
	}

	@PostMapping("/write")
	public String write(@ModelAttribute ProjectDto projectDto, HttpSession session,
			@ModelAttribute JudgeDto judgeDto) {
		int projectNo = projectDao.sequence();
		int judgeNo = judgeDao.sequence();
		projectDto.setProjectNo(projectNo);
		String memberId = (String)session.getAttribute("name");
		projectDto.setProjectOwner(memberId);
		projectDao.insert(projectDto);
		
		judgeDto.setProjectNo(projectNo);
		judgeDto.setJudgeNo(judgeNo);
		judgeDao.insert(judgeDto);
		return "redirect:detail?projectNo="+projectNo;
	}
	
	
	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam int projectNo, HttpSession session) {
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		model.addAttribute("projectDto", projectDto);
//		String memberId = (String)session.getAttribute("name");
//		memberDto.setMemberId(memberId);
//		memberDao.selectOneByFollowerId(memberId);
//		model.addAttribute("memberFollowDto", memberFollowDto);
		
		MinorCategoryDto minorCategoryDto = minorCategoryDao.selectOne(projectDto.getMinorCategoryNo());
		model.addAttribute("minorCategoryDto", minorCategoryDto);
		MajorCategoryDto majorCategoryDto = majorCategoryDao.selectOne(minorCategoryDto.getMajorCategoryNo());
		model.addAttribute("majorCategoryDto", majorCategoryDto);
		
		Date currentTime = new Date();
		Date endTime = projectDto.getProjectEndDate();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd H:mm:ss");
		long difference = endTime.getTime() - currentTime.getTime();
		String d = fmt.format(difference);
		model.addAttribute("difference", difference);
		
		String projectOwner = projectDto.getProjectOwner();
		if(projectOwner != null) {
			MemberDto memberDto = memberDao.selectOne(projectOwner);
			model.addAttribute("OwnerDto", memberDto);
		}
		
		return "/WEB-INF/views/project/detail.jsp";
	}
	

//	@RequestMapping("/list")
//	public String list(Model model) {
//		List<ProjectListDto> projectList = projectDao.selectList();
//		model.addAttribute("projectList", projectList);;
//		
//		return "/WEB-INF/views/project/list.jsp";
//	}
	
	//목록+검색(keyword의 차이) 
	@RequestMapping("/list")
	public String list(Model model, @RequestParam(required = false) String keyword) {
		boolean isSearch = keyword != null;
		if(isSearch) { //검색이라면
			List<ProjectListDto> projectList = projectDao.selectList(keyword);
			model.addAttribute("projectList", projectList);
			model.addAttribute("isSearch", true);
		}
		else { //목록이라면
			List<ProjectListDto> projectList = projectDao.selectList();
			model.addAttribute("projectList",projectList);
			model.addAttribute("isSearch", false);
		}
		return "/WEB-INF/views/project/list.jsp";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int projectNo, Model model) {
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		model.addAttribute("projectDto", projectDto);
		return "/WEB-INF/views/project/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute ProjectDto projectDto) {
		if(projectDao.update(projectDto)) {
			return "redirect:detail?projectNo=" + projectDto.getProjectNo();
		}
		else throw new NoTargetException("존재하지 않는 프로젝트 번호");
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int projectNo, HttpSession session) {
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		String memberId = (String) session.getAttribute("name");
		String projectOwner = projectDto.getProjectOwner();
		if(memberId.equals(projectOwner)) {
			projectDao.delete(projectNo);
			return "redirect:list";
		}
		else { 
			throw new AuthorityException("프로젝트 소유자가 아닙니다");
		}
	}
	
//	@RequestMapping("/list2")
//	public String list(@ModelAttribute(name = "vo") PaginationVO vo,
//									Model model) {
//		int count = projectDao.countList(vo);
//		vo.setCount(count);
//		model.addAttribute("vo", vo);
//		
//	List<ProjectDto> list = projectDao.selectListByPage(vo);
//	model.addAttribute("list", list);
//	
//	return "/WEB-INF/views/project/list2.jsp";
//}
	
	
}
