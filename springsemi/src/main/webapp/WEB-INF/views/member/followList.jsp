<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<script>
$(document).ready(function () {
    $(".link").click(function (event) {
        event.preventDefault(); // 기본 링크 동작 방지

        var link = $(this);
        var row = link.closest("tr"); // 클릭된 버튼이 속한 <tr> 요소 가져오기 (팔로우 버튼이 포함된 행)
        var followerId = row.data("follower"); //팔로우한 사람
        var followeeId = row.data("followee"); //팔로우당한 사람
        var isFollowing = link.text() === "팔로우하기"; // 현재 상태 판단
						//클릭한 버튼의 텍스트
        // AJAX 요청
        $.ajax({
            url: isFollowing ? "/member/follow/following" : "/member/follow/cancel",
            type: "POST", // 또는 "GET" 등
            data: {
                followerId: followerId,
                followeeId: followeeId
            },
            success: function (response) {
                if (isFollowing) {
                    link.text("팔로우해제");
                    link.attr("href", "/member/follow/cancel?followerId=" + followerId + "&followeeId=" + followeeId);
                    $(this).removeClass("fa-plus").addClass("fa-check");
                } else {
                    link.text("팔로우하기");
                    link.attr("href", "/member/follow/following?followerId=" + followerId + "&followeeId=" + followeeId);
                    $(this).removeClass("fa-check").addClass("fa-plus");
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
                            <a class="link" href="#">
                            <i class="fa-solid fa-check"></i>
                            팔로우해제
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a class="link" href="#">
                            <i class="fa-solid fa-plus"></i>
                            팔로우하기
                            </a>
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
