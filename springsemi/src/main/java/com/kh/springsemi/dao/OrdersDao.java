package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.OrdersDto;
import com.kh.springsemi.dto.OrdersListDto;

public interface OrdersDao {
	
	int sequence();
	//주문 생성
	void createOrders(OrdersDto ordersDto);
	//상품, 가격 수정
	boolean updateReward(OrdersDto ordersDto);
	//상태 수정
	boolean updateStatus(OrdersDto ordersDto);
	//상세 조회
	OrdersDto selectOne(int ordersNo);
	//전체 조회
	List<OrdersListDto> selectListByOrdersPerson(String ordersPerson);
	//주문 삭제
	boolean deleteOrders(int ordersNo);
	
	int countByProjectNo(int projectNo);
	
	

}
