package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.OrdersDto;
import com.kh.springsemi.dto.PaymentCheckDto;
import com.kh.springsemi.dto.PaymentDto;


public interface PaymentDao {
	
	int sequence();
	void createPayment(PaymentDto paymentDto);
	boolean updatePaymentStatus(String status, int paymentNo);
//	PaymentDto selectOne(int paymentNo);
	PaymentDto selectOneByOrdersNo(int ordersNo);
	List<PaymentDto> selectList();
	boolean deletePayment(int paymentNo);
//	PaymentCheckDto selectOne(int paymentNo);
	List<PaymentCheckDto> selectListOverPaymentDate();
	boolean successPayment();
	boolean failPayment();
}
