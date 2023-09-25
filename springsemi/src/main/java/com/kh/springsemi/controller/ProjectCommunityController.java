package com.kh.springsemi.controller;

import java.util.List;

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
import com.kh.springsemi.dao.ProjectCommunityDao;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.ProjectCommunityDto;
import com.kh.springsemi.error.NoTargetException;
import com.kh.springsemi.vo.CommunityPaginationVO;

@Controller
@RequestMapping("/projectCommunity")
public class ProjectCommunityController {

	@Autowired
	private ProjectCommunityDao projectCommunityDao;
	
	@Autowired
	private MemberDao memberDao;
	
	
	
	@GetMapping("/write")  //프로젝트 커뮤니티 글작성
	public String insert() {
		return "/WEB-INF/views/projectCommunity/write.jsp";
	}
	
	
	@PostMapping("/write")
	public String insert(@ModelAttribute ProjectCommunityDto projectCommunityDto, HttpSession session,
							@ModelAttribute MemberDto memberDto) {
	
		int projectCommunityNo = projectCommunityDao.sequence();
		projectCommunityDto.setProjectCommunityNo(projectCommunityNo);
		
		String memberId = (String) session.getAttribute("name");
		String memberLevel = (String) session.getAttribute("level");
		
		projectCommunityDto.setProjectCommunityWriter(memberId);
		memberDto.setMemberLevel(memberLevel);
		
		projectCommunityDao.insert(projectCommunityDto);

		return "redirect:detail?projectCommunityNo="+projectCommunityNo;
	}
	
	
	@GetMapping("edit")
	public String edit(@RequestParam int projectCommunityNo, Model model) {
		ProjectCommunityDto projectCommunityDto = projectCommunityDao.selectOne(projectCommunityNo);
		model.addAttribute("projectCommunityDto", projectCommunityDto);
		return "/WEB-INF/views/fundingCommunity/edit.jsp";
	}
	
	
	@RequestMapping("/noticeList")
	public String noticeList(@ModelAttribute(name = "vo") CommunityPaginationVO vo, Model model) {
		
		int count = projectCommunityDao.countNoticeList(vo);  //페이지 네이션 카운트 메소드
		vo.setCount(count);
		model.addAttribute("vo", vo);
		
		List<ProjectCommunityDto> noticeList = projectCommunityDao.selectNoticeList(vo);
		model.addAttribute("noticeList", noticeList);
			
		return "/WEB-INF/views/projectCommunity/noticeList.jsp";
	}
	
	
	@RequestMapping("/qnaList") 
	public String qnaList(@ModelAttribute(name = "vo") CommunityPaginationVO vo, Model model) {
	
		int count = projectCommunityDao.countQnAList(vo);  //페이지 네이션 카운트 메소드
		vo.setCount(count);
		model.addAttribute("vo", vo);
		
		List<ProjectCommunityDto> qnaList = projectCommunityDao.selectQnAList(vo);
		model.addAttribute("qnaList", qnaList);
			
		return "/WEB-INF/views/projectCommunity/qnaList.jsp";
	}
	
	
	@RequestMapping("/detail")  
	public String detail(@RequestParam int projectCommunityNo, Model model, HttpSession session) {
		ProjectCommunityDto projectCommunityDto = projectCommunityDao.selectOne(projectCommunityNo);
		model.addAttribute("projectCommunityDto", projectCommunityDto);
		
		String projectCommunityWriter = projectCommunityDto.getProjectCommunityWriter();
		if(projectCommunityWriter != null) {
			MemberDto memberDto = memberDao.selectOne(projectCommunityWriter);
			model.addAttribute("WriterDto", memberDto); 
		}
		return "/WEB-INF/views/projectCommunity/detail.jsp";
	}
	
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int projectCommunityNo) {
		boolean result = projectCommunityDao.delete(projectCommunityNo);
		if(result) return "redirect:list";
		else throw new NoTargetException("존재하지 않는 글번호");
	}
	
	
	
}
