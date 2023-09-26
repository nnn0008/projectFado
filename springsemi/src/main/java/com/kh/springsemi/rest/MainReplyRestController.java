package com.kh.springsemi.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.MainCommunityDao;
import com.kh.springsemi.dao.MainReplyDao;
import com.kh.springsemi.dto.MainReplyDto;
import com.kh.springsemi.dto.MainReplyDto;

@RestController
@RequestMapping("/rest/mainReply")
public class MainReplyRestController {

	@Autowired
	private MainReplyDao mainReplyDao;

	
	
	@PostMapping("/insert")
	public void insert(@ModelAttribute MainReplyDto mainReplyDto, HttpSession session) {
		int mainReplyNo = mainReplyDao.sequence();
		mainReplyDto.setMainReplyNo(mainReplyNo);
		
		String memberId = (String)session.getAttribute("name");
		mainReplyDto.setMainReplyWriter(memberId);
		
		mainReplyDao.insert(mainReplyDto);
		
	}
	
	@PostMapping("/list")
	public List<MainReplyDto> list(@RequestParam int mainReplyOrigin){
		List<MainReplyDto> list = mainReplyDao.selectList(mainReplyOrigin);
		return list;
	}
	
	@PostMapping("/delete")
	public void delete(@RequestParam int mainReplyNo) {
		mainReplyDao.delete(mainReplyNo);
	}
	
	
	
	@PostMapping("/edit")
	public void edit(@ModelAttribute MainReplyDto mainReplyDto) {
		mainReplyDao.update(mainReplyDto);
	}
}
