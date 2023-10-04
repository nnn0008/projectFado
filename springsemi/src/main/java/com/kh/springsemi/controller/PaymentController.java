package com.kh.springsemi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.OrdersDao;
import com.kh.springsemi.dao.PaymentDao;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.OrdersDto;
import com.kh.springsemi.dto.PaymentDto;

@Controller
@RequestMapping("/payment")
public class PaymentController {
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private OrdersDao ordersDao;
	
	@Autowired
	private PaymentDao paymentDao;
	
	@GetMapping("/payCheck")
	public String payCheck(Model model, @ModelAttribute OrdersDto ordersDto, @ModelAttribute MemberDto memberDto) {
		ordersDto = ordersDao.selectOne(ordersDto.getOrdersNo());
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("ordersDto", ordersDto);
		return "/WEB-INF/views/payment/payCheck";
	}
	
	@PostMapping("/payCheck")
	public String payCheck(@ModelAttribute MemberDto memberDto, @ModelAttribute PaymentDto paymentDto, @ModelAttribute OrdersDto ordersDto) {
		memberDto = memberDao.selectOne(ordersDto.getOrdersPerson());
		ordersDto = ordersDao.selectOne(ordersDto.getOrdersNo());
		int point = memberDto.getMemberPoint();
		if(point >= ordersDto.getOrdersPrice()) {
			paymentDao.updatePaymentStatus("결제완료", paymentDto.getPaymentNo());
			return "redirect:/payFinish";
		}
		else {
			paymentDao.updatePaymentStatus("결제취소", paymentDto.getPaymentNo());			
			return "redirect:/payCheck";
		}	
	}
	
	
}
