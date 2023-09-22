 <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
$(function(){
	//파일이 바뀌면 프로필을 업로드하고 이미지 교체
	$(".profile-chooser").change(function(){
		//선택된 파일이 있는지 확인하고 없으면 중단
		var input = this;
		if (input.files.length == 0) return; //없으면 중단
		
		//ajax로 multipart 업로드
		var form = new FormData(); //form data
		form.append("attach", input.files[0]);
		
		$.ajax({
			url:"/rest/member/upload",
			method:"post",
			processData:false, //ajax가 기본으로 설정하는 걸 막아줌
			contentType:false, //ajax가 기본으로 설정하는 걸 막아줌
			data:form, //준비한 form data
			success:function(response){
				$(".profile-image").attr("src", "/rest/member/download?attachNo="+response.attachNo);
			},
			error:function(){
				window.alert("통신 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
			},
		});
	});
	
	//삭제 아이콘을 누르면 프로필이 제거됨
	$(".profile-delete").click(function(){
		//확인창 
		var choice = window.confirm("등록된 프로필을 지우시겠습니까?");
		if (choice == false) return;
		
		//삭제요청
		$.ajax({
			url:"/rest/member/delete",
			method:"post",
			success:function(response){
				$(".profile-image").attr("src","/images/user.png");
			}
		});
	});
});
</script>

<div class="container w-500">
<div class="row">
<i class="fa-solid fa-heart" style="color: #f2829e;"></i>
<h1>${memberDto.memberId}님의 회원 정보</h1>
<i class="fa-solid fa-heart" style="color: #f2829e;"></i>
</div>

<div class="row mv-30">
		<c:choose>
			<c:when test= "${profile == null}">
				<img src ="/images/user.png" width="150" height ="150" 
				class="image image-circle image-border profile-image" >
			</c:when>
			<c:otherwise>
			<img src ="/rest/member/download?attachNo=${profile}" width="150" height ="150" 
				class="image image-circle image-border profile-image" >
			</c:otherwise>
		</c:choose>
		
		<!--  라벨을 만들고 파일 선택창을 숨김 -->
		<br>
		<label>
			<input type="file" class="profile-chooser" accept="image/*" style="display:none;">
			<i class="fa-solid fa-arrow-up-from-bracket fa-2x" style="color: #0e8df4;"></i>
		</label>
		
		<i class="fa-solid fa-xmark fa-2x profile-delete" style="color: #ff0f0f;"></i>
	</div>

<table border="1" width="500">
	<tr>
		<th>닉네임</th>
		<td>${memberDto.memberNickname}</td>
	</tr>
	
	<tr>
		<th>이메일</th>
		<td>${memberDto.memberEmail}</td>
	</tr>
	
	<tr>
		<th>연락처</th>
		<td>${memberDto.memberContact}</td>
	</tr>
	
	<tr>
		<th>생년월일</th>
		<td>${memberDto.memberBirth}</td>
	</tr>
	
	<tr>
		<th>등급</th>
		<td>${memberDto.memberLevel}</td>
	</tr>
	
	<tr>
		<th>포인트</th>
		<td>
			<fmt:formatNumber value="${memberDto.memberPoint}" 
			pattern="#,##0"></fmt:formatNumber> pt
			</td>
	</tr>
</table>

	<a href="/delivery/mydelivery">배송지</a><br><br>

	<a href="password">
			<i class="fa-solid fa-key"></i>
			비밀번호 변경
	</a><br><br>
	
		<a href="change">
			<i class="fa-solid fa-user"></i>
			개인정보 변경
		</a><br><br>
	
		<a href="exit">
			<i class="fa-solid fa-user-xmark"></i>
			회원 탈퇴
		</a><br><br>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>