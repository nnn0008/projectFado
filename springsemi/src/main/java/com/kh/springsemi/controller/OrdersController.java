package com.kh.springsemi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.springsemi.dao.DeliveryDao;
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.OrdersDao;
import com.kh.springsemi.dao.PaymentDao;
import com.kh.springsemi.dao.ProjectDao;

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
	
//	@RequestMapping("/receipt")
//	public String receipt() {
//		
//	}
}
