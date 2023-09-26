<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="password" method="post">

	<div class="container w-300">
		<div class="row fado mt-100 mb-30">
			<h1>비밀번호 변경</h1>
		</div>
		
		<div class="row">
			<input class="form-input w-100 mb-10" type="password" name="originPw" 
					required placeholder="기존 비밀번호" style="font-size:15px">
		</div>
		
		<div class="row">
			<input class="form-input w-100" type="password" name="changePw" 
					required placeholder="변경 비밀번호" style="font-size:15px">
		</div>
		
		<div class="row">
				<button class="btn btn-positive w-50 mt-20" type="submit"
					style="font-size:17px">비밀번호 변경</button>
		</div>
		
		<div class="row red">
				<c:if test="${param.error != null}">
					<h3>기존 비밀번호가 일치하지 않습니다.</h3>
				</c:if>
		</div>
	</div>
	
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>