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
		ordersListDto.setProjectTitle(rs.getString("project_title"));
		ordersListDto.setProjectTotalPrice(rs.getInt("project_total_price"));
		ordersListDto.setProjectGoalPrice(rs.getInt("project_goal_price"));
		ordersListDto.setOrdersDate(rs.getDate("project_end_date"));
		ordersListDto.setMajorCategoryType(rs.getString("major_category_type"));
		ordersListDto.setMinorCategoryType(rs.getString("minor_category_type"));
		ordersListDto.setMemberNickname(rs.getString("member_nickname"));
		ordersListDto.setMemberContact(rs.getString("member_contact"));
		ordersListDto.setMemberEmail(rs.getString("member_email"));
		ordersListDto.setMemberPoint(rs.getInt("member_point"));
		ordersListDto.setDeliveryNo(rs.getInt("delivery_no"));
		ordersListDto.setDeliveryReceiver(rs.getString("delivery_receiver"));
		ordersListDto.setDeliveryPost(rs.getString("delivery_post"));
		ordersListDto.setDeliveryAddr1(rs.getString("delivery_addr1"));
		ordersListDto.setDeliveryAddr2(rs.getString("delivery_addr2"));
		ordersListDto.setDeliveryContact(rs.getString("delivery_contact"));
		ordersListDto.setOrdersDate(rs.getDate("orders_date"));
		ordersListDto.setOrdersReward(rs.getString("orders_reward"));
		ordersListDto.setOrdersPrice(rs.getInt("orders_price"));
		ordersListDto.setOrdersStatus(rs.getString("orders_status"));
		return ordersListDto;
	}
}
