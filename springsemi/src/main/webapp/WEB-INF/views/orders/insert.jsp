<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .delivery-list {
        display: none;
    }

    /* 선택한 배송지의 스타일 */
    .selected-delivery {
        background-color: #2c8de0;
        color: white;
    }
</style>

<script>
    $(document).ready(function() {
        // "배송지 선택하기" 버튼을 클릭했을 때 실행될 함수를 정의합니다.
        $(".toggle-button").click(function() {
            // 배송지 목록의 표시 여부를 토글합니다.
            $(".delivery-list").toggle();
        });

        // 배송지 항목을 클릭했을 때 실행될 함수를 정의합니다.
        $(".delivery-item").click(function() {
            // 선택한 배송지 항목의 정보 가져오기
            var receiver = $(this).find(".delivery-receiver").text();
            var post = $(this).find(".delivery-post").text();
            var addr1 = $(this).find(".delivery-addr1").text();
            var addr2 = $(this).find(".delivery-addr2").text();
            var contact = $(this).find(".delivery-contact").text();

            // 선택한 배송지 정보를 보여주는 엘리먼트에 적용
            $(".selected-info").html(`
                <div>${receiver}</div>
                <div>${post}</div>
                <div>${addr1}</div>
                <div>${addr2}</div>
                <div>${contact}</div>
            `);

            // 선택한 배송지 항목에 선택 표시를 추가하고, 다른 항목에서 선택 표시를 제거합니다.
            $(".delivery-item").removeClass("selected-delivery");
            $(this).addClass("selected-delivery");
        });
    });
</script>
	
	<div class="container w-800">
	
		<div class="row">
			<div class="flex-container">
				<div class="w-50">
					사진		
				</div>
				<div class="w-50">
					대분류/소분류
					제목
					모인금액 / 달성률
					종료일자
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
				    <button class="btn toggle-button">배송지 선택하기</button>
					    <div class="delivery-list">
					        <c:forEach var="deliveryDto" items="${deliveryList}">
					            <div class="delivery-item" style="border: 1px solid #2c8de0; border-radius: 5px;">
					                <div class="delivery-receiver">${deliveryDto.deliveryReceiver}</div>
					                <div class="delivery-post">${deliveryDto.deliveryPost}</div>
					                <div class="delivery-addr1">${deliveryDto.deliveryAddr1}</div>
					                <div class="delivery-addr2">${deliveryDto.deliveryAddr2}</div>
					                <div class="delivery-contact">${deliveryDto.deliveryContact}</div>
					                <div class="row">
					                	<button class="btn">선택</button>
					                </div>
					            </div>
					        </c:forEach>
					    </div>
					</div>
					<div class="selected-info"></div>
					<div class="row">
						결제수단
						내가 보유한 포인트 : ${memberDto.memberPoint}
					</div>
				</div>
				<div class="w-50">
					<div class="row">
						리워드 구성 : ${rewardDto.rewardType}
					</div>
					<div class="row">
						리워드 가격 : ${rewardDto.rewardPrice}
					</div>
					<hr>
					서퍼 소개
					서퍼 내용
					<hr>
					개인정보 제공 동의
					후원 유의사항 확인				
				</div>
				
				<div class="row">
					<button class="btn btn-positive">
						<a class="link" href="insertFinish">
							주문하기
						</a>
					</button>
				</div>
			</div>
		</div>
	
	</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>