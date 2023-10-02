<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>

	$(function(){
		refreshMajor();
// 		//대분류 반복문으로 구현
// 		$(".category-main").empty();
// 		$.ajax({
// 			url:"/rest/category/majorList",
// 			method:"post",
// // 			data:{},<i class="fa-solid fa-x"></i>
// 			success:function(response){
// // 				console.log(response);]
// 				for(var i = 0; i < response.length; i++){
// 					var div = $("<div>").addClass("p-10 row left major").text(response[i].majorCategoryType);
// 					var xBtn = $("<button>").addClass("btn-main fas fa-x").attr("type","button").click(function(){						
// 						//x버튼 눌렀을 때 분류 삭제되도록 구현
// 						var confirmed = confirm("관련된 소분류가 모두 삭제될 수 있습니다. 정말 삭제하시겠습니까?");						
// 						if(confirmed){
// 							$.ajax({
// 									url:"/rest/category/majorDelete",
// 									method:"post",
// 									data: {majorCategoryType : $(this).parent().text()},
// 									success:function(response){
// 										$(".major").remove();
// 										refreshMajor(); //목록 갱신
// 									},
// 							});							
// 						}
// 						else{
// 							alert("삭제가 취소되었습니다");
// 						}
// 					});	
// 					div.append(xBtn).appendTo(".category-main");
// 				}
// 			},
// 		});
		
		
// 		대분류를 클릭했을 때, 관련 소분류를 로딩하기
		$(".category-main").click("div", function(e){
            var majorCategoryType = $(e.target).text();
//       	    console.log(majorCategoryType);
			if(majorCategoryType.length == 0) return;
			$.ajax({
				url:"/rest/category/minorList",
				method:"post",
				data: {majorCategoryType : majorCategoryType},
				success:function(response){
					console.log(response);
					$(".category-detail").empty();
					for(var i = 0; i < response.length; i++){
						var div = $("<div>").addClass("p-10 row left minor").text(response[i].minorCategoryType);
						var xBtn = $("<button>").addClass("btn-main fas fa-x").attr("type","button").click(function(){
							//x버튼 눌렀을 때 분류 삭제되도록 구현
							$.ajax({
								url:"/rest/category/minorDelete",
								method:"post",
								data: {
									minorCategoryType : $(this).parent().text()
								},
								success:function(response){
									$(".minor").remove();
								},								
							});
						});
					 div.append(xBtn).appendTo(".category-detail");
					}					
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
		
		//소분류 중복 체크
		$("[name=minorCategoryType]").blur(function(e){
			var regex=/^[가-힣]{1,10}$/;
			var isValid = regex.test($(e.target).val());
			var minor = $(this).val();
			if(minor.length == 0){
				$(".minor-check").hide();
				$(e.target).removeClass("success fail fail2");
				return;
			}
			if(isValid){
				$.ajax({
					url:"/rest/category/minorCheck",
					method:"post",
					data:{
						minorCategoryType : minor
					},
					success:function(response){
						$(e.target).removeClass("success fail fail2");
						if(response == "Y"){
							$(e.target).addClass("success");
							$(".minor-check").text("등록이 가능합니다");
						}
						else if (response == "N"){
							$(e.target).addClass("fail");
							$(".minor-check").text("이미 등록된 카테고리입니다!");
							$(".btn-addDetail").prop("disabled", true);
						}
					},
				});
			}
			else{
				$(e.target).removeClass("success fail fail2");
				$(e.target).addClass("fail2");
				$(".btn-addDetail").prop("disabled", true);
				$(".minor-check").text("한글 1~10자 이내로 입력하십시오");
			}
		});
		
		//추가 버튼을 눌렀을 때, 대분류가 추가되도록 만들기
		$(".major-insert-form").submit(function(e){
			//FORM 이 전송되는 것을 방지
			e.preventDefault();
			//비동기통신으로 분류 추가하게 만들기
			var majorCategoryType = $("[name=majorCategoryType]").val();
			if(majorCategoryType.length == 0) {
				$(".btn-addDetail").prop("disabled", false);
				return;
			}		
			$.ajax({
				url:"/rest/category/majorInsert",
				method:"post",
				data: $(e.target).serialize(),
				success:function(response){
					//console.log(response);
					$("[name=majorCategoryType]").val("").focus(); //입력창 초기화
					refreshMajor(); //목록 갱신
				},
			});
		});
		
		//추가 버튼을 클릭시, 소분류가 추가되도록 만들기
		$(".minor-insert-form").submit(function(e){
			//폼 전송을 방지
			e.preventDefault();
			//비동기통신으로 분류 추가하게 만들기
			//대분류는 텍스트로 불러와야되고
			var majorCategoryType = $();
			//소분류는 내가 입력한 값을 불러와야 한다
			var minorCategoryType = $("[name=minorCategoryType]").val();
			$.ajax({
				url:"/rest/category/minorInsert",
				method:"post",
				data: {
					majorCategoryType : majorCategoryType,
					minorCategoryType : minorCategoryType
				},
				success:function(response){
// 					console:log(response);
					$("[name=minorCategoryType]").val("").focus(); //입력창 초기화
				},
			});
		});
		
		//대분류가 추가됐을때, 화면을 갱신하는 함수
		function refreshMajor(){
			$(".category-main").empty();
			$.ajax({
				url:"/rest/category/majorList",
				method:"post",
//	 			data:{},<i class="fa-solid fa-x"></i>
				success:function(response){
//	 				console.log(response);
					for(var i = 0; i < response.length; i++){
						var div = $("<div>").addClass("p-10 row left major").text(response[i].majorCategoryType);
						var xBtn = $("<button>").addClass("btn-main fas fa-x").attr("type","button").click(function(){						
							//x버튼 눌렀을 때 분류 삭제되도록 구현
							var confirmed = confirm("관련된 소분류가 모두 삭제될 수 있습니다. 정말 삭제하시겠습니까?");						
							if(confirmed){
								$.ajax({
									url:"/rest/category/majorDelete",
									method:"post",
									data: {majorCategoryType : $(this).parent().text()},
									success:function(response){
										$(".major").remove();
										$("[name=majorCategoryType]").text("");
										refreshMajor();
									},
								});							
							}
							else{
								alert("삭제가 취소되었습니다");
							}
						});	
						div.append(xBtn).appendTo(".category-main");
					}
				},
			});
		}
		
		
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
<%-- 						<input type="text" name="majorCategoryNo" value="${majorCategoryDto.majorCategoryNo}"> --%>
						<div class="p-10"></div>
					</div>
				</div>
				
				<div class="w-50">
					<h1>소분류</h1>
					<form class="minor-insert-form" method="post">
						<h1><input type="text" class="form-input w-100" name="minorCategoryType"></h1>
						<h1><button class="btn w-100 btn-addDetail">추가</button></h1>
						<div class="row minor-check"></div>
					</form>
<%-- 						<input type="text" name="majorCategoryNo" value="${minorCategoryDto.majorCategoryNo}"> --%>
					<div class="flex-container vertical category-detail">
						<div class="p-10"></div>					
					</div>
				</div>
			</div>
		
	</div>
	

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
