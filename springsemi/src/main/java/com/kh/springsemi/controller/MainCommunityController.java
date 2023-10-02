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

import com.kh.springsemi.dao.MainCommunityDao;
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dto.MainCommunityDto;
import com.kh.springsemi.dto.MainCommunityListDto;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.error.NoTargetException;
import com.kh.springsemi.vo.CommunityPaginationVO;

@Controller
@RequestMapping("/mainCommunity")
public class MainCommunityController {

	@Autowired
	private MainCommunityDao mainCommunityDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
//	private AttachDao attachDao;
	
	
	
	@GetMapping("/write")  //메인 커뮤니티 글작성-get
	public String insert() {
		return "/WEB-INF/views/mainCommunity/write.jsp";
	}
	
	
	@PostMapping("/write")  //메인 커뮤니티 글작성-post
	public String insert(@ModelAttribute MainCommunityDto mainCommunityDto, HttpSession session,
						@ModelAttribute MemberDto memberDto) {
		//커뮤니티 글 등록
		int mainCommunityNo = mainCommunityDao.sequence();
		mainCommunityDto.setMainCommunityNo(mainCommunityNo);
		
		String memberId = (String) session.getAttribute("name");
		
		mainCommunityDto.setMainCommunityWriter(memberId);
		
		mainCommunityDao.insert(mainCommunityDto);

		return "redirect:detail?mainCommunityNo="+mainCommunityNo;
	}
	
	@GetMapping("/edit")  //메인 커뮤니티 글수정-get
	public String edit(@RequestParam int mainCommunityNo, Model model) {
		MainCommunityDto mainCommunityDto = mainCommunityDao.selectOne(mainCommunityNo);
		model.addAttribute("mainCommunityDto", mainCommunityDto);
		
		return "/WEB-INF/views/mainCommunity/edit.jsp";
	}
	
	
	@PostMapping("/edit")  //메인 커뮤니티 글수정-post
	public String edit(@ModelAttribute MainCommunityDto mainCommunityDto) {
		boolean result = mainCommunityDao.update(mainCommunityDto);
		if(result) return "redirect:detail?mainCommunityNo="+mainCommunityDto.getMainCommunityNo();
		else throw new NoTargetException("존재하지 않는 글번호");
	}
	
	
	@RequestMapping("/noticeList")  //메인 커뮤니티 글 목록
	public String noticeList(@ModelAttribute(name = "vo") CommunityPaginationVO vo, Model model,
							@ModelAttribute MemberDto memberDto) {
		int count = mainCommunityDao.countNoticeList(vo);  //페이지 네이션 카운트 메소드
		vo.setCount(count);
		model.addAttribute("vo", vo);

		
		List<MainCommunityListDto> noticeList = mainCommunityDao.selectNoticeList(vo);
		model.addAttribute("noticeList", noticeList);
		
			
		return "/WEB-INF/views/mainCommunity/noticeList.jsp";
	}

		
	
	@RequestMapping("/qnaList")  //메인 커뮤니티 글 목록
		public String qnaList(@ModelAttribute(name = "vo") CommunityPaginationVO vo, Model model,
							@ModelAttribute MemberDto memberDto) {
		
		int count = mainCommunityDao.countQnAList(vo);  //페이지 네이션 카운트 메소드
		vo.setCount(count);
		model.addAttribute("vo", vo);
		
		
		List<MainCommunityListDto> qnaList = mainCommunityDao.selectQnAList(vo);
		model.addAttribute("qnaList", qnaList);
		
			
		return "/WEB-INF/views/mainCommunity/qnaList.jsp";
		
	}
	
	
	
	
	@RequestMapping("/detail")  //메인 커뮤니티 글 상세
	public String detail(@RequestParam int mainCommunityNo, Model model, HttpSession session) {
		MainCommunityDto mainCommunityDto = mainCommunityDao.selectOne(mainCommunityNo);
		model.addAttribute("mainCommunityDto", mainCommunityDto);
		
		String mainCommunityWriter = mainCommunityDto.getMainCommunityWriter();
		if(mainCommunityWriter != null) {
			MemberDto memberDto = memberDao.selectOne(mainCommunityWriter);
			model.addAttribute("WriterDto", memberDto);  //writerDto = model 저장명 이름
		}
		return "/WEB-INF/views/mainCommunity/detail.jsp";
	}
	
	
	@RequestMapping("/delete")  //메인 커뮤니티 글 삭제
	public String delete(@RequestParam int mainCommunityNo) {
		boolean result = mainCommunityDao.delete(mainCommunityNo);
		if(result) return "redirect:list";
		else throw new NoTargetException("존재하지 않는 글번호");
	}
	
	
}
