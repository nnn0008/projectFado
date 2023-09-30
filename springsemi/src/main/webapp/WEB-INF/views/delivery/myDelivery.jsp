<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

</style>

<script>
$(function(){
	$(".delivery-insert-form").submit(function(e){
		//this == e.terget == 폼(form)
		
		//기본 이벤트 차단
		e.preventDefault();
		
		//비동기 통신 발생
		$.ajax({
			url:"/rest/delivery/insert",
			method:"post",
			data : $(e.target).serialize(),
			success:function(response){
				$("[name=deliveryReceiver]").val(""); //입력창 초기화
				$("[name=deliveryPost]").val(""); //입력창 초기화
				$("[name=deliveryAddr1]").val(""); //입력창 초기화
				$("[name=deliveryAddr2]").val(""); //입력창 초기화
				$("[name=deliveryContact]").val(""); //입력창 초기화
				loadList(); //목록 갱신
			}
		});
	});
	
	//목록은 페이지가 로딩되면 바로 불러오도록 구현
	//등록이 완료된 경우 불러오도록 구현
	//목록을 모두 지우고 전부 다 새로 불러오도록 구현
	loadList();
	
	//목록을 불러온 뒤 추가로 해야할 것
	//수정/삭제 버튼이 나오도록 처리
	//수정버튼을 누르면 화면에 변화를 주도록 처리
	//삭제 버튼을 누르면 확인창 출력 후 삭제하도록 처리
	function loadList() {
		//Javascript로 deliveryNo라는 이름의 파라미터 값 읽기
		var params = new URLSearchParams(location.search);
		var no = params.get("deliveryNo");
		
		//비동기 통신으로 화면 갱신
		$.ajax({
			url:"/rest/delivery/list",
			method:"post",
			data:{deliveryNo : no},
			success:function(response){
				//화면 청소
				$(".delivery-list").empty(); //자기 자신을 제외한 내부 코드 삭제
				
				//response는 배송지 목록(JSON)
				for(var i=0; i < response.length; i++) {
					var delivery = response[i];
					
					var template = $("#delivery-template").html();
					var htmlTemplate = $.parseHTML(template);
					
					$(htmlTemplate).find(".deliveryReceiver").text(delivery.deliveryReceiver);
					$(htmlTemplate).find(".deliveryPost").text(delivery.deliveryPost);
					$(htmlTemplate).find(".deliveryAddr1").text(delivery.deliveryAddr1);
					$(htmlTemplate).find(".deliveryAddr2").text(delivery.deliveryAddr2);
					$(htmlTemplate).find(".deliveryContact").text(delivery.deliveryContact);
					
					//만드는 시점에 이벤트 설정
					//- 반복문의 데이터 사용 불가(위치가 다름)
					//- 지금과 같이 버튼 내부에 태그가 더 있을 때,
					//		this와 e.target은 다를 수 있다.
					//		(this는 주인공, e.target은 실제대상)
					$(htmlTemplate).find(".btn-delete")
											.attr("data-delivery-no", delivery.deliveryNo)
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
					//수정 버튼을 누르면
					//- 편집 상태의 템플릿을 만들어서 추가
					//- 전환 시 작성된 값들을 입력창으로 이동시켜야 함
					//- 전송 가능한 form과 취소 버튼을 구현
					//- 수정 시 서버로 글번호와 글내용만 전달하면 됨
					$(htmlTemplate).find(".btn-edit")
											.attr("data-delivery-no", delivery.deliveryNo)
											.click(function(){
						//this == 수정버튼
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
					
						//취소 버튼에 대한 처리 구현
						$(editHtmlTemplate).find(".btn-cancel")
													.click(function(){
							//this == 취소버튼
							$(this).parents(".edit-container")
										.prev(".view-container").show();
							$(this).parents(".edit-container").remove();
						});
						
						//완료(등록)버튼 처리
						//- editHtmlTemplate 자체가 form이므로 추가 탐색을 하지 않음
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
						
						//화면 배치
						$(this).parents(".view-container")
									.hide()
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
	<div class="row container view-container">
		<div class="row">
			<pre class="deliveryReceiver">받는 사람</pre>
		</div>
		<div class="row">
			<pre class="deliveryPost">우편번호</pre>
		</div>
		<div class="row">
			<pre class="deliveryAddr1">우편번호</pre>
		</div>
		<div class="row">
			<pre class="deliveryAddr2">우편번호</pre>
		</div>
		<div class="row">
			<pre class="deliveryContact">우편번호</pre>
		</div>
			<div class="row right">
				<button class="btn btn-edit">
					<i class="fa-solid fa-edit"></i>
					수정
					</button>
			</div>
			<div class="row right">
				<button class="btn btn-negative btn-delete">
					<i class="fa-solid fa-trash"></i>
					삭제
				</button>
			</div>
	</div>
</script>

<script id ="delivery-edit-template" type="text/template">
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
				<div class="row right">
					<button type="button" class="btn btn-negative btn-cancel">
						<i class="fa-solid fa-xmark"></i>
						취소
					</button>
				</div>
			</div>
	</form>
</script>
<div class="row left">
	<form class="delivery-insert-form">
		<input type="hidden" name="deliveryNo" value="${deliveryDto.deliveryNo}">
	
		<div class="row">
			<input type="text" name="deliveryReceiver" class="form-input w-100"
			placeholder="받는사람">
		</div>
		<div class= "row">
			<input type="text" name="deliveryPost" class="form-input w-100"
			placeholder="우편번호">
		</div>
		<div class= "row">
			<input type="text" name="deliveryAddr1" class="form-input w-100" 
			placeholder="기본주소">
		</div>
		<div class= "row">
			<input type="text" name="deliveryAddr2" class="form-input w-100" 
			placeholder="상세주소">
		</div>
		<div class= "row">
			<input type="text" name="deliveryContact" class="form-input w-100" 
			placeholder="받는사람 전화번호">
		</div>
		<div class="row">
			<button class="btn btn-positive w-100">
				<i class="fa-solid fa-pen"></i>
				배송지 추가
			</button>
		</div>
	</form>
</div>
<div class="row left delivery-list"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>