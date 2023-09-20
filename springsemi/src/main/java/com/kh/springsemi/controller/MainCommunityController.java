package com.kh.springsemi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springsemi.dao.MainCommunityDao;
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dto.MainCommunityDto;
import com.kh.springsemi.vo.PaginationVO;

@Controller
@RequestMapping("/helper")
public class MainCommunityController {

	@Autowired
	private MainCommunityDao mainCommunityDao;
	
	@Autowired
	private MemberDao memberDao;
	
//	@GetMapping("/write")  //메인 커뮤니티 글작성-get
//	
//	@PostMapping("/write")  //메인 커뮤니티 글작성-post
//	
	@GetMapping("/edit")  //메인 커뮤니티 글수정-get
	public String edit(@RequestParam int mainCommunityNo, Model model) {
		MainCommunityDto mainCommunityDto = mainCommunityDao.selectOne(mainCommunityNo);
		model.addAttribute("mainCommunityDto", mainCommunityDto);
		return "/WEB-INF/views/helper/community/edit.jsp";
	}
	
	
//	@PostMapping("/edit")  //메인 커뮤니티 글수정-post
//	public String edit(@ModelAttribute MainCommunityDto mainCommunityDto) {
//		boolean result = mainCommunityDao.update(mainCommunityDto);
//		if(result) return "redirect:detail?mainCommunityNo="+mainCommunityDto.getMainCommunityNo();
////		else throw new NoTargetException("존재하지 않는 글번호");
//	}
	
	@RequestMapping("/list")  //메인 커뮤니티 글 목록
	public String list(@ModelAttribute(name = "vo") PaginationVO vo, Model model) {
		int count = mainCommunityDao.countList(vo);
		
		return null;
		
	}
//	@RequestMapping("/detail")  //메인 커뮤니티 글 상세
//	
//	@RequestMapping("/delete")  //메인 커뮤니티 글 삭제
//	public String delete(@RequestParam int mainCommunityNo) {
//		boolean result = mainCommunityDao.delete(mainCommunityNo);
//		if(result) return "redirect:list";
//		else throw new NoTargetException("존재하지 않는 글번호");
//	}
	
}
