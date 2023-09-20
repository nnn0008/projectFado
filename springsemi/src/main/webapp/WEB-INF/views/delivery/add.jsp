<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>배송지 등록</h1>

<form action="add" method="post"  align="center">
	<label>받는 사람</label>
	<input type="text" name="deliveryReceiver" placeholder="받는 분 성함을 입력해주세요."><br><br>
	
	<label>우편번호</label>
	<input type="text" name="deliveryPost" ><br><br>
	
	<label>기본주소</label>
	<input type="text" name="deliveryAddr1" ><br><br>
	
	<label>상세주소</label>
	<input type="text" name="deliveryAddr2" ><br><br>
		
	<label>받는 사람 휴대폰 번호</label>
    <input type="text" name="deliveryContact"><br><br>
    
	<button type="submit">
	등록하기
	</button><br><br>    
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>