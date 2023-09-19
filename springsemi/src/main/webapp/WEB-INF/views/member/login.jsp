<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="login" method="post" autocomplete="off">

	<h1>로그인</h1>
	
	<input type="text" name="memberId" placeholder="아이디" required><br><br>
	
	<input type="password" name="memberPw"  placeholder="비밀번호" required><br><br>
	
	<button type="submit" class="btn btn-positive w-100">Login</button><br><br>
	
	<a href="findPw" class="link">비밀번호 찾기</a><br><br>
	
	<c:if test="${param.error != null}">
		<h3>아이디 또는 비밀번호가 일치하지 않습니다</h3> 
	</c:if>
	
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>