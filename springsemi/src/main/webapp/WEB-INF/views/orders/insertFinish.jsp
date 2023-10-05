<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.box{
	border: 1px solid #2c8de0; 
	border-radius: 5px;
}
</style>
<script>

</script>
	
<div class="container w-800">

	<div class="row fado mb-50">
		<h2>주문이 완료되었습니다.</h2>
	</div>
	
	<div class="flex-container box ps-50 pe-50 pt-30 pb-30">
		
		<div class="row left fado">
			<div class="mb-10">
				주문자
			</div>
			<div class="mb-10">
				주문금액 
			</div>
			<div class="mb-10">
				주문번호
			</div>
			<div class="mb-10">
				주문한 프로젝트
			</div>
			<div class="mb-10">
				주문한 리워드
			</div>
			<div class="mb-10">
				주문금액
			</div>
			<div class="mb-10">
				결제상태 
			</div>
		</div>
		
		
		<div class="row left ms-80">
			<div class="mb-10">
				${ordersDto.ordersPerson}
			</div>
			<div class="mb-10">
				${ordersDto.ordersPrice}
			</div>
			<div class="mb-10">
				${ordersDto.deliveryNo}
			</div>
			<div class="mb-10">
				${ordersDto.projectNo}
			</div>
			<div class="mb-10">
				${ordersDto.ordersReward}
			</div>
			<div class="mb-10">
				${ordersDto.ordersPrice}
			</div>
			<div class="mb-10">
				${paymentDto.paymentStatus}
			</div>		
		</div>
		
		
	</div>
		
</div>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>