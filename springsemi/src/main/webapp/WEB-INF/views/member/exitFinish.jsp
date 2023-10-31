<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class = "row red">
	<h1>회원 탈퇴 완료</h1>
</div>

<div class = "row">
	<h3>그동안 이용해주셔서 감사합니다.</h3>
</div>

<div class = "row fado">

	<a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/images/fado.jpg" width="200" height="180" ></a>
</div>

<div class="row">
	 <img src="${pageContext.request.contextPath}/images/thankyou.png" width="700" height="700"  class="image image-round">
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>