package com.kh.springsemi.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.ProjectLikeDao;
import com.kh.springsemi.dto.ProjectLikeDto;
import com.kh.springsemi.vo.ProjectLikeVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/like")
public class ProjectLikeRestController {
	
	@Autowired
	private ProjectLikeDao projectLikeDao;
	
	@RequestMapping("/check")
	public ProjectLikeVO check(@ModelAttribute ProjectLikeDto projectLikeDto,
											HttpSession session) {
		String memberId = (String) session.getAttribute("name");
		projectLikeDto.setMemberId(memberId);
		
		boolean isCheck = projectLikeDao.check(projectLikeDto);
		int count = projectLikeDao.count(projectLikeDto.getProjectNo());
		
		ProjectLikeVO vo = new ProjectLikeVO();
		vo.setCheck(isCheck);
		vo.setCount(count);
		return vo;
	}
	
	@RequestMapping("/action")
	public ProjectLikeVO action(@ModelAttribute ProjectLikeDto projectLikeDto,
												HttpSession session) {
		String memberId = (String) session.getAttribute("name");
		projectLikeDto.setMemberId(memberId);
		
		boolean isCheck = projectLikeDao.check(projectLikeDto);
		if(isCheck) {
			projectLikeDao.delete(projectLikeDto);
		}
		else {
			projectLikeDao.insert(projectLikeDto);
		}
		int count = projectLikeDao.count(projectLikeDto.getProjectNo());
		ProjectLikeVO vo = new ProjectLikeVO();
		vo.setCheck(!isCheck);
		vo.setCount(count);
		return vo;
	}
}
