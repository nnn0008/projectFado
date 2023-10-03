package com.kh.springsemi.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.JudgeDao;
import com.kh.springsemi.dto.JudgeDto;

@RestController
@RequestMapping("/rest")
public class JudgeRestController {
	@Autowired
	private JudgeDao judgeDao;
	
	@PostMapping("/judge")
	public void judge(@RequestParam String judgeStatus, @RequestParam int projectNo) {
		JudgeDto judgeDto = judgeDao.selectOneByProjectNo(projectNo);
		judgeDto.setJudgeStatus(judgeStatus);
		judgeDao.update(judgeDto);
	}
	
}
