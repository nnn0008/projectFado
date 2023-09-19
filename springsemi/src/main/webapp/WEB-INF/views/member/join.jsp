<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form>
	<label>아이디</label>
	<input type="text" name="memberId" placeholder="영문 소문자, 숫자 5~20자">
	
	<label>비밀번호</label>
	<input type="password" name="memberPw" placeholder="영문,숫자,특수문자 반드시 1개 이상 포함">
	
	<label>비밀번호 확인</label>
	<input type="password" placeholder="비밀번호 한 번 더 입력">
	
	<label>닉네임</label>
	<input type="text" name="memberNickname"  placeholder="한글 또는 숫자 2~10자">
		
	<label>생년월일</label>
    <input type="date" name="memberBirth">
    
    <label>연락처</label>
    <input type="tel" name="memberContact" placeholder="010XXXXXXXX (- 없이)">
    
	<label>이메일</label>
    <input type="text" name="memberEmail" placeholder="fado@gmail.com">

	<button type="submit">
	가입하기
	</button>    
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>