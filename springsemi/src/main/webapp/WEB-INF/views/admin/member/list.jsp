<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    
    <div class="container w-800">
    <div class="row mv-40">
    	<h3>전체회원관리 </h3>
    </div>
    
    <div class="row">
    <form action="list" method="get" >
				
   
   <select name="type" class="form-input">
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
    
    <table border="1" width="800">
    	<thead>
    		<tr>
    			<th>아이디 </th>
    			<th>닉네임 </th>
    			<th>연락처 </th>
    			<th>이메일 </th>
    			<th>생년월일 </th>
    			<th>등급</th>
    			<th>차단여부 </th>
    			<th>메뉴</th>
    		</tr>
    		
    		<tbody align="center">
    		<c:forEach var="memberListDto" items="${list}">
    			<tr>
    				<td>${memberListDto.memberId }</td>
    				<td>${memberListDto.memberNickname }</td>
    				<td>${memberListDto.memberContact }</td>
    				<td>${memberListDto.memberEmail }</td>
    				<td>${memberListDto.memberBirth }</td>
    				<td>${memberListDto.memberLevel }</td>
    				<td>${memberListDto.block}</td>
    			<td>
    			
    			
    			<a href="detail?memberId=${memberListDto.memberId}">상세 </a>
    			<a href="edit?memberId=${memberListDto.memberId}">수정 </a>
    			
    			<c:choose>
    				<c:when test="${memberListDto.block == 'Y'}">
    				    <a href="cancel?memberId=${memberListDto.memberId}">해제 </a>
    				</c:when>
    				<c:otherwise>
    					<a href="block?memberId=${memberListDto.memberId}">차단</a>
    				</c:otherwise>
    			</c:choose>
    			
    			
    			</td>	
    			</tr>
    			
    			</c:forEach>
    		</tbody>
    		
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
			
		
	</h4>
    </div>
    </div>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>