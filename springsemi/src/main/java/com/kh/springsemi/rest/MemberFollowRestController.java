package com.kh.springsemi.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dto.MemberFollowDto;
import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.vo.MemberFollowVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/follow")
public class MemberFollowRestController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ProjectDao projectDao;
	
	@RequestMapping("/check")
	public MemberFollowVO check(@ModelAttribute MemberFollowDto memberFollowDto,
													HttpSession session) {
		String followerId = (String) session.getAttribute("name");
		memberFollowDto.setFollowerId(followerId);
		
		boolean isCheck = memberDao.check(memberFollowDto);
		int count = memberDao.count(memberFollowDto.getFolloweeId());
		
		MemberFollowVO vo = new MemberFollowVO();
		vo.setCheck(isCheck);
		vo.setCount(count);
		return vo;
	}
	
	@RequestMapping("/action")
	public MemberFollowVO action(@ModelAttribute MemberFollowDto memberFollowDto,
														@RequestParam int projectNo,
														HttpSession session) {
		String followerId = (String) session.getAttribute("name");
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		memberFollowDto.setFollowerId(followerId);
		memberFollowDto.setFolloweeId(projectDto.getProjectOwner());
		
		boolean isCheck = memberDao.check(memberFollowDto);
		if(isCheck) {
			memberDao.deleteFollow(memberFollowDto);
		}
		else {
			memberDao.insertFollow(memberFollowDto);
		}
		int count = memberDao.count(memberFollowDto.getFolloweeId());
		MemberFollowVO vo = new MemberFollowVO();
		vo.setCheck(!isCheck);
		vo.setCount(count);
		return vo;
	}
	
	@PostMapping("/insert")
	public void insert(@ModelAttribute MemberFollowDto memberFollowDto, HttpSession session) {
		String followerId = (String)session.getAttribute("name");
		memberFollowDto.setFollowerId(followerId);
		memberDao.insertFollow(memberFollowDto);
	}
	
//	@PostMapping("/delete")
//	public void delete(@ModelAttribute MemberFollowDto memberFollowDto) {
//		List<MemberFollowDto> followList = memberDao.selectFollowingList(memberFollowDto);
//		memberDao.deleteFollow(followList);
//	}
	
}
