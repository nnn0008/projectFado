<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
$(function(){
	$(htmlTemplate).find(".btn-edit")
							.attr("data-delivery-no", delivery.deliveryNo)
							.click(function(){
							
								//this는 수정버튼
								var editTemplate = $("#delivery-edit-template").html();
								var editHtmlTemplate = $.parseHTML(editTemplate);
							
								//value 설정
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
								
								//등록 버튼 처리
								$(editHtmlTemplate).submit(function(e){
									e.preventDefault();
									
									$.ajax({
										url:"/rest/delivery/edit",
										method:"post",
										data : $(e.target).serialize(),
										success:function(response){
											loadList(); //?
										}
									});
								});
								//화면 배치
								$(this).parents(".view-container")
											.hide()
											.after(editHtmlTemplate);
							});
							$(".delivery-list").append(htmlTemplate);
	
});
</script>
<script id = "delivery-edit-template"  type="text/template">
	<form class="delivery-edit-form edit-container">
	<input type="hidden" name="deliveryNo" value="?">
		<div class="row">
			<div class= "row">
				<input type="text" name="deliveryReceiver" class="form-input w-100">
			</div>
			<div class= "row">
				<input type="text" name="deliveryPost" class="form-input w-100">
			</div>
			<div class= "row">
				<input type="text" name="deliveryAddr1" class="form-input w-100">
			</div>
			<div class= "row">
				<input type="text" name="deliveryAddr2" class="form-input w-100">
			</div>
			<div class= "row">
				<input type="text" name="deliveryContact" class="form-input w-100">
			</div>
			<div class="row left">
				<button type="submit" class="btn btn-positive">
				<i class="fa-solid fa-check"></i>
				수정
				</button>
			</div>
		</div>
		</form>
</script>

<div class="container w-600">
	<div class="row left">
		<form class="delivery-edit-form">
		<input type="hidden" name="deliveryNo" value="${deliveryNo}">
			<div class="row">
				<div class= "row">
					<input type="text" name="deliveryReceiver" class="form-input w-100">
				</div>
				<div class= "row">
					<input type="text" name="deliveryPost" class="form-input w-100">
				</div>
				<div class= "row">
					<input type="text" name="deliveryAddr1" class="form-input w-100">
				</div>
				<div class= "row">
					<input type="text" name="deliveryAddr2" class="form-input w-100">
				</div>
				<div class= "row">
					<input type="text" name="deliveryContact" class="form-input w-100">
				</div>
			</div>
			<div class="row left">
				<button class="btn btn-positive w-100">
					<i class="fa-solid fa-pen"></i>
					수정하기
				</button>
			</div>
		</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>