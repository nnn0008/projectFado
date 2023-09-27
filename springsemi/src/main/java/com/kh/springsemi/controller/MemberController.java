package com.kh.springsemi.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.MemberFollowDto;
import com.kh.springsemi.vo.PaginationVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired 
	private MemberDao memberDao;
	
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
	
	//회원 상세 페이지
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		
		String memberId = (String) session.getAttribute("name"); //세션으로 사용자 아이디 꺼내옴
		MemberDto memberDto = memberDao.selectOne(memberId); //회원정보 조회
		//조회한 정보를 모델에 첨부 
		model.addAttribute("memberDto",memberDto); 
		model.addAttribute("memberFollowList", memberDao.findByFollowerId(memberId));
		//회원의 프로필 이미지 번호를 모델에 첨부
		model.addAttribute("profile", memberDao.findProfile(memberId)); 
		
		return "/WEB-INF/views/member/mypage.jsp";
	}	
	
	//회원 비밀번호 변경 페이지
	@GetMapping("/password")
	public String password() {
		return "/WEB-INF/views/member/password.jsp";
	}
	
	@PostMapping("/password")
	public String password(HttpSession session, 
			@RequestParam String originPw,
			@RequestParam String changePw) {
		String memberId = (String) session.getAttribute("name"); 
		MemberDto memberDto = memberDao.selectOne(memberId);
		
		if(memberDto.getMemberPw().equals(originPw)) { 
			memberDao.updateMemberPw(memberId,changePw);
			return "redirect:passwordFinish";
		}
		else {
			return "redirect:password?error";
		}
	}
	
	@RequestMapping("/passwordFinish")
	public String passwordFinish() {
		return "/WEB-INF/views/member/passwordFinish.jsp";
	}
	
	//회원 개인정보 변경 페이지
	@GetMapping("/change")
	public String change(HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("name"); 
		MemberDto memberDto = memberDao.selectOne(memberId); 
		model.addAttribute("memberDto", memberDto); 
		return "/WEB-INF/views/member/change.jsp";
	}
	
	@PostMapping("/change")
	public String change(@ModelAttribute MemberDto inputDto, HttpSession session) {
		String memberId = (String)session.getAttribute("name");

		MemberDto findDto = memberDao.selectOne(memberId);
		
		//비밀번호 검사
		if(inputDto.getMemberPw().equals(findDto.getMemberPw())) { 
			inputDto.setMemberId(memberId);
			memberDao.updateMemberInfo(inputDto);
			return "redirect:mypage";
		}
		else {
			return "redirect:change?error";
		}
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
			session.setAttribute("name", findDto.getMemberId()); 
			session.setAttribute("level", findDto.getMemberLevel());//확인받아야
			memberDao.updateMemberLogin(inputDto.getMemberId());
			return "redirect:/";
		}
		else {
			return "redirect:login?error";
		}
	}
	
	//회원 로그아웃 페이지
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("name");
//		session.removeAttribute("level");/확인받아야
		return "redirect:/";
	}
	
	//회원 탈퇴 페이지
	@GetMapping("/exit")
	public String exit() {
		return "/WEB-INF/views/member/exit.jsp";
	}
	
	@PostMapping("/exit")
	public String exit(HttpSession session, @RequestParam String memberPw){
		String memberId = (String) session.getAttribute("name");
		
		MemberDto memberDto = memberDao.selectOne(memberId);
		if (memberDto.getMemberPw().equals(memberPw)) { 
			memberDao.delete(memberId);
			session.removeAttribute("name");
			
			return "/WEB-INF/views/member/exitFinish.jsp";
		} 
		return "redirect:exit?error";
	}
	
	@RequestMapping("/follow/list")
	public String list(@ModelAttribute(name="vo") PaginationVO vo, Model model, @RequestParam String followerId) {
		int count = memberDao.countFollowList(vo);
		vo.setCount(count);
		
		List<MemberFollowDto> list = memberDao.selectFollowListByPage(vo, followerId);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/member/followList.jsp";
	}
	
	@RequestMapping("/follow/following")
	public String memberFollowing(@ModelAttribute MemberFollowDto memberFollowDto) {
		memberDao.insertFollow(memberFollowDto);
		return "redirect:list";
	}
	
	@RequestMapping("/follow/cancel")
	public String memberCancel(@ModelAttribute MemberFollowDto memberFollowDto) {
		memberDao.deleteFollow(memberFollowDto);
		return "redirect:list";
	}
	
	@Autowired

	private JavaMailSender sender;
	
	//회원 로그인 비밀번호 찾기
	@GetMapping("/findPw")
	public String findPw() {
		return "/WEB-INF/views/member/findPw.jsp";
	}
	
	@PostMapping("/findPw")
	public String findPw(@ModelAttribute MemberDto memberDto) {
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		boolean isValid = findDto != null && findDto.getMemberEmail().equals(memberDto.getMemberEmail());
		
		if(isValid) {
			SimpleMailMessage message = new SimpleMailMessage();
			message.setTo(findDto.getMemberEmail());
			message.setSubject("비밀번호 찾기 결과");
			message.setText(findDto.getMemberPw());
			sender.send(message);
			return "redirect:findPwFinish";
		}
		else {
			return "redirect:findPw?error";
		}
	}
	
	@RequestMapping("/findPwFinish")
	public String findPwFinish() {
		return "/WEB-INF/views/member/findPwFinish.jsp";
	}

}
