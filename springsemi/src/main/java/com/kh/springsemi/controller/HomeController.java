package com.kh.springsemi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.springsemi.dao.AttachDao;
import com.kh.springsemi.dao.MajorCategoryDao;
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dao.ProjectPhotoDao;
import com.kh.springsemi.dto.AttachDto;
import com.kh.springsemi.dto.ProjectListDto;
import com.kh.springsemi.dto.ProjectPhotoDto;

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
		List<ProjectListDto> readCountList = projectDao.selectListByReadCountTop8();
		List<ProjectListDto> likeCountList = projectDao.selectListByLikeCountTop8();
		List<ProjectListDto> achievementList = projectDao.selectListByAchievementRateTop8();
		model.addAttribute("readCountList", readCountList);
		model.addAttribute("likeCountList", likeCountList);
		model.addAttribute("achievementList", achievementList);
		return "/WEB-INF/views/home.jsp";
	}
	
}
