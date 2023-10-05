<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.delivery-item {
	border: 1px solid #2c8de0;
	border-radius: 5px;
	padding: 10px;
	margin-bottom: 10px;
}

.modal {
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

.close {
	position: absolute;
	right: 10px;
	top: 10px;
	cursor: pointer;
}

.box{
	border: 1px solid #2c8de0; 
	border-radius: 5px;"
}

.left-box,
.light-box {

}
</style>

<script>
	$(function() {
		$(".change-delivery-btn").click(function() {
			$("#deliveryModal").show();
		});

		$(".close").click(function() {
			$("#deliveryModal").hide()
		});

		$(".delivery-btn").click(function() {
			// 선택한 배송지의 정보를 JavaScript 변수에 저장
			var deliveryNo = $(this).parents(".dList").find("[name=deliveryNo]").val();
			var deliveryReceiver = $(this).parents(".dList").find("[name=cdR]").val();
			var deliveryPost = $(this).parents(".dList").find("[name=cdP]").val();
			var deliveryAddr1 = $(this).parents(".dList").find("[name=cad1]").val();
			var deliveryAddr2 = $(this).parents(".dList").find("[name=cad2]").val();
			var deliveryContact = $(this).parents(".dList").find("[name=cct]").val();
			
			// 각각의 필드에 저장한 정보를 설정
			$(".dN").val(deliveryNo);
			$(".dR").val(deliveryReceiver);
			$(".dP").val(deliveryPost);
			$(".ad1").val(deliveryAddr1);
			$(".ad2").val(deliveryAddr2);
			$(".ct").val(deliveryContact);

			// 모달 창 닫기
			$("#deliveryModal").hide();
		});
	});
</script>




<form action="/orders/insert" method="post">
	<div class="container w-800">
	
		<!-- 상품칸 -->
		<div class="flex-container box mb-30"  style="height: 150px;">
		
			<!-- 이미지 -->
			<div class="row w-50">
              	<img style="height: 130px;" src="/rest/project/download?attachNo=${mainAttachDto.attachNo}">
           	</div>
           	
           	<!-- 상품 내용 시작-->
			<div class="left w-50">
			
				<input type="hidden" name="projectNo"
					value="${projectDto.projectNo}">
				<div class="mt-20 mb-10 bold" style="font-size:20px;">
					${projectDto.projectTitle}
				</div>
				
				<div class="flex-container mt-10 mb-10">
					<div class="me-10">
						${projectDto.projectTotalPrice} 원
					</div>
					<div class="red">
						n% 
					</div>
				</div>
				
				<div class="mt-10 mb-10 text-shadow">
					${projectDto.projectEndDate}
				</div>
				
			</div>
			<!-- 상품 내용 끝 -->
		</div>
		<!-- 상품칸 끝 -->


		<!-- 세 개의 정보 / 파도 정보 -->
		<div class="flex-container auto-width">
			
			<!-- 세 개의 정보(왼쪽) -->
			<div class="left-box me-30">
				
				<!-- 구매자 정보 -->
				<div class="left box mb-30 ps-20 pe-20 pt-10 pb-10" style="height: 200px;">
					<div class="row fado bold">구매자 정보</div>
					<div>연락처  ${memberDto.memberContact}</div>
					<div class="mb-10">이메일  ${memberDto.memberEmail}</div>
					<div style="color:gray; font-size:12px; ">* 위 연락처와 이메일로 파도 관련 소식이 전달됩니다.</div>
					<div style="color:gray; font-size:12px; ">* 연락처 및 이메일 변경은 설정 > 계정 설정에서 가능합니다.</div>
				</div>
				
				<!-- 배송지 정보 -->
				<div class="row box mb-30 ps-20 pe-20 pt-10 pb-10" style="height: 350px;">
					<div class="row fado bold">배송지</div>
					
					<!-- 배송지 내역 -->
					<div>
						<input class="dN form-input" type="hidden" name="deliveryNo" value="${deliveryDto.deliveryNo}">
						<br> 
						<input class="dR form-input mb-10" type="text" value="${deliveryDto.deliveryReceiver}" readonly>
						<br> 
						<input class="dP form-input mb-10" type="text" value="${deliveryDto.deliveryPost}" readonly> 
						<br> 
						<input class="ad1 form-input mb-10" type="text" value="${deliveryDto.deliveryAddr1}" readonly> 
						<br> 
						<input class="ad2 form-input mb-10" type="text" value="${deliveryDto.deliveryAddr2}" readonly> 
						<br> 
						<input class="ct form-input" type="text" value="${deliveryDto.deliveryContact}" readonly>
					</div>
					
					<div class="row mb-10">
						<button type="button" class="btn change-delivery-btn">변경</button>
					</div>
							
				</div>
				<!-- 배송지 정보 끝 -->
				
			</div>
			<!-- 세 개의 정보(왼쪽) 끝 -->
			
			<!-- 파도 정보(오른쪽) 시작 -->
			<div class="right-box">
			
				<!-- 결제 정보 -->
				<div class="left box mb-30 ps-20 pe-20 pt-10 pb-10"  style="height: 200px;">
					<div class="row fado bold">결제수단</div>
					
					<div class="flex-container mt-10 mb-10">
						<div class="me-10">내가 보유한 포인트</div>
						<div style="background-color:lightgray; border-radius:3px;" class="me-10">${memberDto.memberPoint}</div>
						<div> pt</div>
					</div>
					<div style="color:gray; font-size:12px; ">* 포인트 부족 시 결제를 진행할 수 없습니다.</div>
				</div>
				
				<!-- 리워드 정보  -->
				<div class="left box mb-30 ps-20 pe-20 pt-10 pb-10"  style="height: 350px;">
					<div class="row fado bold">파도 정보</div>
					<div class="row mt-70">
						<input type="hidden" name="rewardNo" value="${rewardDto.rewardNo}">
						<div>파도 구성 ${rewardDto.rewardType}</div>
						<div class="mb-10">파도 금액 ${rewardDto.rewardPrice} 원</div>
						<div style="color:gray; font-size:12px; ">* 후원은 상품 구매가 아닌 프로젝트의 지원입니다.</div>
						<div style="color:gray; font-size:12px; ">* 프로젝트는 기존의 아이디어와 다르게 진행될 수 있으며, </div>
						<div style="color:gray; font-size:12px; ">완수의 책임은 창작자에게 있습니다.</div>
					</div>
	
					<div class="row mt-40">
						<button class="btn btn-positive" type="submit">주문하기</button>
					</div>
				</div>
				
			</div>
			<!-- 파도 정보(오른쪽) 끝 -->
		</div>
		
		
		<!-- 배송지 다른 거 -->
		<div id="deliveryModal" class="modal">
			<div class="modal-content">
			
				<span class="close">&times;</span>
				<h2>새로운 배송지 선택</h2>
				
				<div class="container w-400">
				
					<c:forEach var="deliveryDto" items="${deliveryList}">
						<div class="btn mt-10 dList" style="display: block;">
						
							<div class="row">
								<input type="hidden" name="deliveryNo"
									value="${deliveryDto.deliveryNo}">
							</div>
							<div class="row">
								<input type="text" name="cdR" value="${deliveryDto.deliveryReceiver}"
									readonly class="form-input">
							</div>
							<div class="row">
								<input type="text" name="cdP" value="${deliveryDto.deliveryPost}"
									readonly class="form-input">
							</div>
							<div class="row">
								<input type="text" name="cad1" value="${deliveryDto.deliveryAddr1}"
									readonly class="form-input">
							</div>
							<div class="row">
								<input  type="text" name="cad2" value="${deliveryDto.deliveryAddr2}"
									readonly class="form-input">
							</div>
							<div class="row">
								<input type="text" name="cct" value="${deliveryDto.deliveryContact}"
									readonly class="form-input">
							</div>
							<div class="row">
								<button type="button" class="row btn delivery-btn">선택</button>
							</div>
							
						</div>
					</c:forEach>
					
				</div>
				
		
			</div>	
		</div>
	</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>