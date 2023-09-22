package com.kh.springsemi.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.MemberFollowDao;
import com.kh.springsemi.dto.MemberFollowDto;
import com.kh.springsemi.vo.MemberFollowVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/follow")
public class MemberFollowRestController {
	
	@Autowired
	private MemberFollowDao memberFollowDao;
	
	@RequestMapping("/check")
	public MemberFollowVO check(@ModelAttribute MemberFollowDto memberFollowDto,
													HttpSession session) {
		String followerId = (String) session.getAttribute("name");
		memberFollowDto.setFollowerId(followerId);
		
		boolean isCheck = memberFollowDao.check(memberFollowDto);
		int count = memberFollowDao.count(memberFollowDto.getFolloweeId());
		
		MemberFollowVO vo = new MemberFollowVO();
		vo.setCheck(isCheck);
		vo.setCount(count);
		return vo;
	}
	
	@RequestMapping("/action")
	public MemberFollowVO action(@ModelAttribute MemberFollowDto memberFollowDto,
														HttpSession session) {
		String followerId = (String) session.getAttribute("name");
		memberFollowDto.setFollowerId(followerId);
		
		boolean isCheck = memberFollowDao.check(memberFollowDto);
		if(isCheck) {
			memberFollowDao.delete(memberFollowDto);
		}
		else {
			memberFollowDao.insert(memberFollowDto);
		}
		int count = memberFollowDao.count(memberFollowDto.getFolloweeId());
		MemberFollowVO vo = new MemberFollowVO();
		vo.setCheck(!isCheck);
		vo.setCount(count);
		return vo;
	}
}
