package com.kh.springsemi.controller;

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
import com.kh.springsemi.dto.OrdersListDto;
import com.kh.springsemi.dto.PaymentDto;
import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.RewardDto;
import com.kh.springsemi.error.NoTargetException;

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
	public String ordersInsert(@RequestParam int projectNo, @RequestParam int rewardNo, HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		DeliveryDto deliveryDto = deliveryDao.selectOneByMemberId(memberId);
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		RewardDto rewardDto = rewardDao.selectOne(rewardNo);
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("deliveryDto",deliveryDto);
		model.addAttribute("projectDto",projectDto);
		model.addAttribute("rewardDto",rewardDto);
		return "/WEB-INF/views/orders/insert.jsp";
	}
	
	@PostMapping("/insert")
	public String ordersInsert(@RequestParam int rewardNo,
											@RequestParam int deliveryNo,
											@ModelAttribute OrdersDto ordersDto,
											@ModelAttribute PaymentDto paymentDto,
											Model model, HttpSession session) {
//		System.out.println(rewardNo);
//		System.out.println(deliveryNo);
		int ordersNo = ordersDao.sequence();
//		int paymentNo = paymentDao.sequence();
		String memberId = (String)session.getAttribute("name");
		RewardDto rewardDto = rewardDao.selectOne(rewardNo);
		ordersDto.setOrdersNo(ordersNo);
//		paymentDto.setPaymentNo(paymentNo);
		ordersDto.setOrdersPerson(memberId);
		ordersDto.setOrdersReward(rewardDto.getRewardType());
		ordersDto.setOrdersPrice(rewardDto.getRewardPrice());
		
		ordersDao.createOrders(ordersDto);
//		paymentDao.createPayment(paymentDto);
		return "redirect:insertFinish";
	}
	
	@RequestMapping("/insertFinish")
	public String insertFinish() {
		return "/WEB-INF/views/orders/insertFinish.jsp";
	}
	
	
	@RequestMapping("/list")
	public String list(Model model) {

		
		return "/WEB-INF/views/orders/list.jsp";
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int odersNo) {
		boolean result = ordersDao.deleteOrders(odersNo);
		if(result) return "redirect:list";
		else throw new NoTargetException("주문 내역이 없습니다");
	}
}
