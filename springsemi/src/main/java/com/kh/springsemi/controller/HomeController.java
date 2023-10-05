package com.kh.springsemi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springsemi.dao.AttachDao;
import com.kh.springsemi.dao.MajorCategoryDao;
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dao.ProjectPhotoDao;
import com.kh.springsemi.dto.MajorCategoryDto;
import com.kh.springsemi.dto.ProjectListAttachDto;
import com.kh.springsemi.vo.PaginationListVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class HomeController {
	@Autowired
	private ProjectDao projectDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MajorCategoryDao majorCategoryDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private ProjectPhotoDao projectPhotoDao;
	
	@GetMapping("/")
	public String home(Model model, @ModelAttribute(name="vo")PaginationListVO vo) {
		int count = projectDao.countList(vo);
		vo.setCount(count);
		log.debug(String.valueOf(count));
		
		List<ProjectListAttachDto> likeCountList = projectDao.selectListByLikeCount(vo);
		List<ProjectListAttachDto> readCountList = projectDao.selectListByReadCount(vo);
		List<ProjectListAttachDto> achievementList = projectDao.selectListByAchievementRate(vo);
		List<MajorCategoryDto> noSearch = majorCategoryDao.selectList();
		
		model.addAttribute("likeCountList", likeCountList);
		model.addAttribute("readCountList", readCountList);
		model.addAttribute("achievementList", achievementList);
		model.addAttribute("noSearch", noSearch);
		return "/WEB-INF/views/home.jsp";
	}
	
	@PostMapping("/")
	public String majorCategoryList(@RequestParam int majorCategoryNo, Model model) {
		List<MajorCategoryDto> search = majorCategoryDao.selectListByMajorCategoryNo(majorCategoryNo);
		model.addAttribute("search", search);
		return "/WEB-INF/views/project/list.jsp";
	}
	@RequestMapping("/main")
	public String mainhome() {
		System.out.println("mainhome");
		return "/WEB-INF/views/mainhome.jsp";
}
}
