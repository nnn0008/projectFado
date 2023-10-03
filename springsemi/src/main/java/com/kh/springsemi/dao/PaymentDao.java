package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.OrdersDto;
import com.kh.springsemi.dto.PaymentDto;


public interface PaymentDao {
	
	int sequence();
	void createPayment(PaymentDto paymentDto);
	boolean updatePaymentStatus(PaymentDto paymentDto);
	PaymentDto selectOne(int paymentNo);
	List<PaymentDto> selectList();
	boolean deletePayment(int paymentNo);
}
