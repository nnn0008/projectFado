package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.OrdersDto;

public interface OrdersDao {
	
	int sequence();
	void createOrders(OrdersDto ordersDto);
	boolean updateReward(OrdersDto ordersDto);
	boolean updateStatus(OrdersDto ordersDto);
	OrdersDto selectOne(int ordersNo);
	List<OrdersDto> selectList();
	boolean deleteOrders(int ordersNo);
}
