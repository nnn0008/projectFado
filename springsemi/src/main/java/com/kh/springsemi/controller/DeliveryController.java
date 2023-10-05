package com.kh.springsemi.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.springsemi.dao.DeliveryDao;

@Controller
@RequestMapping("/delivery")
public class DeliveryController {
	
	@Autowired
	DeliveryDao deliveryDao;
	
//	//배송지 등록
//	@GetMapping("/add")
//	public String add() {
//		return "/WEB-INF/views/delivery/add.jsp";
//	}

//	@PostMapping("/add") 
//	public String add(@ModelAttribute DeliveryDto deliveryDto, HttpSession session) {
//		String findMember = (String) session.getAttribute("name"); //세션에 있는 멤버 가져오기
//		deliveryDto.setDeliveryMember(findMember); 
//		
//		int deliveryNo = deliveryDao.sequence(); //시퀀스 번호 가져옴
//		deliveryDto.setDeliveryNo(deliveryNo); //시퀀스로 번호 넣기
//		
//		deliveryDao.insert(deliveryDto);
//		return "redirect:mydelivery"; 
//	}
	
//	//배송지 목록

//	@RequestMapping("/mydelivery")
//	public String myDelivery(Model model, HttpSession session) {
//		
//		String deliveryMember = (String)session.getAttribute("name");
//		
//		DeliveryDto deliveryDto = deliveryDao.selectList(deliveryMember);
//		model.addAttribute("deliveryDto",deliveryDto);
//		
//		return "/WEB-INF/views/delivery/mydelivery.jsp";
//	}
	@RequestMapping("/myDeliveryList")
	public String myDelivery(Model model, HttpSession session) {
//		String memberId = (String) session.getAttribute("name");
//		DeliveryDto deliveryDto = deliveryDao.selectOneByMemberId(memberId);
//		model.addAttribute("deliveryDto", deliveryDto);
		return "/WEB-INF/views/delivery/myDeliveryList.jsp";
	}
	
//	//배송지 삭제
//	@RequestMapping("/delete")
//	public String delete(@RequestParam int deliveryNo) {
//		boolean result = deliveryDao.delete(deliveryNo);
//		if(result) {
//			return "redirect:mydelivery",
//		}
//		else {
//			throw new NoTargetException("존재하지 않는 배송지입니다.");
//		}
//	}
}
