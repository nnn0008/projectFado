package com.kh.springsemi.controller;

import javax.servlet.http.HttpSession;

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
	
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto inputDto, HttpSession session) {
		MemberDto findDto = memberDao.selectOne(inputDto.getMemberId());
		
		if(findDto == null) { 
			return "redirect:login?error";
		}
		
		boolean isCorrectPw = inputDto.getMemberPw().equals(findDto.getMemberPw());
		if(isCorrectPw) {
			//차단된 회원이라면 작업 중지 후 오류 발생
//			MemberBlockDto blockDto = memberDao.selectBlockOne(findDto.getMemberId()); //차단된 회원
//			if (blockDto != null) {
//				//return "redirect:오류페이지";
//				throw new AuthorityException("차단된 회원");
//			}
			session.setAttribute("name", findDto.getMemberId()); 
			return "redirect:/";
		}
		else {
			return "redirect:login?error";
		}
	}
}
