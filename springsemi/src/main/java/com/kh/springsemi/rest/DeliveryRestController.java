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
		int deliveryNo = deliveryDao.sequence(); //시퀀스 번호 가져옴
		deliveryDto.setDeliveryNo(deliveryNo); //시퀀스로 번호 넣기
		
		String findMember = (String) session.getAttribute("name"); //세션에 있는 멤버 가져오기
		deliveryDto.setDeliveryMember(findMember); 
		
		deliveryDao.insert(deliveryDto);
		
	}
	
	//배송지 목록
	@PostMapping("/list")
	public List<DeliveryDto> list(@RequestParam int deliveryNo) {
		List<DeliveryDto> list = deliveryDao.selectList(deliveryNo);
		return list;
	}
	
	//배송지 삭제
	public void delete(@RequestParam int deliveryNo) {
//		DeliveryDto deliveryDto = deliveryDao.selectOne(deliveryNo); 상세는 필요가 없다
		deliveryDao.delete(deliveryNo);
	}
	
	//배송지 수정
	@PostMapping("/edit")
	public void edit(@ModelAttribute DeliveryDto deliveryDto) {
		deliveryDao.update(deliveryDto);
	}

}
