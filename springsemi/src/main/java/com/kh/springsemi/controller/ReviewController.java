package com.kh.springsemi.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.ReviewDao;
import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.ReviewDto;

@Controller
@RequestMapping("review")
public class ReviewController {

	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private MemberDao memberDao;
	
	
	
	
	@GetMapping("/write")
	public String insert(@RequestParam int reviewNo, Model model) {
		model.addAttribute("reviewNo", reviewNo);
		return "/WEB-INF/views/review/write.jsp";
	}
	
//	@PostMapping("/write")
//	public String insert(@ModelAttribute ReviewDto reviewDto,
//						@ModelAttribute ProjectDto projectDto, HttpSession session) {
//		String memberId = (String)session.getAttribute("name");
//		
//		int reviewNo = reviewDao.sequence();
//		int projectNo = projectDto.getProjectNo();
//		
//	}
	
}
