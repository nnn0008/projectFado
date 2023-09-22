<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>


<div class="container w-800">
	<div class="row">
		<h1>${mainCommunityDto.mainCommunityNo}번 게시글</h1>
	</div>
	<div>
		<h2>작성자 : ${mainCommunityDto.mainCommunityWriter}</h2>
	</div>
	<div>
		<h2>글제목 : ${mainCommunityDto.mainCommunityTitle}</h2>
	</div>
	<div>
		<h2>글제목 : ${mainCommunityDto.mainCommunityContent}</h2>
	</div>
</div>

	<div class="row">
	<c:if test="${sessionScope.name != null}">
		<a class="btn btn-positive" href="write">
			<i class="fa-solid fa-pen"></i>
			새글
		</a>
		
		<%-- 수정/삭제는 소유자일 경우만 나와야 한다 --%>
		<c:if test="${sessionScope.name == mainCommunityDto.mainCommunityWriter}">
		<a class="btn btn-negative" href="edit?mainCommunityNo=${mainCommunityDto.mainCommunityNo}">
			<i class="fa-solid fa-pen-to-square"></i>
			수정
		</a>
		<a class="btn btn-negative" href="delete?boardNo=${mainCommunityDto.mainCommunityNo}">
			<i class="fa-solid fa-trash"></i>
			삭제
		</a>
		</c:if>
		</c:if>
		<a class="btn" href="list">
			<i class="fa-solid fa-list"></i>
			목록
		</a>
		</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>