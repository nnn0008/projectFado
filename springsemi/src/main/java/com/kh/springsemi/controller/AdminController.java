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

import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.MemberListDto;
import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.ProjectListDto;
import com.kh.springsemi.error.NoTargetException;
import com.kh.springsemi.vo.PaginationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ProjectDao projectDao;
	
	@RequestMapping("/")
	public String home() {
		return "/WEB-INF/views/admin/home.jsp";
	}
	
	@RequestMapping("/member/list")
	public String memberList(@ModelAttribute PaginationVO vo, Model model) {
		int count = memberDao.countList(vo);
		vo.setCount(count);
		model.addAttribute("vo", vo);
		
//		List<MemberDto> list = memberDao.selectListByPage(vo);
		List<MemberListDto> list =memberDao.selectListByPage2(vo);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/admin/member/list.jsp";
	}
//		관리자 회원 차단
		
		@RequestMapping("/member/block")
		public String memberBlock(@RequestParam String memberId) {
			memberDao.insertBlock(memberId);
			return "redirect:list";
		}
//		차단 해제 
		
		@RequestMapping("/member/cancel")
		public String memberCancel(@RequestParam String memberId) {
			memberDao.deleteBlock(memberId);
			return "redirect:list";
		}
		
//		관리자 상세 
		@RequestMapping("/member/detail")
		public String memberDetail(@RequestParam String memberId, Model model) {
			
			MemberDto memberDto = memberDao.selectOne(memberId);
			model.addAttribute("memberDto", memberDto);
			
			return "/WEB-INF/views/admin/member/detail.jsp";				
			
		}	
		
//			관리자 수정 
		@GetMapping("/member/edit")
		public String memberEdit(Model model, @RequestParam String memberId) {
			
			MemberDto memberDto = memberDao.selectOne(memberId);
			model.addAttribute("memberDto", memberDto);
			
			return "/WEB-INF/views/admin/member/edit.jsp";
			
		}
//		관리자 수정 
		@PostMapping("/member/edit")
		public String memberEdit(@ModelAttribute MemberDto memberDto) {
			boolean result = memberDao.updateMemberInfoByAdmin(memberDto);
			if(result) {
				return "redirect:list";//상대경로
//				return "redirect:/admin/member/list";//절대경로
			}
			else {
				throw new NoTargetException("존재하지 않는 회원ID");
			}
		}
		
//		@RequestMapping("/project/list2")
//		public String projectList(@ModelAttribute PaginationVO vo, Model model) {
//			int count = projectDao.countList(vo);
//			vo.setCount(count);
//			model.addAttribute("vo" ,vo);
//			List<ProjectDto> list = projectDao.selectListByPage(vo);
//			model.addAttribute("list" ,list);
//			
//			return "/WEB-INF/views/project/list2.jsp";
//			
//		}
		}
		
		



		

		
	

