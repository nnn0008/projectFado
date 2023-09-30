<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



	<div class="container w-600">
           <div class="row">
               <hr>
               <h2>서핑 후기</h2>
               <hr>
           </div>
		<c:forEach var="reviewDto" items="${noticeList}">
           <div class="flex-container">
               <img src="http://dummyimage.com/40X40/000/fff" width="40" height="40">
               <h3>${projectCommunityDto.getProjectCommunityWriterString()}</h3>
           </div>
           <div>
               ${projectCommunityDto.projectCommunityContent}
           </div>
           <div>
           	${projectCommunityDto.projectCommunityRegDate}
           </div>
           <div class="row">
               <button class="btn" href="detail?projectCommunityNo=${projectCommunityDto.projectCommunityNo}"><i class="fa-solid fa-arrow-down"></i> 더보기</button>
           </div>
       </c:forEach>
   </div>
   


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>