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
		
		$.ajax({
			url: "/rest/reward/insert",
			method: "post",
			data: $(e.target).serialize(),
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
		var no = params.get("projectNo");
		
		$.ajax({
			url: "/rest/reward/list",
			method: "post",
			data: {projectNo : no},
			success: function(response){
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
					$(".reward-list").append(htmlTemplate);
				}
				
			},
		});
	}

});
</script>

<script id="reward-template" type="text/template">
	<div class="row container view-container">
		<div class="row">
			<pre class="rewardType">리워드 구성</pre>
		</div>
		<div class="row">
			<pre class="rewardPrice">리워드 가격</pre>
		</div>
		<div class="row me-10 right">
			<button class="btn btn-negative btn-delete">
				<i class="fa-solid fa-trash"></i>
					삭제
			</button>
		</div>
	</div>
</script>
<div class="row left reward-list"></div>
<form action="reward/write" method="post" autocomplete="off">
<!-- 	<div class="row left reward-list"></div> -->
</form>

<div class="container w-500">
	<form class="reward-insert-form">
		<div class="row">
			<h1>리워드 등록</h1>
		</div>
		<div class="row">
			<input type="text" name="rewardType" class="form-input w-100"
			placeholder="리워드 구성을 입력하세요">
		</div>
		<div class="row">
			<input type="text" name="rewardPrice" class="form-input w-100"
			placeholder="리워드 가격을 입력하세요">
		</div>
		<div class="row me-10">
			<button type="submit" class="btn btn-positive w-100">
				<i class="fa-solid fa-plus"></i>
				추가
			</button>
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>      