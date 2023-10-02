 package com.kh.springsemi.controller;

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
import com.kh.springsemi.vo.PaginationVO;

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
			@ModelAttribute JudgeDto judgeDto, Model model) {
		int projectNo = projectDao.sequence();
		int judgeNo = judgeDao.sequence();
		projectDto.setProjectNo(projectNo);
		String memberId = (String)session.getAttribute("name");
		projectDto.setProjectOwner(memberId);
		projectDao.insert(projectDto);
		
		judgeDto.setProjectNo(projectNo);
		judgeDto.setJudgeNo(judgeNo);
		judgeDao.insert(judgeDto);
		//프로젝트의 이미지 번호를 찾아서 넘겨준다
		model.addAttribute("projectNo", projectDao.findPhoto(projectNo));
		return "redirect:detail?projectNo="+projectNo;
	}
	
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int projectNo, HttpSession session, Model model) {
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		model.addAttribute("projectDto", projectDto);
		
		MinorCategoryDto minorCategoryDto = minorCategoryDao.selectOne(projectDto.getMinorCategoryNo());
		model.addAttribute("minorCategoryDto", minorCategoryDto);
		MajorCategoryDto majorCategoryDto = majorCategoryDao.selectOne(minorCategoryDto.getMajorCategoryNo());
		model.addAttribute("majorCategoryDto", majorCategoryDto);
		
		Date currentTime = new Date();
		Date endTime = projectDto.getProjectEndDate();
//		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd H:mm:ss");
		long difference = endTime.getTime() - currentTime.getTime();
//		String d = fmt.format(difference);
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
	//페이징 관련 처리
	@RequestMapping("/list")
	public String list(Model model, @RequestParam(required = false) String keyword
			,@RequestParam(required = false, defaultValue="1") int page) {
		boolean isSearch = keyword != null;
		
		//페이징과 관련된 값들을 계산하여 JSP로 전달 
		int begin = (page - 1) / 10 * 10 + 1;
		int end = begin + 9;
		int count = isSearch ? projectDao.countList(keyword) : projectDao.countList(); //목록 개수 or 검색 결과 수를 모름
		int pageCount = (count - 1) / 10 * 1 + 1;
		model.addAttribute("page", page);
		model.addAttribute("begin", begin);
		model.addAttribute("end", Math.min(pageCount, end)); //둘 중에 작은 값이 페이지의 마지막이 되어야 한다
		model.addAttribute("pageCount", pageCount);
				
		if(isSearch) { //검색이라면
			//List<ProjectListDto> projectList = projectDao.selectList(keyword);
			List<ProjectListDto> projectList = projectDao.selectListByPage(keyword, page);
			model.addAttribute("projectList", projectList);
			model.addAttribute("isSearch", true);
		}
		else { //목록이라면
//			List<ProjectListDto> projectList = projectDao.selectList();
			List<ProjectListDto> projectList = projectDao.selectListByPage(page);
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
//	
	
}
