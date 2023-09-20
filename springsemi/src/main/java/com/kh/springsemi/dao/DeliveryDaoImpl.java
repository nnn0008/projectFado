package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springsemi.dto.DeliveryDto;
import com.kh.springsemi.mapper.DeliveryMapper;

@Repository
public class DeliveryDaoImpl implements DeliveryDao{
	
	@Autowired 
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private DeliveryMapper deliveryMapper;
	
	//배송지 번호 시퀀스
	@Override
	public int sequence() {
		String sql = "select delivery_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	//배송지 등록
	@Override
	public void insert(DeliveryDto deliveryDto) {
		String sql = "insert into delivery("
				+ "delivery_no, delivery_member, delivery_receiver, delivery_post, "
				+ "delivery_addr1, delivery_addr2, delivery_contact"
				+ ") values(?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				deliveryDto.getDeliveryNo(), deliveryDto.getDeliveryMember(), deliveryDto.getDeliveryReceiver(),
				deliveryDto.getDeliveryPost(), deliveryDto.getDeliveryAddr1(), deliveryDto.getDeliveryAddr2(),
				deliveryDto.getDeliveryContact()
		};
		jdbcTemplate.update(sql, data);
	}

//	//배송지 수정
//	@Override
//	public boolean update(DeliveryDto deliveryDto) {
//		String sql = "update delivery set delivery_receiver=?, delivery_post=?, "
//				+ "delivery_addr1=?, delivery_addr2=?, delivery_contact=? "
//				+ "where delivery_no=?";
//		Object[] data = {
//				deliveryDto.getDeliveryReceiver(), deliveryDto.getDeliveryPost(), deliveryDto.getDeliveryAddr1(), 
//				deliveryDto.getDeliveryAddr2(), deliveryDto.getDeliveryContact(), deliveryDto.getDeliveryNo()
//		};
//		return jdbcTemplate.update(sql, data) > 0;
//	}
	
	//배송지 목록
	@Override
	public List<DeliveryDto> selectList(@RequestParam String deliveryMember) {
		String sql = "select * from delivery where delivery_member = ? ";
		Object[] data = {deliveryMember};
		return jdbcTemplate.query(sql, deliveryMapper, data);
	}
	
	//배송지 삭제
	@Override
	public boolean delete(int deliveryNo) {
		String sql = "delete delivery where delivery_no=?";
		Object[] data = {deliveryNo};
		return jdbcTemplate.update(sql,data) > 0;
	}

}
