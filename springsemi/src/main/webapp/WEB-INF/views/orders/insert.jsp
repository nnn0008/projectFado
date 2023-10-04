<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .delivery-list {
        display: none;
    }

    /* 선택한 배송지의 스타일 */
/*     .selected-delivery { */
/*         background-color: #2c8de0; */
/*         color: white; */
/*     } */
</style>



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
			                <div class="row">${deliveryDto.deliveryReceiver}</div>
			                <div class="row">${deliveryDto.deliveryPost}</div>
			                <div class="row">${deliveryDto.deliveryAddr1}</div>
			                <div class="row">${deliveryDto.deliveryAddr2}</div>
			                <div class="row">${deliveryDto.deliveryContact}</div>
			                <div class="row">
			                	<button type="button" class="btn">변경</button>
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