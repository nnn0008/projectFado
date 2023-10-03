<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	

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
						구매자 정보
						이름
						핸드폰 번호
					</div>
					<div class="row">
						배송지
						<c:forEach var="deliveryDto" items="${deliveryList}">
							<div class="container w-800">
								<div style="border: 1px solid #2c8de0; border-radius: 10px;" class="w-500 row container">
									<div class="row">
										${deliveryDto.deliveryReceiver}
									</div>
									<div class="row">
										${deliveryDto.deliveryPost}
									</div>
									<div class="row">
										${deliveryDto.deliveryAddr1}
									</div>
									<div class="row">
										${deliveryDto.deliveryAddr2}
									</div>
									<div class="row">
										${deliveryDto.deliveryContact}
									</div>
									<div class="row right">
										<button class="btn">선택</button>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="row">
						결제수단
						내가 보유한 포인트
					</div>
				</div>
				<div class="w-50">
					파도 정보
					파도 구성
					파도 금액
					예상 전달일
					<hr>
					서퍼 소개
					서퍼 내용
					<hr>
					개인정보 제공 동의
					후원 유의사항 확인				
				</div>
			</div>
		</div>
	
	</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>