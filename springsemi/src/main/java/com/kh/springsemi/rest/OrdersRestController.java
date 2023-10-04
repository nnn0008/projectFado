package com.kh.springsemi.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.OrdersDao;

@CrossOrigin
@RestController
@RequestMapping("/rest/orders")
public class OrdersRestController {

	@Autowired
	private OrdersDao ordersDao;
	
}
