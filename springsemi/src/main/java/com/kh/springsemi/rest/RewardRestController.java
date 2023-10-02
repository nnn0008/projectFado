package com.kh.springsemi.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.RewardDao;
import com.kh.springsemi.dto.RewardDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/reward")
public class RewardRestController {
	
	@Autowired
	private RewardDao rewardDao;
	
	@PostMapping("/insert")
	public void insert(@ModelAttribute RewardDto rewardDto, @RequestParam int projectNo) {
		int rewardNo = rewardDao.sequence();
		rewardDto.setRewardNo(rewardNo);
		rewardDto.setProjectNo(projectNo);
		rewardDao.insert(rewardDto);
	}
	
	@PostMapping("/delete")
	public void delete(@RequestParam int rewardNo) {
		rewardDao.delete(rewardNo);
	}
	
	@PostMapping("/list")
	public List<RewardDto> list(@RequestParam int projectNo){
		List<RewardDto> list = rewardDao.selectListByProjectNo(projectNo);
		return list;
	}
}
