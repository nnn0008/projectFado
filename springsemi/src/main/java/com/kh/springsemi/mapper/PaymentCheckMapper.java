package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.PaymentCheckDto;

@Component
public class PaymentCheckMapper implements RowMapper<PaymentCheckDto>{
	@Override
	public PaymentCheckDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		PaymentCheckDto paymentCheckDto = new PaymentCheckDto();
		paymentCheckDto.setMemberId(rs.getString("member_id"));
		paymentCheckDto.setMemberPoint(rs.getInt("member_point"));
		paymentCheckDto.setMemberEmail(rs.getString("member_email"));
		paymentCheckDto.setMemberContact(rs.getString("member_contact"));
		paymentCheckDto.setOrdersNo(rs.getInt("orders_no"));
		paymentCheckDto.setOrdersPrice(rs.getInt("orders_price"));
		paymentCheckDto.setProjectNo(rs.getInt("project_no"));
		paymentCheckDto.setPaymentDate(rs.getDate("payment_date"));
		paymentCheckDto.setPaymentNo(rs.getInt("payment_no"));
		paymentCheckDto.setPaymentStatus(rs.getString("payment_status"));
		return paymentCheckDto;
	}
}
