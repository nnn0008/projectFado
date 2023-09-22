<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <style>
		.note-editable{
		line-height: 2em !important;
		}
    </style>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>


<script>
	$(function(){
	    $('[name=boardContent]').summernote({
	        placeholder: '내용을 작성하세요',
	        tabsize: 2,
	        height: 300, //에디터 높이
	        minHeight:300, //에디터 최소높이
	        lineHeight: 20, //기본줄간격(px)
	        toolbar: [
	        ['style', ['style']],
	        ['font', ['bold', 'underline', 'italic']],
	        ['color', ['color']],
	        ['para', ['paragraph']],
	        ['table', ['table']],
	        ['insert', ['link']],
	        ]
	    });
	});

</script>

<form action="edit" method="post">
<input type="hidden" name="mainCommunityNo" value="${mainCommunityDto.mainCommunityNo}">

<div class="container w-600">
	<div class="row">
		<h1>게시글 수정</h1>
	</div>
	
	<div class="row left">
		<label>제목</label>
		<input class="form-input w-100" type="text" name="mainCommunityTitle" value="${mainCommunityDto.mainCommunityTitle}" required>
	</div>
	
	<div class="row left">
		<label>내용</label>
		<textarea class="form-input w-100" name="mainCommunityContent" 
			style="min-height:250px" required>${mainCommunityDto.mainCommunityContent}</textarea>
	</div>
	
	<div class="row right">
		<a href="list" class="btn">
			<i class="fa-solid fa-list"></i>
			목록
		</a>
		<button type="submit" class="btn btn-positive">
			<i class="fa-solid fa-edit"></i>
			수정
		</button>
	</div>
</div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>