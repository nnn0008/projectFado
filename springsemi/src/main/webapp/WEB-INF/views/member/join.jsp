<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	

<form action="join" method="post"  align="center" >
<h2>회원 가입</h2>
<hr class="w-500">
<br>

	<label>아이디</label>
	<input class="form-input w-300" type="text" name="memberId" placeholder="영문 소문자, 숫자 5~20자" style="font-size: 15px;"><br><br>
	
	<label>비밀번호</label>
	<input class="form-input w-300" type="password" name="memberPw" placeholder="영문,숫자,특수문자 반드시 1개 이상 포함" style="font-size: 15px;"><br><br>
	
	<label>비밀번호 확인</label>
	<input class="form-input w-300" type="password" placeholder="비밀번호 한 번 더 입력" style="font-size: 15px;"><br><br>
	
	<label>닉네임</label>
	<input class="form-input w-300" type="text" name="memberNickname"  placeholder="한글 또는 숫자 2~10자" style="font-size: 15px;"><br><br>
		
	<label>생년월일</label>
    <input class="form-input w-300" type="date" name="memberBirth" style="font-size: 15px;"><br><br>
    
    <label>연락처</label>
    <input class="form-input w-300" type="tel" name="memberContact" placeholder="010XXXXXXXX (- 없이)" style="font-size: 15px;"><br><br>
    
	<label>이메일</label>
    <input class="form-input w-300" type="text" name="memberEmail" placeholder="fado@gmail.com" style="font-size: 15px;"><br><br>

	<button class="btn btn-positive w-500" type="submit">
	가입하기
	</button><br><br>    
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>