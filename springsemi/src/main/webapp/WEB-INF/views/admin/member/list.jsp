<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    
    <div class="container w-700">
    <div class="row">
    <h3>전체회원관리 </h3>
    </div>
    
    <div class="row">
    <form action="list" method="post" >
    
   
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
    		</tr>
    		
    		<tbody>
    		<c:forEach var="memberDto" items="${list }">
    			<tr>
    				<td>${memberDto.memberId }</td>
    				<td>${memberDto.memberPw }</td>
    				<td>${memberDto.memberContact }</td>
    				<td>${memberDto.memberEmail }</td>
    				<td>${memberDto.memberBirth }</td>
    				<td>${memberDto.memberLevel }</td>
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
			
		
	</h4>
    </div>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>