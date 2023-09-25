<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(document).ready(function () {
    $(".link").click(function (event) {
        event.preventDefault(); // 기본 링크 동작 방지

        var link = $(this);
        var row = link.closest("tr"); // 클릭된 버튼이 속한 <tr> 요소 가져오기
        var followerId = row.data("follower");
        var followeeId = row.data("followee");

        // AJAX 요청
        $.ajax({
            url: link.attr("href"),
            type: "POST", // 또는 "GET" 등
            data: {
                followerId: followerId,
                followeeId: followeeId
            },
            success: function (response) {
                if (link.text() === "팔로우하기") {
                    link.text("팔로우해제");
                    link.attr("href", "/member/follow/cancel?followerId=" + followerId + "&followeeId=" + followeeId);
                } else {
                    link.text("팔로우하기");
                    link.attr("href", "/member/follow/following?followerId=" + followerId + "&followeeId=" + followeeId);
                }
            },
            error: function () {
                console.error("팔로우/팔로우해제 요청에 오류가 발생했습니다.");
            }
        });
    });
});
</script>


<div class="row">
<table border="1" width="800">
    <thead>
        <tr>
            <th>팔로위</th>
            <th>팔로우한 날짜</th>
            <th>버튼</th>
        </tr>
    </thead>
    <tbody align="center">
        <c:forEach var="memberFollowDto" items="${list}">
            <tr data-follower="${memberFollowDto.followerId}" data-followee="${memberFollowDto.followeeId}">
                <td>${memberFollowDto.followeeId}</td>
                <td>${memberFollowDto.followDate}</td>
                <td>
                    <c:choose>
                        <c:when test="${memberFollowDto.followYN == 'Y'}">
                            <a class="link" href="/member/follow/cancel?followerId=${memberFollowDto.followerId}&followeeId=${memberFollowDto.followeeId}">팔로우해제</a>
                        </c:when>
                        <c:otherwise>
                            <a class="link" href="/member/follow/following?followerId=${memberFollowDto.followerId}&followeeId=${memberFollowDto.followeeId}">팔로우하기</a>
                        </c:otherwise>
                    </c:choose> 
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table> 

</div>



	<div class="row page-navigator mv-30">
		<!-- 이전 버튼 -->
		<c:if test="${!vo.first}">
			<a href="list?${vo.prevQueryString}">
				<i class="fa-solid fa-angle-left"></i>
			</a>
		</c:if>
		
		<!-- 숫자 버튼 -->
		<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
			<c:choose>
				<c:when test="${vo.page == i}">
					<a class="on">${i}</a>
				</c:when>
				<c:otherwise>
					<a href="list?${vo.getQueryString(i)}">${i}</a> 
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 다음 버튼 -->
		<c:if test="${!vo.last}">
			<a href="list?${vo.nextQueryString}">
				<i class="fa-solid fa-angle-right"></i>
			</a>
		</c:if>
	</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>