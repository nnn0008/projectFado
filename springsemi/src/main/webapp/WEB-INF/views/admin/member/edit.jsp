<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    <div class="row">
    <h3>회원정보 변경 </h3>
    </div>
    <form action="edit" method="post">
    <input type="hidden" name="memberId" value="${memberDto.memberId}">
    
    	<div class="container w-600">
    		<div class=row>
    			닉네임 <input type="text" name="memberNickname" value="${memberDto.memberNickname }" required>
    		</div>
    	
    		<div class=row>
    			생년월일 <input type="date" name="memberBirth" value="${ memberDto.memberBirth}">
    		</div>
    	
    		<div class="row">
   				연락처 <input type="tel" name="memberContact" value="${memberDto.memberContact }">
   			</div>
   		
   			<div class=row>
   				이메일 <input type="email" name="memberEmail" value="${memberDto.memberEmail }">
   			</div>
   	
   			<div class=row>
    			포인트 <input type="number" name="memberPoint" value="${memberDto.memberPoint }" >
    		</div>
    
    		<div class=row>	
			    등급 
			    <c:choose>
			    	<c:when test="${memberDto.memberLevel == '구매자' }">
			    	<input type="radio" name="memberLevel"  value="구매자" checked>구매자 
			    	<input type="radio" name="memberLevel"  value="판매자" >판매자
			    	</c:when>
			    	
			    	<c:when test="${memberDto.memberLevel == '판매자' }">
			    	<input type="radio" name="memberLevel"  value="구매자" >구매자 
			    	<input type="radio" name="memberLevel"  value="판매자" checked>판매자
			    	</c:when>
			    </c:choose>
			     	 
    		</div>
    	
    	<%-- <div class=row>
		    주소 <input 	type="text" name="memberpost" placeholder="우편번호" value="${delivery.diliveryPost }"
		    			type="text" name="memberAddr1" placeholder="기본주소" value="${Delivery.diliveryAddr1}"
		    			type="text" name="memberAddr1" placeholder="기본주소" value="${Delivery.diliveryAddr1}">
    		</div> --%>
    
    		<div class="row">
    		<button type=submit>정보변경 </button>
    		</div>
    </div>
    
    </form>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>