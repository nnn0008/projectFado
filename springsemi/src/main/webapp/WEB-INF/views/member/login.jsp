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
			<input class="form-input w-100" type="text" name="memberId" placeholder="아이디" required style="font-size: 15px;">
		</div>
		
		<div class="row">
			<input class="form-input w-100" type="password" name="memberPw"  placeholder="비밀번호" required style="font-size: 15px;">
		</div>
		
		<div class="row red">
			<c:if test="${param.error != null}">
				<label>아이디 또는 비밀번호가 일치하지 않습니다.</label> 
			</c:if>
		</div>
		
		<div class="row mt-30">
			<button type="submit" class="btn btn-positive w-100">로그인</button>
		</div>
		
		<div class="row" style="font-size: 15px;">
		아직 회원이 아니신가요? <a href="join">회원가입</a>
		</div>
		
		<div class="row" style="font-size: 15px;">
			비밀번호를 잊어버리셨나요? <a href="findPw">비밀번호 찾기</a>
		</div>
		
	</div>
	
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>