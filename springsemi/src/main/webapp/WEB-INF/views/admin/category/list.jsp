<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>

	$(function(){
		
		//대분류 반복문으로 찍어내기
		$(".category-main").empty();
		$.ajax({
			url:"/rest/category/majorList",
			method:"post",
// 			data:{},
			success:function(response){
				for(var i = 0; i < response.length; i++){
					var div = $("<div>").addClass("p-10").text(response[i].majorCategoryType);
					div.appendTo(".category-main");
				}	
			},

		});
		
		$(".category-main > div").click(function(){
			var main = $(this).text();
			if(main.length == 0) return;
			
			$.ajax({
				url:"/rest/category/minorList",
				method:"post",
// 				data: {  : main},
				success:function(response){
					console.log(response);
					for(var i = 0; i < response.length; i++){
						var div = $("<div>").addClass("p-10").text(response[i]);
						div.appendTo(".category-detail");
					}
				},
			});			
		});
	});
	
</script>

<form action="write" method="post">

	<div class="container w-500">
			
			<div class="flex-container">
				<div class="w-50">
					<h1>대분류</h1>
					<h1><button type="button" class="btn w-100 btn-addMain">추가</button></h1>
					<div class="flex-container vertical category-main">
						<div class="p-10"></div>
					</div>
				</div>
				
				<div class="w-50">
					<h1>소분류</h1>
					<h1><button type="button" class="btn w-100 btn-addDetail">추가</button></h1>
					<div class="flex-container vertical category-detail"></div>
				</div>
			</div>
		
	</div>
	
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
