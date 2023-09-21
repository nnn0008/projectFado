<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>


<form action="write" method="post" autocomplete="off">
<div>
	<select name="mainCommunityType" required>
		<option selected>Q&A</option>
		<option selected>공지사항</option>
		
	</select>
	<input type="text" name="mainCommunityTitle">
	<input type="text" name="mainCommunityContent">
	<button>작성하기</button>
</div>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>