<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>


<div class="container w-800">
	<div class="row">
		<h1>${projectCommunityDto.projectCommunityNo}번 게시글</h1>
	</div>
	<div>
		<h2>작성자 : ${projectCommunityDto.projectCommunityWriter}</h2>
	</div>
	<div>
		<h2>글제목 : ${projectCommunityDto.projectCommunityTitle}</h2>
	</div>
	<div>
		<h2>글제목 : ${projectCommunityDto.projectCommunityContent}</h2>
	</div>
</div>

	<div class="row">
	<c:if test="${sessionScope.name != null}">
		<a class="btn btn-positive" href="write">
			<i class="fa-solid fa-pen"></i>
			새글
		</a>
		
		<%-- 수정/삭제는 소유자일 경우만 나와야 한다 --%>
		<c:if test="${sessionScope.name == projectCommunityDto.projectCommunityWriter}">
		<a class="btn btn-negative" href="edit?projectCommunityNo=${projectCommunityDto.projectCommunityNo}">
			<i class="fa-solid fa-pen-to-square"></i>
			수정
		</a>
		<a class="btn btn-negative" href="delete?boardNo=${projectCommunityDto.projectCommunityNo}">
			<i class="fa-solid fa-trash"></i>
			삭제
		</a>
		</c:if>
		</c:if>
		<c:choose>
			<c:when test="${projectCommunityDto.projectCommunityType == '공지사항'}">
				<a href="noticeList" class="btn">
					<i class="fa-solid fa-list"></i>목록
				</a>
			</c:when>
			<c:otherwise>
				<a href="qnaList" class="btn">
					<i class="fa-solid fa-list"></i>목록
				</a>
			</c:otherwise>
		</c:choose>
		</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>