<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


 	
	
	
	
<div class="container w-600">
    <div class="row">
        <hr>
        <h2>서퍼 공지 업데이트</h2>
        <hr>
    </div>
	<c:forEach var="projectCommunityDto" items="${noticeList}">
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
	
	


		<div class="row page-navigator mv-30">
		<!-- 이전 버튼 -->
		<c:if test="${!vo.first}">
			<a href="noticeList?${vo.prevQueryString}">
				<i class="fa-solid fa-angle-left"></i>
			</a>
		</c:if>
		
		<!-- 숫자 버튼 -->
		<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
			<c:choose>
				<c:when test="${vo.page == i}">
					<a class="on">${i}</a>
				</c:when>
				<c:otherwise>
					<a href="noticeList?${vo.getQueryString(i)}">${i}</a> 
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 다음 버튼 -->
		<c:if test="${!vo.last}">
			<a href="noticeList?${vo.nextQueryString}">
				<i class="fa-solid fa-angle-right"></i>
			</a>
		</c:if>
	</div>
	
	<!-- 검색창 -->
	<form action="noticeList" method="get">
	<div class="row">
		
		<input type="search" name="keyword"  required class="form-input"
					placeholder="검색어 입력" value="${param.keyword}">
		<button type="submit" class="btn btn-positive">
			<i class="fa-solid fa-magnifying-glass"></i>
			검색
		</button>
	</div>
	</form>




 



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>