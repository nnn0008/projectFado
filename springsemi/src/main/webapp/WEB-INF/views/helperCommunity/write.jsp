<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">


    <style>
	.note-editable{
	line-height: 2em !important;
	}
    </style>
    
    
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script src="/js/boardWrite.js"></script>

<script>
	$(function(){
	    $('[name=mainCommunityContent]').summernote({
	        placeholder: '내용을 작성하세요',
	        tabsize: 2,
	        height: 300, //에디터 높이
	        minHeight:300, //에디터 최소높이
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



<form action="write" method="post" autocomplete="off">
<div class="container w-600">
	<div>
		<select name="mainCommunityType" required>
			<option selected>Q&A</option>
			<option selected>공지사항</option>
		</select>
	</div>
	<div>
		<input type="text" class="form-input w-100 mb-20" name="mainCommunityTitle" placeholder="제목을 입력해주세요">
	</div>
	<div>
		<textarea name="mainCommunityContent"></textarea>
	</div>
	<div class="right">
		<button class="btn btn-positive">작성하기</button>
	</div>
</div>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>