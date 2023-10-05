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
	public String ordersInsert(@RequestParam int projectNo,
										@RequestParam int rewardNo,
										HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		DeliveryDto deliveryDto = deliveryDao.selectOneByMemberId(memberId);
		List<DeliveryDto> deliveryList = deliveryDao.selectListByMemberId(memberId);
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		RewardDto rewardDto = rewardDao.selectOne(rewardNo);
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("deliveryDto",deliveryDto);
		model.addAttribute("deliveryList",deliveryList);
		model.addAttribute("projectDto",projectDto);
		model.addAttribute("rewardDto",rewardDto);
		
		if(memberId != null) {
			return "/WEB-INF/views/orders/insert.jsp";
		}
		else {
			return "redirect:/member/login";
		}

		
	}
	
	@PostMapping("/insert")
	public String ordersInsert(@RequestParam int rewardNo,
										@RequestParam int deliveryNo,
										@ModelAttribute OrdersDto ordersDto,
										@ModelAttribute PaymentDto paymentDto,
										HttpSession session, Model model) {
		int ordersNo = ordersDao.sequence();
		String memberId = (String)session.getAttribute("name");
		RewardDto rewardDto = rewardDao.selectOne(rewardNo);
		ordersDto.setOrdersNo(ordersNo);
		ordersDto.setOrdersPerson(memberId);
		ordersDto.setOrdersReward(rewardDto.getRewardType());
		ordersDto.setOrdersPrice(rewardDto.getRewardPrice());
		ordersDao.createOrders(ordersDto);
		projectDao.plusProjectTotalPrice(ordersDto.getOrdersPrice(), ordersDto.getProjectNo());
		
		int paymentNo = paymentDao.sequence();
		paymentDto.setPaymentNo(paymentNo);
		paymentDto.setOrdersNo(ordersDto.getOrdersNo());
		paymentDao.createPayment(paymentDto);
		return "redirect:insertFinish";
	}
	
	@RequestMapping("/insertFinish")
	public String insertFinish() {
		return "/WEB-INF/views/orders/insertFinish.jsp";
	}
	
	@RequestMapping("/list")
	public String list(HttpSession session, Model model) {
		String ordersPerson = (String)session.getAttribute("name");
		List<OrdersListDto> ordersList = ordersDao.selectListByOrdersPerson(ordersPerson);
		model.addAttribute("ordersList",ordersList);
		return "/WEB-INF/views/orders/list.jsp";
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int ordersNo) {
		boolean result = ordersDao.deleteOrders(ordersNo);
		if(result) return "redirect:list";
		else throw new NoTargetException("주문 내역이 없습니다");
	}
}
