<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    
<div class="container w-800">

	<div class="row mv-40">
		<hr class="hr-style">
		<h1 class="fado">전체회원관리</h1>
		<hr class="hr-style">
	</div>
    
    <div class="row">
    	<form action="list" method="get" >
   
	   <select name="type" class="form-input" style="height:40px;">
			<option value="member_id">아이디 </option>
			<option value="member_nickname">닉네임 </option>
			<option value="member_contact">연락처 </option>
			<option value="member_email">이메일  </option>
			<option value="member_birth">생년월일 </option>
	    </select>
		<input class="form-input w-300" type="search" name="keyword" placeholder="검색어" style="height:40px;"
		vlaue="${vo.keyword }" required>
		<button class="btn btn-positive" width="50" style="height:40px;" >검색 </button>
		
		</form>
	</div>
    		
    		<c:forEach var="memberListDto" items="${list}">
    			<div class="container mt-20 mb-20">
    			
    				<div class="flex-container auto-width left mb-10 w-100">
    					<div style="display:inline;">
    						<div>아이디: ${memberListDto.memberId }</div>
	    				    <div>닉네임: ${memberListDto.memberNickname }</div>
	                        <div>연락처: ${memberListDto.memberContact }</div>
	                        <div>포인트: ${memberListDto.memberPoint}</div>
    					</div>
    					<div style="display:inline;">
    						<div>등급: ${memberListDto.memberLevel }</div>
    						<div>이메일: ${memberListDto.memberEmail }</div>
	    					<div>생년월일: ${memberListDto.memberBirth }</div>
	                        <div>차단여부: ${memberListDto.block}</div>
    					</div>
    					<div style="display:inline;">
    						<div class="container left">
                        	<a href="detail?memberId=${memberListDto.memberId}">상세 </a>
		    				<a href="edit?memberId=${memberListDto.memberId}">수정 </a>
			    				<c:choose>
				    				<c:when test="${memberListDto.block == 'Y'}">
				    				    <a href="cancel?memberId=${memberListDto.memberId}" class="red">해제 </a>
				    				</c:when>
				    				<c:otherwise>
				    					<a href="block?memberId=${memberListDto.memberId}" >차단</a>
				    				</c:otherwise>
			    				</c:choose>
                        	</div>
    					</div>
    				</div>
    				
 				</div>
 				<hr>
    			</c:forEach>
	
	<div class="row">
		<h3>
		<c:if test="${!vo.first }">
			<a href="list?${vo.prevQueryString }">&lt;</a>
		</c:if>
		
		<c:forEach var="i" begin="${vo.begin }" end="${vo.end }" step="1">
			<a href="list?${vo.getQueryString(i)}">${i }</a>
			</c:forEach>

			
				<c:if test="${!vo.last }">
				<a href="list?${vo.nextQueryString }">&gt;</a>
				</c:if>
				
			
		</h3>
		
    </div>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>