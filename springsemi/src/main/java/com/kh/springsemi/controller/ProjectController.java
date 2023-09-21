package com.kh.springsemi.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dto.ProjectDto;

@Controller
@RequestMapping("/project")
public class ProjectController {
	
	@Autowired
	ProjectDao projectDao;
	
	//프로젝트 등록
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/project/write.jsp";
	}
//	@PostMapping("/write")
//	public String write(@ModelAttribute ProjectDto projectDto, HttpSession session) {
//		int projectNo = projectDao.sequence();
//		projectDto.setProjectNo(projectNo);
//		String memberId = (String)session.getAttribute("name");
//		projectDto.setProjectOwner(memberId);
//		projectDao.insert(projectDto);
//		
//		return "redirect:writeFinish";
//	}
	@PostMapping("/write")
	public String write(@ModelAttribute ProjectDto projectDto, HttpSession session
									,Model model ) {
		int projectNo = projectDao.sequence();
		projectDto.setProjectNo(projectNo);
		String memberId = (String)session.getAttribute("name");
		projectDto.setProjectOwner(memberId);
		projectDao.insert(projectDto);
		
		return "redirect:writeFinish";
	}
	
	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam int projectNo) {
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		model.addAttribute("projectDto", projectDto);
		Date currentTime = new Date();
		Date endTime = projectDto.getProjectEndDate();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd H:mm:ss");
		long difference = endTime.getTime() - currentTime.getTime();
		model.addAttribute("difference", difference);
		
		return "/WEB-INF/views/project/detail.jsp";
	}
	
}
