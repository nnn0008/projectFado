<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
$(function(){
	$(".reward-insert-form").submit(function(e){
		e.preventDefault();
		
		var params = new URLSearchParams(location.search);
		var no = params.get("projectNo");
		
		var rewardType = $("[name=rewardType]").val();
		var rewardPrice = $("[name=rewardPrice]").val();
// 		console.log(rewardType);
// 		console.log(rewardPrice);
		$.ajax({
			url: "/rest/reward/insert",
			method: "post",
// 			data: $(e.target).serialize(),
			data: {
				projectNo : no,
				rewardType : rewardType,
				rewardPrice : rewardPrice
				},
			success: function(response){
				$("[name=rewardType]").val("");
				$("[name=rewardPrice]").val("");
				loadList();
			}
		});
	});	
	loadList();
	
	function loadList() {
		
		var params = new URLSearchParams(location.search);
		var projectNo = params.get("projectNo");
		
		$.ajax({
			url: "/rest/reward/list",
			method: "post",
			data: {projectNo : projectNo},
			success: function(response){
// 				console.log(response);
				$(".reward-list").empty();
				
				for(var i=0; i < response.length; i++) {
					var reward = response[i];
					
					var template = $("#reward-template").html();
					var htmlTemplate = $.parseHTML(template);
					
					$(htmlTemplate).find(".rewardType").text(reward.rewardType);
					$(htmlTemplate).find(".rewardPrice").text(reward.rewardPrice);
					
					$(htmlTemplate).find(".btn-delete")
											.attr("data-reward-no", reward.rewardNo)
											.click(function(e){
												var rewardNo = $(this).attr("data-reward-no");
												$.ajax({
													url:"/rest/reward/delete",
													method:"post",
													data:{rewardNo : rewardNo},
													success:function(response){
														loadList();
													},
												});
											});
											$(htmlTemplate).find(".btn-edit")
											.attr("data-reward-no", reward.rewardNo)
											.click(function(){
						var editTemplate = $("#reward-edit-template").html();
						var editHtmlTemplate = $.parseHTML(editTemplate);
						
						var rewardNo = $(this).attr("data-reward-no");
						var rewardType = $(this).parents(".view-container")
																.find(".rewardType").text();
						var rewardPrice = $(this).parents(".view-container")
																.find(".rewardPrice").text();
						
						$(editHtmlTemplate).find("[name=rewardNo]").val(rewardNo);
						$(editHtmlTemplate).find("[name=rewardType]").val(rewardType);
						$(editHtmlTemplate).find("[name=rewardPrice]").val(rewardPrice);
						
						$(editHtmlTemplate).find(".btn-cancel")
													.click(function(){
							$(this).parents(".edit-container")
										.prev(".view-container").show();
							$(this).parents(".edit-container").remove();
						});
						
						$(editHtmlTemplate).submit(function(e){
							e.preventDefault();
							
							$.ajax({
								url:"/rest/reward/edit",
								method:"post",
								data : $(e.target).serialize(),
								success:function(response){
									loadList();
								}
							});
						});
						$(this).parents(".view-container").hide()
								.after(editHtmlTemplate)
						});
					$(".reward-list").append(htmlTemplate);
				}
			},
		});
	}
});
</script>

<script id="reward-template" type="text/template">
<div class="container w-500">
	<div style="border: 1px solid #2c8de0; border-radius: 10px;" class="w-500 row container view-container">
		<div class="row left ms-30">
			<pre class="rewardType">리워드구성</pre>
		</div>
		<div class="row left ms-30">
			<pre class="rewardPrice">리워드가격</pre>
		</div>
			<div class="row me-10 right">
				<button class="btn btn-negative btn-delete">
					<i class="fa-solid fa-trash"></i>
					삭제
				</button>
			</div>
	</div>
</div>
</script>

<!-- <div class="row"> -->
<!-- 	<form action="write" method="post" autocomplete="off"> -->
<!-- 		<div class="row reward-list"></div> -->
<!-- 		<button type="submit" class="btn btn-positive w-100">리워드 추가완료하기</button> -->
<!-- 	</form> -->
<!-- </div> -->
<div class="flex-container">
<div class="row left reward-list"></div>

<div class="container w-500">
	<form class="reward-insert-form">
		<div class="row">
			<h1>${projectDto.projectTitle}의 리워드 등록하기</h1>
		</div>
		<div class="row">
			<input type="hidden" name="projectNo" class="form-input w-100">
		</div>
		<div class="row">
			<input type="text" name="rewardType" class="form-input w-100"
			placeholder="리워드 구성을 입력하세요">
		</div>
		<div class="row">
			<input type="number" name="rewardPrice" class="form-input w-100"
			placeholder="리워드 가격을 입력하세요">
		</div>
		<div class="row me-10 w-100">
			<button type="submit" class="btn btn-positive w-100">
				<i class="fa-solid fa-plus"></i>
				추가
			</button>
		</div>
	</form>
	<div class="row w-100">
		<button class="btn btn-positive w-100">
			<a class="link" href="http://localhost:8080/project/detail?projectNo=${projectDto.projectNo}">
				프로젝트 페이지로 가기
			</a>
		</button>
	</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>      