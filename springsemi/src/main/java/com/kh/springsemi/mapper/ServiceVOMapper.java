package com.kh.springsemi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.springsemi.vo.ServiceVO;
@Component
public class ServiceVOMapper implements RowMapper<ServiceVO>{
	@Override
	public ServiceVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		ServiceVO serviceVO = new ServiceVO();
		
		serviceVO.setMemberId(rs.getString("member_id"));
		serviceVO.setMemberPoint(rs.getInt("member_point"));
		serviceVO.setOrdersNo(rs.getInt("orders_no"));
		serviceVO.setOrdersPrice(rs.getInt("orders_price"));
		serviceVO.setOrdersStatus(rs.getString("orders_status"));

		return serviceVO;
	}
	
}
