<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FADO</title>

<link rel="shortcut icon" href="/images/favicon.ico">
<!-- css 파일을 불러오는 코드 -->
<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- 구글 웹 폰트 사용을 위한 CDN -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="/css/commons.css">

<style>
</style>

<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


<!-- easytimer.js -->

<script src="/js/easytimer.min.js"></script>
<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/moment-duration-format@2.3.2/lib/moment-duration-format.min.js"></script>


</head>
<body>
   <main>
        <header>
        
        <div class="logo">
           <a href="/">
           <img src="/images/fado.jpg" width="200" height="180" >
           </a>
        </div>
         
        <div class="login right">
        <c:choose>
      <c:when test="${sessionScope.name != null}">
         <li><a href="/member/mypage">회원상세</a></li>
          <li><a href="/member/change">회원정보수정</a></li>
           <li><a href="/member/logout">로그아웃</a></li>
       
       
       <%-- 관리자인 경우 추가 메뉴 출력  --%>
       <c:if test="${session.Scope.level == '관리자'  }">
          <li><a href="/admin/home">관리자메뉴 </a></li>
          </c:if>
          
       
   </c:when>
   <c:otherwise>
      <!-- <li><a href="/">Home</a></li> -->
      <li><a href="/member/login">로그인</a></li>
      <li><a href="/member/join">회원가입</a></li>
   </c:otherwise>
</c:choose>
        
        </div>
        
        <hr>
        
        
      </header>
   <nav>
   
    <ul class="menu left">
   <c:choose>
      <c:when test="${sessionScope.name != null}">
         <li><a href="/member/mypage">회원상세</a></li>
         <li><a href="/member/change">회원정보수정</a></li>
         <li><a href="/helperCommunity/noticeList">공지사항</a></li>
         <li><a href="/projectCommunity/noticeList">공지사항</a></li>
          <!-- <li><a href="/member/logout">로그아웃</a></li> -->
       </ul>
       
    
       <c:if test="${session.Scope.level == '관리자'  }">
          <li><a href="/admin/home">관리자메뉴 </a></li>
          </c:if>
          
       
   </c:when>
   <c:otherwise>
      <i class="fa-solid fa-bars" style="color: #black;" ></i>
      <li><a href="/">Home</a></li>
      <li><a href="/member/login">로그인</a></li>
      <li><a href="/member/join">회원가입</a></li>
   </c:otherwise>
</c:choose>
                                 
  </nav>
        <section>
	<main>
        <header>
        <div class="logo">
        	<a href="/">
        	<img src="/images/fado.jpg" width="200" height="180" >
        	</a>
        </div>
        
        <!-- <li><a href="#">회원상세</a></li>
	    			<li><a href="#">회원정보수정</a></li>
	    		 	<li><a href="#">로그아웃</a></li> -->
         
   
        
				<ul class="menu"> 
				 <c:choose>
				<c:when test="${sessionScope.name != null}"> 
				
				<ul>
					<li>
						<a href="#">카테고리 </a>
						
						<li><a href="">전체</a></li>
						<li><a href="">가전</a></li>
						<li><a href="">의류</a></li>
						<li><a href="">푸드</a></li>
					</ul>
					
					<li class="menu-right">
							<a href="member/mypage">마이페이지</a>
						</li>
						<li><a href="/member/logout">로그아웃</a></li>
						
						
						
						
							<c:if test="${sessionScope.level == '관리자' }">
								<li><a href="/admin/home">관리자메뉴</a></li>
							</c:if>
						</ul>
					</li>
					
			</c:when>
    			<c:otherwise>
    				<li>
						<a href="#">카테고리 </a>
					<ul>
						
						<li><a href="">전체</a></li>
						<li><a href="">가전</a></li>
						<li><a href="">의류</a></li>
						<li><a href="">푸드</a></li>
						<li><a href="/project/list">펀딩 </a></li>
					</ul>	
					
					
					
					<ul>	
							<li class="menu-right">
			                <a href="/member/login">로그인</a>
			                <li><a href="/member/join">회원가입</a></li>
					</ul>		
				</li>
					
		</c:otherwise>
    </c:choose>
    </ul>
    	  	
  </nav>
        <section>