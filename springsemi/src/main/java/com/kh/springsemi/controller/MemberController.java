package com.kh.springsemi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dto.MemberDto;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired MemberDao memberDao;
	
	//회원가입
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	
	@PostMapping("/join") 
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.insert(memberDto);
		return "redirect:joinFinish";
	}
	
	//회원가입 완료 페이지
	@RequestMapping("/joinFinish") 
	public String joinFinish() {
		return "/WEB-INF/views/member/joinFinish.jsp";
	}
	
	//회원 로그인 페이지
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}
	
//	@PostMapping("/login")
	
	
}
