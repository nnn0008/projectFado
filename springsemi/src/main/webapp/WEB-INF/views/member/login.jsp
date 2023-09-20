<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="login" method="post" autocomplete="off">

<div class="row">
	<h3>로그인 </h3>
	
	<hr class="w-500">
	<br>
	<input class="form-input w-400" type="text" name="memberId" placeholder="아이디" required><br><br>
	
	<input class="form-input w-400" type="password" name="memberPw"  placeholder="비밀번호" required><br><br>
	
	<button type="submit" class="btn btn-positive w-400">Login</button><br><br>
	
	<a href="findPw" class="link">비밀번호 찾기</a><br><br>
	
	<c:if test="${param.error != null}">
		<h3>아이디 또는 비밀번호가 일치하지 않습니다</h3> 
	</c:if>
	
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>