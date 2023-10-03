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
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.OrdersDao;
import com.kh.springsemi.dao.PaymentDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dao.RewardDao;
import com.kh.springsemi.dto.DeliveryDto;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.OrdersDto;
import com.kh.springsemi.dto.PaymentDto;
import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.RewardDto;

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
	
	@Autowired
	private RewardDao rewardDao;
	
	@GetMapping("/insert")
	public String ordersInsert(@RequestParam int projectNo,HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		List<DeliveryDto> deliveryList = deliveryDao.selectListByMemberId(memberId);
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		RewardDto rewardDto = rewardDao.selectOne(projectNo);
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("deliveryList",deliveryList);
		model.addAttribute("projectDto",projectDto);
		model.addAttribute("rewardDto",rewardDto);
		return "/WEB-INF/views/orders/insert.jsp";
	}
	
	@PostMapping("/insert")
	public String ordersInsert(@ModelAttribute OrdersDto ordersDto, 
										 @ModelAttribute PaymentDto paymentDto,
										 HttpSession session ,Model model) {
		int ordersNo = ordersDao.sequence();
		int paymentNo = paymentDao.sequence();
		String memberId = (String)session.getAttribute("name");
		ordersDto.setOrdersNo(ordersNo);
		paymentDto.setPaymentNo(paymentNo);
		ordersDto.setOrdersPerson(memberId);
		
		ordersDao.createOrders(ordersDto);
		paymentDao.createPayment(paymentDto);
		return "redirect:insertFinish";
	}
	
	@RequestMapping("/insertFinish")
	public String insertFinish() {
		return "/WEB-INF/views/orders/insertFinish.jsp";
	}
}
