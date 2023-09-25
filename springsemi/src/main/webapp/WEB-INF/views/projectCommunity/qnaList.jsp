<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>





<div class="container w-800">

	<div class="row">
		<a class="btn" href="/projectCommunity/noticeList">공지사항</a>
		<a class="btn" style="background-color: #DEF2FF" href="/projectCommunity/qnaList">Q & A</a>
	</div>
	<%-- 글쓰기는 로그인 상태인 경우에만 출력 --%>
	<c:if test="${sessionScope.name != null && sessionScop.level != '관리자'}">
	<div class="row right">
		<a href="write" class="btn btn-positive">
			<i class="fa-solid fa-pen"></i>
			글쓰기
		</a>
	</div>
	</c:if>
	


	
	
	
	
	
	<div class="row">
		<table class="table table-slit">
			<thead>
				<tr>
					<th>번호</th>
					<th>분류</th>
					<th>작성자</th>
					<th width="40%">제목</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="projectCommunityDto" items="${qnaList}">
				<tr>
					<td>${projectCommunityDto.projectCommunityNo}</td>
					<td>${projectCommunityDto.projectCommunityType}</td>
					<td>${projectCommunityDto.getProjectCommunityWriterString()}</td>
					<td align="left">
						
						<!-- 제목을 누르면 상세페이지로 이동 -->
						<a class="link" href="detail?projectCommunityNo=${projectCommunityDto.projectCommunityNo}">
							${projectCommunityDto.projectCommunityTitle}
						</a>
						
					</td>
					<td>${projectCommunityDto.projectCommunityRegDate}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	
	
	
	
	
		<div class="row page-navigator mv-30">
		<!-- 이전 버튼 -->
		<c:if test="${!vo.first}">
			<a href="qnaList?${vo.prevQueryString}">
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
					<a href="qnaList?${vo.getQueryString(i)}">${i}</a> 
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 다음 버튼 -->
		<c:if test="${!vo.last}">
			<a href="qnaList?${vo.nextQueryString}">
				<i class="fa-solid fa-angle-right"></i>
			</a>
		</c:if>
	</div>
	
</div>







<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>