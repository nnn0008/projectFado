<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-400">

	<div class="row fado">
		<h1>비밀번호 찾기</h1>
	</div>
	
	<form action ="findPw" method="post">
	
		<div class="row mt-40">
			<input class="form-input w-100" type ="text" name="memberId" placeholder="아이디를 입력해주세요.">
		</div>
		<div class="row mt-20">
			<input class="form-input w-100" type ="email" name="memberEmail" placeholder="가입했던 이메일을 입력해주세요.">
		</div>
		
		<c:if test="${not empty error}">
	        <p style="color: red">${error}</p>
	    </c:if>
	
		<div class="row mt-30">
			<button type="submit" class="btn btn-positive btn-send w-100">비밀번호 찾기</button>
		</div>
		
	</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
