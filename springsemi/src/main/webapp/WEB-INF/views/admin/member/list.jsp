<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    
    <div class="container w-700">
    <div class="row">
    <h3>전체회원관리 </h3>
    </div>
    
    <div class="row">
    <form action="list" method="get" >
    
   
    <select name="type" class="form-input" height="300" >
	<option value="member_id">아이디 </option>
	<option value="member_nickname">닉네임 </option>
	<option value="member_contact">연락처 </option>
	<option value="member_email">이메일  </option>
	<option value="member_birth">생년월일 </option>
    </select>
  
    
    
    <input class="form-input w-300" type="search" name="keyword" placeholder="검색어" 
    vlaue="${vo.keyword }" required>
    <button class="btn btn-positive" width="50" >검색 </button>
    </form>
    
    <br>
    
    <table border="1" width="700">
    	<thead>
    		<tr>
    			<th>아이디 </th>
    			<th>닉네임 </th>
    			<th>연락처 </th>
    			<th>이메일 </th>
    			<th>생년월일 </th>
    			<th>등급</th>
    			<th>상세 </th>
    			<th>차단여부 </th>
    		</tr>
    		
    		<tbody>
    		<c:forEach var="memberListDto" items="${list }">
    			<tr>
    				<td>${memberListDto.memberId }</td>
    				<td>${memberListDto.memberNickname }</td>
    				<td>${memberListDto.memberContact }</td>
    				<td>${memberListDto.memberEmail }</td>
    				<td>${memberListDto.memberBirth }</td>
    				<td>${memberListDto.memberLevel }</td>
    				<td>${memberListDto.memberBlock }</td>
    			<td>
    			<a href="detail?memberId=${memberListDto.memberId }">상세 </a>
    			<a href="edit?memberId=${memberListDto.memberId }">수정 </a>
    			
    			
    			<c:choose>
    				<c:when test="${memberListDto.block == 'Y'}">
    					<a href="cancle?memberId=${memberListDto.memberId }"></a>
    				</c:when>
    				<c:otherwise>
    					<a href="block?memberId=${memberListDto.memberId }"></a>
    				</c:otherwise>
    			</c:choose>
    			</td>	
    			</tr>
    			
    			</c:forEach>
    		</tbody>
    		
    	</thead>
    </table>
	
	<br>
	
	<h4>
	<c:if test="${!vo.first }">
		<a href="list?${vo.prevQueryString }">&lt;</a>
	</c:if>
	
	<c:forEach var="i" begin="${vo.begin }" end="${vo.end }" step="1">
		<a href="list?${vo.getQueryString(i)}">${i }</a>
		</c:forEach>
		
		
		
			<c:if test="${!vo.last }">
			<a href="list?${vo.nextQueryString }">&gt;</a>
			</c:if>
			
		<%-- 
			 내가 팔로우 하는사람 
    			 나를 팔로우 하는사람 
    			 내가 좋아요 누른 상품 
    			 성공한 펀딩 
		--%>
		
	</h4>
    </div>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>