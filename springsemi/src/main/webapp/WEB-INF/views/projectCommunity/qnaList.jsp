<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



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
	<c:if test="${sessionScope.name != null && sessionScop.level != '관리자'}">
	<div class="row right">
		<a href="write" class="btn btn-positive">
			<i class="fa-solid fa-pen"></i>
			글쓰기
		</a>
	</div>
	</c:if>
	



	<div class="container w-600">
            <div class="row">
                <hr>
                <h2>서퍼 Q&A</h2>
                <hr>
            </div>
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
        </div>
	
	
	
	
	<c:forEach var="projectCommunityDto" items="${qnaList}">
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
											<a class="link" href="detail?projectCommunityNo=${projectCommunityDto.projectCommunityNo}">
							${projectCommunityDto.projectCommunityNo}
						</a>

						
					</td>
					<td>${projectCommunityDto.projectCommunityRegDate}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	        </c:forEach>
	
	
	
	
	
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