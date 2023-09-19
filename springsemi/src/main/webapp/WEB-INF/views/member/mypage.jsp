<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>${memberDto.memberId}님의 회원 정보</h1>

<table border="1" width="500">
	<tr>
		<th>닉네임</th>
		<td>${memberDto.memberNickname}</td>
	</tr>
	
	<tr>
		<th>이메일</th>
		<td>${memberDto.memberEmail}</td>
	</tr>
	
	<tr>
		<th>연락처</th>
		<td>${memberDto.memberContact}</td>
	</tr>
	
	<tr>
		<th>생년월일</th>
		<td>${memberDto.memberBirth}</td>
	</tr>
	
	<tr>
		<th>등급</th>
		<td>${memberDto.memberLevel}</td>
	</tr>
	
	<tr>
		<th>포인트</th>
		<td>${memberDto.memberPoint}pt</td>
	</tr>
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>