package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

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
		String sql = "insert into payment(payment_no, orders_no) values(?, ?)";
		Object[] data = {paymentDto.getPaymentNo(), paymentDto.getOrdersNo()};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public boolean updatePaymentStatus(String status, int paymentNo) {
		String sql = "update payment set payment_status = ? where payment_no = ?";
		Object[] data = {status, paymentNo};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public PaymentDto selectOne(int paymentNo) {
		String sql = "select * from payment where payment_no = ?";
		Object[] data = {paymentNo};
		List<PaymentDto> list = jdbcTemplate.query(sql, paymentMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	@Override
	public PaymentDto selectOneByOrdersNo(int ordersNo) {
		String sql = "select * from payment where orders_no = ?";
		Object[] data = {ordersNo};
		List<PaymentDto> list = jdbcTemplate.query(sql, paymentMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	@Override
	public List<PaymentDto> selectList() {
		String sql = "select * from payment order by payment_no desc";
		return jdbcTemplate.query(sql, paymentMapper);
	}

	@Override
	public boolean deletePayment(int paymentNo) {
		String sql = "delete payment where paymentNo = ?";
		Object[] data = {paymentNo};
		return jdbcTemplate.update(sql, data) > 0;
	}

}
