<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>

	$(function(){
		
		//대분류 반복문으로 구현
		$(".category-main").empty();
		$.ajax({
			url:"/rest/category/majorList",
			method:"post",
// 			data:{},
			success:function(response){
// 				console.log(response);
				for(var i = 0; i < response.length; i++){
					var div = $("<div>").addClass("p-10 row left major").text(response[i].majorCategoryType);
					var xBtn = $("<button>").text("X").attr("type","button").click(function(){
						alert("관련된 소분류가 모두 삭제될 수 있습니다. 정말 삭제하시겠습니까?");
						//x버튼 눌렀을 때 분류 삭제되도록 구현	
						$.ajax({
								url:"/rest/category/majorDelete",
								method:"post",
								data: {majorCategoryNo : majorCategoryNo},
								success:function(response){
									$(".major").remove();
								},
						});
					});	

					div.append(xBtn).appendTo(".category-main");
				}
			},
		});
		
// 		대분류를 클릭했을 때, 관련 소분류를 로딩하기(아직 구현 안됨)
		 $(".category-main").click(".div", function(e){
            var majorCategoryType = $(this).text();
      	    console.log("click: " + majorCategoryType);
			if(majorCategoryType.length == 0) return;
			$.ajax({
				url:"/rest/category/minorList",
				method:"post",
				data: {majorCategoryType : majorCategoryType},
				success:function(response){
					console.log(response);
					$(".category-detail").empty();
// 					$.each(response, function(minorCategoryType) {
// 					    var div = $("<div>").addClass("p-10").text(minorCategoryType);
// 					    div.appendTo(".category-detail");
// 					});
					for(var i = 0; i < response.length; i++){
						var div = $("<div>").addClass("p-10").text(response[i]);
						var xBtn = $("<button>").text("X").attr("type","button").click(function(){
							//x버튼 눌렀을 때 분류 삭제되도록 구현
				
							});
						}
						
					    div.append(xBtn).appendTo(".category-detail");
				},
				
			});			
		});
		
		//대분류 중복 체크
		$("[name=majorCategoryType]").blur(function(e){
			var regex=/^[가-힣]{1,10}$/;
			var isValid = regex.test($(e.target).val());
			var major = $(this).val();
			if(major.length == 0){
				$(".major-check").hide();
				$(e.target).removeClass("success fail fail2");
				return;
			}
			if(isValid){
				$.ajax({
					url:"/rest/category/majorCheck",
					method:"post",
					data:{majorCategoryType : major},
					success:function(response){
						$(e.target).removeClass("success fail fail2");
						if(response == "Y"){
							$(e.target).addClass("success");
							$(".major-check").text("등록이 가능합니다!");
						}
						else if(response == "N"){
							$(e.target).addClass("fail");
							$(".major-check").text("이미 등록된 카테고리입니다!");
							$(".btn-addMain").prop("disabled", true);
						}
					},
				});
			}
			else{
				$(e.target).removeClass("success fail fail2");
				$(e.target).addClass("fail2");
				$(".btn-addMain").prop("disabled", true);
				$(".major-check").text("한글 1~10자 이내로 입력하십시오");
			}			
		});
		
		
		//추가 버튼을 눌렀을 때, 대분류가 추가되도록 만들기
		$(".major-insert-form").submit(function(e){
			//FORM 이 전송되는 것을 방지
			e.preventDefault();
			//비동기통신으로 분류 추가하게 만들기
			var majorCategoryType = $("[name=majorCategoryType]").val();
			if(majorCategoryType.length == 0) {
				$(".btn-addMain").prop("disabled", false);
				return;
			}		
			$.ajax({
				url:"/rest/category/majorInsert",
				method:"post",
				data: $(e.target).serialize(),
				success:function(response){
// 					console.log(response);
					$("[name=majorCategoryType]").val("").focus(); //입력창 초기화
				},
			});
		});
		
		
		
		
	});
	
</script>


	<div class="container w-500">
			
			<div class="flex-container">
				<div class="w-50">
					<h1>대분류</h1>
					<form class="major-insert-form" method="post">
						<h1><input type="text" class="form-input w-100" name="majorCategoryType"></h1>
						<h1><button class="btn w-100 btn-addMain">추가</button></h1>
						<div class="row major-check"></div>
					</form>
					<div class="flex-container vertical category-main">
						<input type="text" name="majorCategoryNo" value="${majorCategoryDto.majorCategoryNo}">
						<div class="p-10"></div>
					</div>
				</div>
				
				<div class="w-50">
					<h1>소분류</h1>
					<h1><input type="text" class="form-input w-100" name="minorCategoryType"></h1>
					<h1><button type="button" class="btn w-100 btn-addDetail">추가</button></h1>
					<div class="row minor-check"></div>
					<div class="flex-container vertical category-detail">
						<input type="hidden" name="minorCategoryNo" value="${minorCategoryDto.minorCategoryNo}">
						<div class="p-10"></div>					
					</div>
				</div>
			</div>
		
	</div>
	

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
