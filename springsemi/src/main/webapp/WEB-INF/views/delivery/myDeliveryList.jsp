<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/delivery.js"></script>

<style>
	.insert-area {
		position: absolute;
		display: none;
		padding: 0.5em 1em;;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);	
		background: white;
		box-shadow: 0 0 0 2px gray;
		border-radius: 5px;
	}
</style>

<script>
$(function(){
	
	$(".btn-add").click(function(){
		$(".insert-area").show();
	});	
	$(".btn-cancel").click(function(){
		$(".insert-area").hide();
		$("[name=deliveryReceiver]").val(""); 
		$("[name=deliveryReceiver]").removeClass("success fail");
		$("[name=deliveryPost]").val(""); 
		$("[name=deliveryPost]").removeClass("success fail");
		$("[name=deliveryAddr1]").val(""); 
		$("[name=deliveryAddr1]").removeClass("success fail");
		$("[name=deliveryAddr2]").val(""); 
		$("[name=deliveryAddr2]").removeClass("success fail");
		$("[name=deliveryContact]").val("");
		$("[name=deliveryContact]").removeClass("success fail");
	});	
	
	
	$(".delivery-insert-form").submit(function(e){
		e.preventDefault();
		
		$.ajax({
			url: "/rest/delivery/insert",
			method: "post",
			data: $(e.target).serialize(),
			success: function(response){
				$("[name=deliveryReceiver]").val(""); 
				$("[name=deliveryReceiver]").removeClass("success fail");
				$("[name=deliveryPost]").val(""); 
				$("[name=deliveryPost]").removeClass("success fail");
				$("[name=deliveryAddr1]").val(""); 
				$("[name=deliveryAddr1]").removeClass("success fail");
				$("[name=deliveryAddr2]").val(""); 
				$("[name=deliveryAddr2]").removeClass("success fail");
				$("[name=deliveryContact]").val("");
				$("[name=deliveryContact]").removeClass("success fail");
				$(".insert-area").hide();
				loadList();
			}
		});
	});
	
	loadList();
	
	function loadList() {
		$.ajax({
			url:"/rest/delivery/list",
			method:"post",
			success: function(response){
				$(".delivery-list").empty();
				
				for(var i=0; i < response.length; i++) {
					var delivery = response[i];
					
					var template = $("#delivery-template").html();
					var htmlTemplate = $.parseHTML(template); 
					
					$(htmlTemplate).find(".deliveryReceiver").text(delivery.deliveryReceiver);
					$(htmlTemplate).find(".deliveryPost").text(delivery.deliveryPost);
					$(htmlTemplate).find(".deliveryAddr1").text(delivery.deliveryAddr1);
					$(htmlTemplate).find(".deliveryAddr2").text(delivery.deliveryAddr2);
					$(htmlTemplate).find(".deliveryContact").text(delivery.deliveryContact);
					
					$(htmlTemplate).find(".btn-delete").attr("data-delivery-no", delivery.deliveryNo)
											.click(function(e){
												var deliveryNo = $(this).attr("data-delivery-no");
											$.ajax({
												url:"/rest/delivery/delete",
												method:"post",
												data:{deliveryNo : deliveryNo},
												success:function(response){
													loadList();
												},
											});
										});
					$(htmlTemplate).find(".btn-edit")
											.attr("data-delivery-no", delivery.deliveryNo)
											.click(function(){
						var editTemplate = $("#delivery-edit-template").html();
						var editHtmlTemplate = $.parseHTML(editTemplate);
						
						var deliveryNo = $(this).attr("data-delivery-no");
						var deliveryReceiver = $(this).parents(".view-container")
																.find(".deliveryReceiver").text();
						var deliveryPost = $(this).parents(".view-container")
																.find(".deliveryPost").text();
						var deliveryAddr1 = $(this).parents(".view-container")
																.find(".deliveryAddr1").text();
						var deliveryAddr2= $(this).parents(".view-container")
																.find(".deliveryAddr2").text();
						var deliveryContact = $(this).parents(".view-container")
																.find(".deliveryContact").text();
						
						$(editHtmlTemplate).find("[name=deliveryNo]").val(deliveryNo);
						$(editHtmlTemplate).find("[name=deliveryReceiver]").val(deliveryReceiver);
						$(editHtmlTemplate).find("[name=deliveryPost]").val(deliveryPost);
						$(editHtmlTemplate).find("[name=deliveryAddr1]").val(deliveryAddr1);
						$(editHtmlTemplate).find("[name=deliveryAddr2]").val(deliveryAddr2);
						$(editHtmlTemplate).find("[name=deliveryContact]").val(deliveryContact);
						
						$(editHtmlTemplate).find(".btn-cancel")
													.click(function(){
							$(this).parents(".edit-container")
										.prev(".view-container").show();
							$(this).parents(".edit-container").remove();
						});
						
						$(editHtmlTemplate).submit(function(e){
							e.preventDefault();
							
							$.ajax({
								url:"/rest/delivery/edit",
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
					$(".delivery-list").append(htmlTemplate);
				}
			},
		});
	}
});
</script>

<script id ="delivery-template" type ="text/template">
<div class="container w-500">
	<div style="border: 1px solid #2c8de0; border-radius: 10px;" class="w-500 row container view-container">
		<div class="row left ms-30">
			<pre class="deliveryReceiver">수령인</pre>
		</div>
		<div class="row left ms-30">
			<pre class="deliveryPost">우편번호</pre>
		</div>
		<div class="row left ms-30">
			<pre class="deliveryAddr1">기본주소</pre>
		</div>
		<div class="row left ms-30">
			<pre class="deliveryAddr2">상세주소</pre>
		</div>
		<div class="row left ms-30">
			<pre class="deliveryContact">연락처</pre>
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

<script id ="delivery-edit-template" type="text/template">
	<form class="delivery-edit-form edit-container">
		<input type="hidden" name="deliveryNo" value="?">
			<div class="row">
				<div class="row">
			<input type="text" name="deliveryReceiver" class="form-input w-100"
			placeholder="수령인">
			<div class="fail-feedback">한글만 작성해주세요</div>
		</div>
		<div class="row left">
           <input style="width:8em" type="text" name="deliveryPost" size="6" maxlength="6" 
           class="form-input post-search" placeholder="우편번호" readonly>
           <button type="button" class="btn post-search">
           		<i class="fa-solid fa-magnifying-glass"></i>
           </button>
           <button type="button" class="btn btn-negative post-clear">
                <i class="fa-solid fa-x"></i>
           </button>
           <input type="text" name="deliveryAddr1" 
           class="form-input mt-10 w-100 post-search" placeholder="기본주소" readonly>
           <input type="text" name="deliveryAddr2" 
           class="form-input mt-10 w-100" placeholder="상세주소">
           <div class="fail-feedback">모든 주소를 작성해주세요</div>
	 	</div>
		<div class= "row">
			<input type="text" name="deliveryContact" class="form-input w-100" 
			placeholder="수령인 전화번호 (-제외 입력)">
			<div class="fail-feedback">잘못된 전화번호 형식입니다</div>
		</div>
				<div class="row" style="display: flex; justify-content: right;">
				<div class="row me-10">
					<button type="submit" class="btn btn-positive">
						<i class="fa-solid fa-check"></i>
							수정
					</button>
				</div>
				<div class="row me-10">
					<button type="button" class="btn btn-negative btn-cancel">
						<i class="fa-solid fa-xmark"></i>
						취소
					</button>
				</div>
				</div>
			</div>
	</form>
</script>



<div class="row mt-30">
	<button class="btn btn-positive btn-add">
		<i class="fa-solid fa-edit"></i>
			배송지 등록하기
	</button>
</div>

<div class="row mt-40">
	<h1>배송지 목록</h1>
</div>

<div class="row left delivery-list"></div>

	<!--  수정되면 delivery-template에 들어갈 버튼
	<div class="row" style="display: flex; justify-content: right;">
		<div class="row me-10">
				<button class="btn btn-positive btn-edit">
					<i class="fa-solid fa-edit"></i>
					수정
					</button>
			</div>
			<div class="row me-10">
				<button class="btn btn-negative btn-delete">
					<i class="fa-solid fa-trash"></i>
					삭제
				</button>
			</div>
			</div>-->
			
<div class="container w-500">
	<div class="row left">
	<form class="delivery-insert-form insert-area w-500" autocomplete="off">
<%-- 		<input type="hidden" name="deliveryNo" value="${deliveryDto.deliveryNo}"> --%>
<%-- 		<input type="hidden" name="memberId" value="${deliveryDto.memberId}"> --%>
		<div class="row">
			<h1>배송지 등록</h1>
		</div>
		<div class= "row">
			<input type="text" name="deliveryReceiver" class="form-input w-100" 
			placeholder="수령인">
		</div>
		<div class="row left">
           <input style="width:8em" type="text" name="deliveryPost" size="6" maxlength="6" 
           class="form-input post-search" placeholder="우편번호" readonly>
           <button type="button" class="btn post-search">
           		<i class="fa-solid fa-magnifying-glass"></i>
           </button>
           <button type="button" class="btn btn-negative post-clear">
                <i class="fa-solid fa-x"></i>
           </button>
           <input type="text" name="deliveryAddr1" 
           class="form-input mt-10 w-100 post-search" placeholder="기본주소" readonly>
           <input type="text" name="deliveryAddr2" 
           class="form-input mt-10 w-100" placeholder="상세주소">
	 	</div>
		<div class= "row">
			<input type="text" name="deliveryContact" class="form-input w-100" 
			placeholder="수령인 전화번호 (-제외 입력)">
		</div>
		<div class="row" style="display: flex; justify-content: right;">
			<div class="row me-10">
				<button type="submit" class="btn btn-positive w-100 btn-adds">
					<i class="fa-solid fa-plus"></i>
					추가
				</button>
			</div>
			<div class="row me-10">
				<button type="button" class="btn btn-negative btn-cancel">
					<i class="fa-solid fa-xmark"></i>
					취소
				</button>
			</div>
		</div>
	</form>
	
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>