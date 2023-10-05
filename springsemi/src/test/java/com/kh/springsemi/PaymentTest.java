package com.kh.springsemi;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class PaymentTest {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	int projectNo = 158;
	
	@Data @Builder @NoArgsConstructor @AllArgsConstructor
	static class OrdersMemberDto {
		private String memberId;
		private int memberPoint;
		private int ordersNo;
		private int ordersPrice;
		private String ordersStatus;
	}
	RowMapper<OrdersMemberDto> mapper = (rs, idx)->{
		return OrdersMemberDto.builder()
					.memberId(rs.getString("member_id"))
					.memberPoint(rs.getInt("member_point"))
					.ordersNo(rs.getInt("orders_no"))
					.ordersPrice(rs.getInt("orders_price"))
					.ordersStatus(rs.getString("orders_status"))
				.build();
	};
	
	@Test
	public void test() {
		//특정 번호의 프로젝트에 참여중인 포인트가 충분한 사람 조회
		String sql = "select * from member M "
				+ "inner join orders O on M.member_id= O.orders_person "
				+ "inner join project P on O.project_no = P.project_no "
				+ "where "
					+ "O.project_no = ? "
					+ "and "
					+ "O.orders_status = '펀딩참여중' "
					+ "and "
					+ "O.orders_price <= M.member_point "
					+ "and "
					+ "P.project_goal_price >= P.project_total_price";
		Object[] data = {projectNo};
		List<OrdersMemberDto> list = jdbcTemplate.query(sql, mapper, data);
		log.debug("list size = {}", list.size());
		//assertNotEquals(0, list.size());
		
		for(OrdersMemberDto dto : list) {
			//결제 등록
			sql = "insert into payment(payment_no, orders_no, payment_status, payment_date) values(payment_seq.nextval, ?, '결제완료', sysdate)";
			data = new Object[] {dto.getOrdersNo()};
			jdbcTemplate.update(sql, data);
			
			//포인트 차감 처리
			sql = "update member set member_point = member_point - ? where member_id = ?";
			data = new Object[]{dto.getOrdersPrice(), dto.getMemberId()};
			jdbcTemplate.update(sql, data);
		}
	}
	
}
