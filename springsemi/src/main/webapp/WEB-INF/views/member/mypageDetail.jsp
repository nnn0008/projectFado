<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.image {
width:100px;
height:100px;
}
</style>

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

<div class="container w-700">
	<div class="row mb-30">
		<i class="fa-solid fa-heart" style="color: #f2829e;"></i>
		<h1>${memberDto.memberId}님의 회원 정보</h1>
		<i class="fa-solid fa-heart" style="color: #f2829e;"></i>
	</div>


	
	<div class="left">
		<div class="mb-20 bold">
			<label>프로필 사진</label>
		</div>

		<c:choose>
			<c:when test= "${profile == null}">
				<img src ="/images/user.png"
				class="image image-circle image-border profile-image" >
			</c:when>
			<c:otherwise>
			<img src ="/rest/member/download?attachNo=${profile}"
				class="image image-circle image-border profile-image" >
			</c:otherwise>
		</c:choose>
		
		<!--  라벨을 만들고 파일 선택창을 숨김 -->
		<label>
			<input type="file" class="profile-chooser" accept="image/*" style="display:none;">
			<i class="fa-solid fa-arrow-up-from-bracket fa-2x" style="color: #0e8df4;"></i>
		</label>
		
		<i class="fa-solid fa-xmark fa-2x profile-delete" style="color: #ff0f0f;"></i>
	</div>
	
	<hr class="hr-style">
	
	<div class="left mt-20">
		<label class="bold mt-10">닉네임</label>
		<br>
		<label>${memberDto.memberNickname}</label>
	</div>
	<hr class="hr-style">
	
	<div class="left mt-20">
		<label class="bold mt-10">이메일</label>
		<br>
		<label>${memberDto.memberEmail}</label>
	</div>
	<hr class="hr-style w-100">
	
	<div class="left mt-20">
		<label class="bold mt-10">연락처</label>
		<br>
		<label>${memberDto.memberContact}</label>
	</div>
	<hr class="hr-style">
	
	<div class="left mt-20">
		<label class="bold mt-10">생년월일</label>
		<br>
		<label>${memberDto.memberBirth}</label>
	</div>
	<hr class="hr-style">
	
	<div class="left mt-20">
		<label class="bold mt-10">등급</label>
		<br>
		<label>${memberDto.memberLevel}</label>
	</div>
	<hr class="hr-style">
	
	<div class="left mt-20">
		<label class="bold mt-10">회원가입일</label>
		<br>
		<label>
		<fmt:formatDate value="${memberDto.memberJoin}" 
				pattern="y년 M월 d일 E a h시 m분 s초"/>
		</label>
	</div>
	<hr class="hr-style">
	
	<div class="left mt-20">
		<label class="bold mt-10">마지막 로그인 시간</label>
		<br>
		<label>
		<fmt:formatDate value="${memberDto.memberLastLogin}" 
				pattern="y년 M월 d일 E a h시 m분 s초"/>
		</label>
	</div>
	<hr class="hr-style">
	
	<div class="left mt-20">
		<label class="bold mt-10">마지막 비밀번호 변경일</label>
		<br>
		<label>
		<fmt:formatDate value="${memberDto.memberChangePw}" 
				pattern="y년 M월 d일 E a h시 m분 s초"/>
		</label>
	</div>
	<hr class="hr-style">
	
	<div class="row">
		<a href="/delivery/mydelivery" class="btn">
			<i class="fa-regular fa-truck"></i>
				배송지
		</a>
	</div>
	<br>
	
	<div class="row">
		<a href="/member/follow/list" class="btn">
			<i class="fa-light fa-user"></i>
				팔로잉
		</a>
	</div>
	<br>
	<div class="row">
		<a href="password" class="btn">
			<i class="fa-solid fa-key"></i>
			비밀번호 변경
		</a>
	</div>
	<br>
	<div class="row">
		<a href="change" class="btn">
			<i class="fa-solid fa-user"></i>
			개인정보 변경
		</a>
	</div>
		<br>
	<div class="row">
		<a href="exit" class="btn">
			<i class="fa-solid fa-user-xmark"></i>
			회원 탈퇴
		</a>
	</div>
		<br>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>