<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="password" method="post">
	<h1>비밀번호 변경</h1>
	
	<label>기존 비밀번호</label>
	<input type="password" name="originPw" required><br><br>
	
	<label>변경 비밀번호</label>
	<input type="password" name="changePw" required><br><br>
	
	<button type="submit">비밀번호 변경</button><br><br>
	
	<c:if test="${param.error != null}">
		<h3>기존 비밀번호가 일치하지 않습니다</h3><br><br>
	</c:if>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>