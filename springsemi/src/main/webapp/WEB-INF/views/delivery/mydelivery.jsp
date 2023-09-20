<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-500">

	<c:if test="${sessionScope.name != null}">
		<div class="row">
			<h2>배송지 등록이 되어있지 않습니다.</h2><br><br>
			<h3><a href="join">추가하기</a></h3><br><br>
		</div>
	</c:if>
	
	<c:forEach var="deliveryDto" items="${deliveryDto}">
		<div class="row">
			<label>받는 사람</label>
			<span>${deliveryDto.deliveryReceiver}</span>
		</div>
		
		<div class="row">
			<label>우편번호</label>
			<span>${deliveryDto.deliveryPost}</span>
		</div>
		
		<div class="row">
			<label>기본 주소</label>
			<span>${deliveryDto.deliveryAddr1}</span>
		</div>
		
		<div class="row">
			<label>기본 주소</label>
			<span>${deliveryDto.deliveryAddr2}</span>
		</div>
		
		<div class="row">
			<label>받는 사람 연락처</label>
			<span>${deliveryDto.deliveryContact}</span>
		</div>
	</c:forEach>
</div>