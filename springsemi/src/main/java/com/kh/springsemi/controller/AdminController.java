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

import com.kh.springsemi.dao.DeliveryDao;
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dto.DeliveryDto;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.MemberListDto;
import com.kh.springsemi.dto.ProjectListDto;
import com.kh.springsemi.error.AuthorityException;
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
	
	@RequestMapping("/home")
	public String home() {
		return "/WEB-INF/views/admin/home.jsp";
	}
	
	@RequestMapping("/member/list")
	public String memberList(@ModelAttribute PaginationVO vo, Model model) {
		int count = memberDao.countList(vo);
		model.addAttribute("vo", vo);
		vo.setCount(count);
		
//		List<MemberDto> list = memberDao.selectListByPage(vo);
		List<MemberListDto> list =memberDao.selectListByPage2(vo);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/admin/member/list.jsp";
	}
//		관리자 회원 차단
		
		@RequestMapping("/member/block")
		public String memberBlock(@RequestParam String memberId) {
			memberDao.insertBlock(memberId);
			return "redirect:/admin/member/list";
		}
//		차단 해제 
		
		@RequestMapping("/member/cancel")
		public String memberCancel(@RequestParam String memberId) {
			memberDao.deleteBlock(memberId);
			return "redirect:/admin/member/list";
		}
		@Autowired
		DeliveryDao deliveryDao;
//		관리자 상세 
		@RequestMapping("/member/detail")
		public String memberDetail(@RequestParam String memberId, Model model, HttpSession session) {
			
			MemberDto memberDto = memberDao.selectOne(memberId);
			model.addAttribute("memberDto", memberDto);
			
			//관리자에서 상세페이지 배송지 찍는 구문 구현 중
//			String deliveryId = (String) session.getAttribute("name"); //세션으로 사용자 아이디 꺼내옴
//			DeliveryDto deliveryDto = deliveryDao.selectOneByMemberId(deliveryId); //아이디로 정보조회
//			model.addAttribute("deliveryDto",deliveryDto);
//			model.addAttribute("delivery", deliveryDao.selectOneByMemberId(deliveryId));
			
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
		
		
		
		
		//admin - project 심사 / 삭제
		@RequestMapping("/project/list")
		public String list(Model model, @RequestParam(required = false) String keyword
				,@RequestParam(required = false, defaultValue="1") int page) {
			boolean isSearch = keyword != null;
			
			//페이징과 관련된 값들을 계산하여 JSP로 전달 
			int begin = (page - 1) / 10 * 10 + 1;
			int end = begin + 9;
			int count = isSearch ? projectDao.countList(keyword) : projectDao.countList(); //목록 개수 or 검색 결과 수를 모름
			int pageCount = (count - 1) / 10 * 1 + 1;
			model.addAttribute("page", page);
			model.addAttribute("begin", begin);
			model.addAttribute("end", Math.min(pageCount, end)); //둘 중에 작은 값이 페이지의 마지막이 되어야 한다
			model.addAttribute("pageCount", pageCount);
					
			if(isSearch) { //검색이라면
				//List<ProjectListDto> projectList = projectDao.selectList(keyword);
				List<ProjectListDto> projectList = projectDao.selectListByPage(keyword, page);
				model.addAttribute("projectList", projectList);
				model.addAttribute("isSearch", true);
			}
			else { //목록이라면
//				List<ProjectListDto> projectList = projectDao.selectList();
				List<ProjectListDto> projectList = projectDao.selectListByPage(page);
				model.addAttribute("projectList",projectList);
				model.addAttribute("isSearch", false);
			}
			return "/WEB-INF/views/admin/project/list.jsp";
		}
		
		@RequestMapping("/project/delete")
		public String delete(@RequestParam int projectNo, HttpSession session) {
			String memberLevel = (String) session.getAttribute("level");
			if(memberLevel.equals("관리자")) {
				projectDao.delete(projectNo);
				return "redirect:/admin/project/list";
			}
			else { 
				throw new AuthorityException("찾을 수 없는 프로젝트 입니다");
			}
		
		}
}