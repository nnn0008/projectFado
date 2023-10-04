package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.OrdersDto;

@Component
public class OrdersMapper implements RowMapper<OrdersDto>{

	@Override
	public OrdersDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		OrdersDto ordersDto = new OrdersDto();
		ordersDto.setOrdersNo(rs.getInt("orders_no"));
		ordersDto.setOrdersPerson(rs.getString("orders_person"));
		ordersDto.setProjectNo(rs.getInt("project_no"));
		ordersDto.setDeliveryNo(rs.getInt("delivery_no"));
		ordersDto.setOrdersDate(rs.getDate("orders_date"));
		ordersDto.setOrdersReward(rs.getString("orders_reward"));
		ordersDto.setOrdersPrice(rs.getInt("orders_price"));
		ordersDto.setOrdersStatus(rs.getString("orders_status"));
		return ordersDto;
	}

}
