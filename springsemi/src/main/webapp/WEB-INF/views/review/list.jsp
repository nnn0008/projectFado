<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">


    
    <!-- 여기서부터 list 추가한거 있어요 -->
    <div class="row">
	<hr>
	</div>

	<div class="container w-800">

	<div class="row">
		<a class="btn" href="/projectCommunity/noticeList?projectNo=${projectDto.projectNo}">공지사항</a>
		<a class="btn" href="/projectCommunity/qnaList?projectNo=${projectDto.projectNo}">Q & A</a>
		<a class="btn" href="/review/list?projectNo=${projectDto.projectNo}">후기</a>
	</div>
	<%-- 글쓰기는 로그인 상태인 경우에만 출력 --%>
		<c:if test="${sessionScope.name != null && sessionScope.level == '구매자'}">
		    <div class="row right">
		        <a href="/projectCommunity/write?projectNo=${projectDto.projectNo}" class="btn btn-positive">
		            <i class="fa-solid fa-pen"></i>
		            글쓰기
		        </a>
		    </div>
		</c:if>
	

	<div class="container w-600">
           <div class="row">
               <hr>
               <h2>서핑 후기</h2>
               <hr>
           </div>
		<c:forEach var="reviewListDto" items="${reviewList}">
           <div class="flex-container">
           <c:choose>
				<c:when test="${reviewDto.reviewPhoto}">           
               		<img src="reviewPhoto?reviewNo=${reviewDto.reviewNo}" width="40" height="40">
          		</c:when> 
          		<c:otherwise>
          			<img src="/images/smallfado.jpg" width="40" height="40">
          		</c:otherwise>
          		
           </c:choose>
               <h3>${reviewListDto.getReviewWriterString()}</h3>
           </div>
           <div>
               ${reviewListDto.reviewContent}
           </div>
           <div>
           	${reviewListDto.reviewRegDate}
           </div>

       </c:forEach>
   </div>
   


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>