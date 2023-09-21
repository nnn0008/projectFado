//package com.kh.springsemi.controller;
//
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import com.kh.springsemi.dao.MemberDao;
//import com.kh.springsemi.dao.ProjectCommunityDao;
//import com.kh.springsemi.dto.ProjectCommunityDto;
//
//@Controller
//@RequestMapping("/funding/community")
//public class ProjectCommunityController {
//
//	@Autowired
//	private ProjectCommunityDao projectCommunityDao;
//	
//	@Autowired
//	private MemberDao memberDao;
//	
//	
////	
////	@GetMapping("/")  //프로젝트 커뮤니티 글작성
////	public String insert() {
////		return"";
////	}
//	
//	
//	@PostMapping("/")
//	public String insert(@ModelAttribute ProjectCommunityDto projectCommunityDto, HttpSession session)
//	
//}
