package com.kh.springsemi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@RequestMapping("/")
	public String home() {
		return "/WEB-INF/views/admin/home.jsp";
		
//		
//	@RequestMapping("/member/list")
//	public String memberList() {
//		
//		return "/WEB-INF/views/admin/member/list.jsp";
//		
//	}
		
		
	}
}
