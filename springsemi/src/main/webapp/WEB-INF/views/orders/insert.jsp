<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</style>
    
<script>
$(function(){
        $(".change-delivery-btn").click(function() {
            $("#deliveryModal").show();
        });

        $(".close").click(function() {
            $("#deliveryModal").hide()
        });
		
        $(".delivery-btn").click(function(){
        	$(".dR").val(".cdR");
        	$(".dP").val(".cdP");
        	$(".ad1").val(".cad1");
        	$(".ad2").val(".cad2");
        	$(".ct").val(".cct");
        });
});
</script>
    



<form action="/orders/insert" method="post">
	<div class="container w-800">
	
		<div class="row">
			<div class="flex-container">
				<div class="w-50">
					사진		
				</div>
				<div class="w-50">
					<input type="hidden" name="projectNo" value="${projectDto.projectNo}">
					<div class="row">
					대분류/소분류 : ?
					</div>
					<div class="row">
					제목 : ${projectDto.projectTitle}
					</div>
					<div class="row">
					모인금액 : ${projectDto.projectTotalPrice} / 달성률 : ?
					</div>
					<div class="row">
					종료일자 : ${projectDto.projectEndDate}
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="flex-container">
				<div class="w-50">
					<div class="row">
						연락처 : ${memberDto.memberContact}
					</div>
					<div class="row">
						이메일 : ${memberDto.memberEmail}
					</div>
					<div class="row">
						배송지
					</div>
					<div class="row">
			            <div class="delivery-item mb-10" style="border: 1px solid #2c8de0; border-radius: 5px;">
			            	<input class="row" type="hidden" name="deliveryNo" value="${deliveryDto.deliveryNo}">
			                <div class="row dR">${deliveryDto.deliveryReceiver}</div>
			                <div class="row dP">${deliveryDto.deliveryPost}</div>
			                <div class="row ad1">${deliveryDto.deliveryAddr1}</div>
			                <div class="row ad2">${deliveryDto.deliveryAddr2}</div>
			                <div class="row ct">${deliveryDto.deliveryContact}</div>
			                <div class="row">
			                	<button type="button" class="btn change-delivery-btn">변경</button>
			                </div>
			            </div>
					    </div>
					   
					   <div id="deliveryModal" class="modal">
				        	<div class="modal-content">
				            <span class="close">&times;</span>
				            <h2>새로운 배송지 선택</h2>
				            	<div class="container w-400" >
								<c:forEach var="deliveryDto" items="${deliveryList}">
<!-- 									<div class="row" style="border: 1px solid #2c8de0; border-radius: 10px;"> -->
									<div class="btn mt-10"  style="display:block;">
										<div class="row">
											<input class="row" type="hidden" name="deliveryNo" value="${deliveryDto.deliveryNo}">
										</div>
										<div class="row cdR">
											<input  type="text" value="${deliveryDto.deliveryReceiver}" readonly>
										</div>
										<div class="row cdP">
											<input  type="text" value="${deliveryDto.deliveryPost}" readonly>
										</div>
										<div class="row cad1">
											<input  type="text" value="${deliveryDto.deliveryAddr1}" readonly>
										</div>
										<div class="row cad2">
											<input  type="text" value="${deliveryDto.deliveryAddr2}" readonly>
										</div>
										<div class="row cct">
											<input  type="text" value="${deliveryDto.deliveryContact}" readonly>
										</div>
										<div class="row">
											<button type="button" class="row btn delivery-btn">선택</button>
										</div>
									</div>
								</c:forEach>
							</div>
				        	</div>
				    	</div>
					   
					   
					   
					   
					<div class="row">
						결제수단
						내가 보유한 포인트 : ${memberDto.memberPoint}
					</div>
				</div>
				<div class="w-50">
				<input type="hidden" name="rewardNo" value="${rewardDto.rewardNo}">
					<div class="row">
						리워드 구성 : ${rewardDto.rewardType}
					</div>
					<div class="row">
						리워드 가격 : ${rewardDto.rewardPrice}원
					</div>
					<hr>
					서퍼 소개
					서퍼 내용
					<hr>
					개인정보 제공 동의
					후원 유의사항 확인				
				</div>
				
				<div class="row">
					<button class="btn btn-positive" type="submit">
							주문하기
					</button>
				</div>
			</div>
		</div>
	
	</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>