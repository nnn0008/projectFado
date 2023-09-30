package com.kh.springsemi.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.DeliveryDao;
import com.kh.springsemi.dto.DeliveryDto;

//@CrossOrigin
@RestController
@RequestMapping("/rest/delivery")
public class DeliveryRestController {
	
	@Autowired
	private DeliveryDao deliveryDao;
	
	//배송지 등록
	@PostMapping("/insert")
	public void insert(@ModelAttribute DeliveryDto deliveryDto, HttpSession session) {
		int deliveryNo = deliveryDao.sequence(); 
		deliveryDto.setDeliveryNo(deliveryNo); 
		
		String memberId = (String) session.getAttribute("name"); 
		deliveryDto.setMemberId(memberId);
		
		deliveryDao.insert(deliveryDto);
	}
	
	//배송지 목록
	@PostMapping("/list")
	public List<DeliveryDto> list(HttpSession session) {
		String memberId = (String) session.getAttribute("name");
		List<DeliveryDto> list = deliveryDao.selectListByMemberId(memberId);
		return list;
	}
	
	//배송지 삭제
	@PostMapping("/delete")
	public void delete(@RequestParam int deliveryNo) {
		deliveryDao.delete(deliveryNo);
	}
	
	//배송지 수정
	@PostMapping("/edit")
	public void edit(@ModelAttribute DeliveryDto deliveryDto) {
		deliveryDao.update(deliveryDto);
	}

}
