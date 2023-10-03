package com.kh.springsemi.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.springsemi.dao.DeliveryDao;
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.OrdersDao;
import com.kh.springsemi.dao.PaymentDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dto.DeliveryDto;
import com.kh.springsemi.dto.OrdersDto;

@Controller
@RequestMapping("/orders")
public class OrdersController {
	@Autowired
	private OrdersDao ordersDao;
	
	@Autowired
	private ProjectDao projectDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private DeliveryDao deliveryDao;
	
	@Autowired
	private PaymentDao paymentDao;
	
	@GetMapping("/receipt")
	public String receipt(HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("name");
		DeliveryDto deliveryDto = deliveryDao.selectOneByMemberId(memberId);
		model.addAttribute("deliveryDto",deliveryDto);
		return "/WEB-INF/views/orders/receipt.jsp";
	}
	
	@PostMapping("/receipt")
	public String receipt(@ModelAttribute OrdersDto ordersDto, HttpSession session ,Model model) {
		int ordersNo = ordersDao.sequence();
		String memberId = (String)session.getAttribute("name");
		ordersDto.setOrdersPerson(memberId);
		ordersDao.createOrders(ordersDto);
		return "redirect:orders/complete";
	}
}
