<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container w-500">
	<div class="row">
		<h1>내가 서핑한 파도</h1>
	</div>
	<div class="row" style="border: 1px solid #2c8de0; border-radius: 5px;">
		<c:forEach var="ordersListDto" items="${ordersList}">
			<div class="row flex-container">
				<div class="row" style="flex-grow: 3;">
					<div>
						주문번호 : ${ordersListDto.ordersNo}
					</div>
					<div>
						프로젝트 이름 : ${ordersListDto.projectTitle}
					</div>
					<div>
						리워드구성 : ${ordersListDto.ordersReward}
					</div>
					<div>
						리워드가격 : ${ordersListDto.ordersPrice}원
					</div>
					<div>
						주문상태 : ${ordersListDto.ordersStatus}
					</div>
					<div>
						결제상태 : ${ordersListDto.paymentStatus}
					</div>
				</div>
				<div class="row" style="flex-grow: 1; display: flex; justify-content: center; align-items: center;">
					<button class="btn">
						<a href="/project/detail?projectNo=${ordersListDto.projectNo}">
							다시구경가기</a>
					</button>
				</div>
			</div>
		</c:forEach>
	</div>
</div>







<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

