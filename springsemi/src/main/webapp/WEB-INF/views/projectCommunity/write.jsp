<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>




<form action="write" method="post" autocomplete="off">
<div class="container w-600">
	<div>
		<input type="hidden" name="projectNo" value="${param.projectNo}">
	</div>
	<div>
		<select name="projectCommunityType" required>
			<option selected>Q&A</option>
			<option selected>공지사항</option>
		</select>
	</div>
	<div>
		<textarea name="projectCommunityContent"></textarea>
	</div>
	<div class="right">
		<button class="btn btn-positive">작성하기</button>
	</div>
</div>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>