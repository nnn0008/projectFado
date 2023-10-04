package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.PaymentDto;

@Component
public class PaymentMapper implements RowMapper<PaymentDto>{

	@Override
	public PaymentDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		PaymentDto paymentDto = new PaymentDto();
		paymentDto.setPaymentNo(rs.getInt("payment_no"));
		paymentDto.setOrdersNo(rs.getInt("orders_no"));
		paymentDto.setPaymentStatus(rs.getString("payment_status"));
		paymentDto.setPaymentDate(rs.getDate("payment_date"));
		return paymentDto;
	}

}
