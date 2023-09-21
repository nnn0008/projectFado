package com.kh.springsemi.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springsemi.dao.DeliveryDao;
import com.kh.springsemi.dto.DeliveryDto;
import com.kh.springsemi.error.NoTargetException;

@Controller
@RequestMapping("/delivery")
public class DeliveryController {
	
	@Autowired
	DeliveryDao deliveryDao;
	
	//배송지 등록
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/delivery/join.jsp";
	}

	@PostMapping("/join") 
	public String join(@ModelAttribute DeliveryDto deliveryDto, HttpSession session) {
		String findMember = (String) session.getAttribute("name"); //세션에 있는 멤버 가져오기
		deliveryDto.setDeliveryMember(findMember); 
		
		int deliveryNo = deliveryDao.sequence(); //시퀀스 번호 가져옴
		deliveryDto.setDeliveryNo(deliveryNo); //시퀀스로 번호 넣기
		
		deliveryDao.insert(deliveryDto);
		return "redirect:mydelivery"; 
	}
	
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
	
//	//배송지 수정
//	@GetMapping("/change")
//	public String change(@RequestParam String deliveryMember, Model model) {
//		List<DeliveryDto> deliveryDto = deliveryDao.selectList(deliveryMember);
//		model.addAttribute("deliveryDto", deliveryDto);
//		return "/WEB-INF/views/delivery/change.jsp";
//	}
	
//	@PostMapping("/change")
//	public String change(@ModelAttribute DeliveryDto deliveryDto) {
//		boolean result = deliveryDao.update(deliveryDto);
//		if (result) {
//			return "redirect:mydelivery?deliveryNo="+deliveryDto.getDeliveryMember();
//		}
//		else {
//			throw new NoTargetException("존재하지 않는 주소입니다.");
//		}
//	}
	
	//배송지 삭제
	@RequestMapping("/delete")
	public String delete(@RequestParam int deliveryNo) {
		boolean result = deliveryDao.delete(deliveryNo);
		if(result) {
			return "redirect:list";
		}
		else {
			throw new NoTargetException("존재하지 않는 배송지입니다.");
		}
	}
}
