package com.kh.springsemi.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.ProjectReplyDao;
import com.kh.springsemi.dto.ProjectReplyDto;

@RestController
@RequestMapping("/rest/projectReply")
public class ProjectReplyRestController {

	@Autowired
	private ProjectReplyDao projectReplyDao;
	
	@PostMapping("/insert")
	public void insert(@ModelAttribute ProjectReplyDto projectReplyDto, HttpSession session) {
		int projectReplyNo = projectReplyDao.sequence();
		projectReplyDto.setProjectReplyNo(projectReplyNo);
		
		String memberId = (String)session.getAttribute("name");
		projectReplyDto.setProjectReplyWriter(memberId);
		
		projectReplyDao.insert(projectReplyDto);
		
		
	}
	
	
	@PostMapping("/list")
	public List<ProjectReplyDto> list(@RequestParam int projectReplyOrigin){
		List<ProjectReplyDto> list = projectReplyDao.selectList(projectReplyOrigin);
		return list;
	}
	
	@PostMapping("/delete")
	public void delete(@RequestParam int projectReplyNo) {
		projectReplyDao.delete(projectReplyNo);
	}
	
	
	@PostMapping("/edit")
	public void edit(@ModelAttribute ProjectReplyDto projectReplyDto) {
		projectReplyDao.update(projectReplyDto);
	}
	
}
