package com.kh.springsemi.dao;

import java.util.List;

import com.kh.springsemi.dto.DeliveryDto;

public interface DeliveryDao {
	
	//배송지번호 시퀀스
	int sequence();
	//C - 배송지 등록
	void insert(DeliveryDto deliveryDto);
	//R - 배송지 리스트
	List<DeliveryDto> selectList(String deliveryMember);
	//U - 배송지 수정
//	boolean update(DeliveryDto deliveryDto); 
	//D - 배송지 삭제
	boolean delete(int deliveryNo);

}
