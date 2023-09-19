package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.OrdersDto;
import com.kh.springsemi.dto.PaymentDto;
import com.kh.springsemi.mapper.PaymentMapper;

@Repository
public class PaymentDaoImpl implements PaymentDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private PaymentMapper paymentMapper;
	
	@Override
	public int sequence() {
		String sql = "select payment_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void createPayment(PaymentDto paymentDto) {
		String sql = "";
		Object[] data = {};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean updatePaymentPerson(PaymentDto paymentDto) {
		String sql = "";
		return false;
	}
	
	@Override
		public boolean updatePaymentPrice(PaymentDto paymentDto) {
			// TODO Auto-generated method stub
			return false;
	}
	
	@Override
	public boolean updatePaymentStatus(PaymentDto paymentDto) {
		String sql = "update payment set payment_status=? where payment_no=?";
		Object[] data = {paymentDto.getPaymentStatus(), paymentDto.getPaymentNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public OrdersDto selectOne(int paymentNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PaymentDto> selectList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deletePayment(int paymentNo) {
		// TODO Auto-generated method stub
		return false;
	}

}
