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
		<h2>글내용 : ${mainCommunityDto.mainCommunityContent}</h2>
	</div>
</div>



	<%-- 댓글과 관련된 화면이 작성될 위치 --%>
	<c:if test="${sessionScope.name != null}">
	<div class="row left">
		<form class="reply-insert-form">
			<input type="hidden" name="replyOrigin" value="${mainCommunityDto.mainCommunityNo}">
		
			<div class="row">
				<textarea name="replyContent" class="form-input w-100" rows="4"></textarea>
			</div>
			<div class="row">
				<button class="btn btn-positive w-100">
					<i class="fa-solid fa-pen"></i>
					댓글등록
				</button>
			</div>
		</form>
	</div>
	</c:if>
	
	
	

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
		<c:choose>
			<c:when test="${mainCommunityDto.mainCommunityType == '공지사항'}">
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