package com.kh.springsemi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.vo.PaginationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private MemberDao memberDao;
	
	
	@RequestMapping("/")
	public String home() {
		return "/WEB-INF/views/admin/home.jsp";
	}
	
	@RequestMapping("/member/list")
	public String memberList(@ModelAttribute PaginationVO vo, Model model) {
		int count = memberDao.countList(vo);
		vo.setCount(count);
		model.addAttribute("vo", vo);
		
		List<MemberDto> list = memberDao.selectListByPage(vo);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/admin/member/list.jsp";
	}
//		차단+해제 기능 
		

		@RequestMapping("/member/block")
		public String memberBlock(@RequestParam String memberId) {
			memberDao.insertBlock(memberId);
			return "redirect:list";
		}
		
		
		
		@RequestMapping("/member/detail")
		public String memberDetail(@RequestParam String memberId, Model model) {
			
			MemberDto memberDto = memberDao.selectOne(memberId);
			model.addAttribute("memberDto", memberDto);
			
			return "/WEB-INF/views/admin/member/detail.jsp";				
			
			

					
			
		}
		
		
	}


		

		
	

