<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="login" method="post" autocomplete="off">

	<div class="container w-400">
		<div class="row fado">
			<h2>로그인</h2>
		</div>
		
		<hr class="hr-style">
		
		<div class="row">
			<input class="form-input w-100" type="text" name="memberId" placeholder="아이디" required>
		</div>
		
		<div class="row">
			<input class="form-input w-100" type="password" name="memberPw"  placeholder="비밀번호" required>
		</div>
		
		<div class="row">
			<c:if test="${param.error != null}">
				<h3>아이디 또는 비밀번호가 일치하지 않습니다.</h3> 
			</c:if>
		</div>
		
		<div class="row mt-30">
			<button type="submit" class="btn btn-positive w-100">로그인</button>
		</div>
		
		<div class="row">
			<a href="findPw" class="link">비밀번호 찾기</a>
		</div>
		
	</div>
	
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>