<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="change" method="post" autocomplete="off">
	<h1>개인정보 변경</h1>
	
	<label>닉네임</label>
  	<input type="text" name="memberNickname" 
  	 value="${memberDto.memberNickname}" required><br><br>
    	
   	<label>이메일</label>
    <input type="email" name="memberEmail" 
   	 value="${memberDto.memberEmail}" placeholder="testuser@kh.com"><br><br>
           	
    <label>연락처</label>
    <input type="tel" name="memberContact" 
     value="${memberDto.memberContact}" placeholder="- 제외하고 입력"><br><br>
    
    <label>생년월일</label>
    <input type="date" name="memberBirth" value="${memberDto.memberBirth}"><br><br>
	
	<label>비밀번호 확인</label>
    <input type="password" name="memberPw" required><br><br>
    	
    <button type="submit">정보변경</button><br><br>
    
    <c:if test="${param.error != null}">
		<h3>입력하신 비밀번호가 일치하지 않습니다</h3><br><br>
	</c:if>
	
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>