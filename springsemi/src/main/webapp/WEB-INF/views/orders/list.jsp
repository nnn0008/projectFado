<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.box{
	border: 1px solid #2c8de0; 
	border-radius: 5px;"
}
</style>

<div class="container w-800">

	<div class="row fado mb-50">
		
		<h1><i class="fa-solid fa-water me-10"></i>내가 서핑한 파도<i class="fa-solid fa-water ms-10"></i></h1>
	</div>
	
	<c:forEach var="ordersListDto" items="${ordersList}">
		<div class="left box mt-20 mb-20 ps-30 pe-30 pt-40 pb-40">
		
			<div class="flex-container auto-width"  style="font-size:13px; color:#b2bec3;">
				<div>
					<label>주문번호 ${ordersListDto.ordersNo}</label>
				</div>
					<a href="/project/detail?projectNo=${ordersListDto.projectNo}" 
					class="right " style="font-size:15px; color:#b2bec3;"> > 보러가기 </a>
			</div>
			<div class="bold" style="font-size:21px">
				${ordersListDto.projectTitle}
			</div>
			
			<div class="flex-container">
				<div class="me-10">
				 	${ordersListDto.ordersReward} 
				</div>
				<div class="me-10">
					|
				</div>
				<div>
					${ordersListDto.ordersPrice}원
				</div>
			</div>
			
			<div class="left flex-container mt-20" style="flex-grow: 3;">
				<div class="me-20 fado">
					${ordersListDto.ordersStatus}
				</div>
				<div class="red">
					${ordersListDto.paymentStatus}
				</div>
			</div>
		
		</div>
	</c:forEach>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>