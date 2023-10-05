<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-600">
	
	<div class="row">
		주문자 : ${ordersDto.ordersPerson}
	</div>
	<div class="row">
		주문금액 : ${ordersDto.ordersPrice}
		주문번호 : ${ordersDto.deliveryNo}
		주문한 프로젝트 : ${ordersDto.projectNo}
		주문한 리워드 : ${ordesDto.ordersReward}

	</div>
	<a href="detail?ordersNo=${ordersDto.ordersNo}"></a>

</div>






<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>