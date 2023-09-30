package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.dto.DeliveryDto;

@Component
public class DeliveryMapper implements RowMapper<DeliveryDto> {

	@Override
	public DeliveryDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		DeliveryDto deliveryDto = new DeliveryDto();
		deliveryDto.setDeliveryNo(rs.getInt("delivery_no"));
		deliveryDto.setMemberId(rs.getString("member_id"));
		deliveryDto.setDeliveryReceiver(rs.getString("delivery_receiver"));
		deliveryDto.setDeliveryPost(rs.getString("delivery_post"));
		deliveryDto.setDeliveryAddr1(rs.getString("delivery_addr1"));
		deliveryDto.setDeliveryAddr2(rs.getString("delivery_addr2"));
		deliveryDto.setDeliveryContact(rs.getString("delivery_contact"));
		return deliveryDto;
	}

}
