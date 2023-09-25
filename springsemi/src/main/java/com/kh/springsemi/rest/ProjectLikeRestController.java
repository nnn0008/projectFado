package com.kh.springsemi.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dao.ProjectLikeDao;
import com.kh.springsemi.dto.ProjectLikeDto;
import com.kh.springsemi.vo.ProjectLikeVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/like")
public class ProjectLikeRestController {
	
	@Autowired
	private ProjectLikeDao projectLikeDao;
	
	@Autowired
	private ProjectDao projectDao;
	
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
												@RequestParam int projectNo,
												HttpSession session) {
		String memberId = (String) session.getAttribute("name");
		projectLikeDto.setMemberId(memberId);
		
		boolean isCheck = projectLikeDao.check(projectLikeDto);
		if(isCheck) {
			projectLikeDao.delete(projectLikeDto);
			projectDao.minusProjectLikecount(projectNo);
		}
		else {
			projectLikeDao.insert(projectLikeDto);
			projectDao.plusProjectLikecount(projectNo);
		}
		int count = projectLikeDao.count(projectLikeDto.getProjectNo());
		ProjectLikeVO vo = new ProjectLikeVO();
		vo.setCheck(!isCheck);
		vo.setCount(count);
		return vo;
	}
}
