<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    <div class="container w-700">
    	<div class="row">
    		<h3>${memberDto.memberId }서퍼님 회원정보 </h3>
    	</div>
    	
    	<div class="left">
    		<table class="table table-border table-stripe">
	    		<tr>
	    			<th>닉네임 </th>
	    			<td>${memberDto.memberNickname}</td>
	    		</tr>
    			
    			<tr>
    				<th>생년월일 </th>
    				<td>${memberDto.memberBirth}</td>
    			</tr>
    			
    			<tr>
    				<th>연락처 </th>
    				<td>${memberDto.memberContact }</td>
    			</tr>
    			
    			<tr>
    				<th>이메일 </th>
    				<td>${memberDto.memberEmail }</td>
    			</tr>
    			
    			<tr>
    				<th>포인트 </th>
    				<td>${memberDto.memberPoint }</td>
    			<%-- 	<fmt:formatNumber value="${memberDto.memberPoint}" 
			pattern="#,##0"></fmt:formatNumber> pt
			</td> --%>
    			</tr>
    			
    			
    			<tr>
    				<th>등급 </th>
    				<td>${memberDto.memberLevel }</td>
    			</tr>
    			
    			<tr>
    				<th>우편번호 </th>
    				<td>${Delivery.diliveryPost}</td>
    			</tr>
    			
    			<tr>
    				<th>주소  </th>
	    				<td>
	    				${Delivery.diliveryAddr1}
	    				${Delivery.diliveryAddr2}
	    				</td>
    			</tr>
    		
    			<%--
    				관리자가 일반 회원들의 어떤 정보를 더 필요로 할까? 
    			  --%>
    		
    			
    		</table>
    	</div>
    </div>
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>