package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.OrdersListDto;

@Component
public class OrdersListMapper implements RowMapper<OrdersListDto>{
	@Override
	public OrdersListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		OrdersListDto ordersListDto = new OrdersListDto();
		ordersListDto.setProjectNo(rs.getInt("project_no"));
		ordersListDto.setOrdersPerson(rs.getString("orders_person"));
		ordersListDto.setOrdersDate(rs.getDate("orders_date"));
		ordersListDto.setOrdersReward(rs.getString("orders_reward"));
		ordersListDto.setOrdersPrice(rs.getInt("orders_price"));
		ordersListDto.setOrdersStatus(rs.getString("orders_status"));
		ordersListDto.setProjectNo(rs.getInt("project_no"));
		ordersListDto.setProjectTitle(rs.getString("project_title"));
		ordersListDto.setPaymentNo(rs.getInt("payment_no"));
		ordersListDto.setPaymentStatus(rs.getString("payment_status"));
		ordersListDto.setPaymentDate(rs.getDate("payment_date"));
		return ordersListDto;
	}
}
