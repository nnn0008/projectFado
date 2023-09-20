<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script>
$(function () {
    $('[name=projectContent]').summernote({
      placeholder: '내용을 작성하세요',
      tabsize: 2, //탭을 누르면 이동할 간격
      height: 200, //에디터 높이
      minHeight: 200, //에디터 최소높이
      lineHeight: 20, //기본 줄간격(px)
      toolbar: [
        ['style', ['style']],
        ['font', ['bold', 'italic', 'underline']],
        ['color', ['color']],
        ['para', ['paragraph']],
        ['table', ['table']],
        ['insert', ['link']],
      ]
    });
  });
</script>

<form action="write" method="post">

	<div class="container w-600">
	
		<div class="row">
			<h1>fado 프로젝트 등록하기</h1>				
		</div>
		<div class="row">
			<input type="text" name="projectTitle" class="form-input w-100" placeholder="제목을 입력하세요">
		</div>
		<div class="row">
			<input type="number" name="projectTotalPrice" class="form-input w-100" placeholder="목표로 하는 금액을 입력하세요">
		</div>
		<div class="row">
			희망날짜 선택
			<input type="date" name="projectStartDate" class="form-input w-100">
		</div>
		<div class="row">
			프로젝트 기간
			<select name="projectEndDate" class="form-input">
				<option value="${projectStartDate}+15">15일</option>
				<option value="${projectStartDate}+30">30일</option>
			</select>
		</div>
		<div class="row">
			카테고리 선택
			<select name="projectCategory" class="form-input">
				<option value="project_category">의류(추가해야함)</option>
				<option value="project_category">게임</option>
			</select>
		</div>
		<div class="row">
			<textarea name="projectContent" placeholder="내용을 작성하세요" value="project_content"></textarea>
		</div>
		<div class="row">
			<button type="submit" class="btn btn-positive w-100">작성하기</button>
		</div>
			
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>    