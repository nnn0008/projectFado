package com.kh.springsemi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springsemi.dto.OrdersDto;
import com.kh.springsemi.mapper.OrdersMapper;

@Repository
public class OrdersDaoImpl implements OrdersDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private OrdersMapper ordersMapper;

	@Override
	public int sequence() {
		String sql = "select orders_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void createOrders(OrdersDto ordersDto) {
		String sql = "insert into orders"
				+ "(orders_no, orders_person, project_no, delivery_no, orders_reward, orders_price)"
				+ " values(?, ?, ?, ?, ?, ?)";
		Object[] data = {ordersDto.getOrdersNo(), ordersDto.getOrdersPerson(), ordersDto.getProjectNo(),
								ordersDto.getDeliveryNo(), ordersDto.getOrdersReward(), ordersDto.getOrdersPrice()
								};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean updateReward(OrdersDto ordersDto) {
		String sql = "update orders set orders_reward=?, orders_price=? where orders_no=?";
		Object[] data = {ordersDto.getOrdersReward(), ordersDto.getOrdersPrice(), ordersDto.getOrdersNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public boolean updateStatus(OrdersDto ordersDto) {
		String sql = "update orders set orders_status=? where orders_no=?";
		Object[] data = {ordersDto.getOrdersStatus(), ordersDto.getOrdersNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public OrdersDto selectOne(int ordersNo) {
		String sql ="select * from orders where orders_no = ?";
		Object[] data = {ordersNo};
		List<OrdersDto> list = jdbcTemplate.query(sql, ordersMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<OrdersDto> selectList() {
		String sql = "select * from orders_list where member_id =? order by orders_no desc";
		return jdbcTemplate.query(sql, ordersMapper);
	}
	
	@Override
	public boolean deleteOrders(int ordersNo) {
		String sql = "delete orders_list where orders_no = ?";
		Object[] data = {ordersNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
}
