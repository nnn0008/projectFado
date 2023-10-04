package com.kh.springsemi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springsemi.dao.AttachDao;
import com.kh.springsemi.dao.MajorCategoryDao;
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dao.ProjectPhotoDao;
import com.kh.springsemi.dto.MajorCategoryDto;
import com.kh.springsemi.dto.ProjectListAttachDto;
import com.kh.springsemi.dto.ProjectListDto;

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
	public String home(Model model) {
		List<ProjectListAttachDto> readCountList = projectDao.selectListByReadCountTop8();
		List<ProjectListAttachDto> likeCountList = projectDao.selectListByLikeCount();
		List<ProjectListAttachDto> achievementList = projectDao.selectListByAchievementRateTop8();
		List<MajorCategoryDto> noSearch = majorCategoryDao.selectList();
		model.addAttribute("noSearch", noSearch);
		model.addAttribute("readCountList", readCountList);
		model.addAttribute("likeCountList", likeCountList);
		model.addAttribute("achievementList", achievementList);
		return "/WEB-INF/views/home.jsp";
	}
	
	@PostMapping("/")
	public String majorCategoryList(@RequestParam int majorCategoryNo, Model model) {
		List<MajorCategoryDto> search = majorCategoryDao.selectListByMajorCategoryNo(majorCategoryNo);
		model.addAttribute("search", search);
		return "/WEB-INF/views/project/list.jsp";
	}
	
}
