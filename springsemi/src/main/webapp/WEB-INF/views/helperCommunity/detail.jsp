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



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>