<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	
</style>

<script>
$(document).ready(function () {
    $(".link").click(function (e) {
        e.preventDefault(); // 기본 링크 동작 방지

        var link = $(this);
        var row = link.closest("div"); // 클릭된 버튼이 속한 <div> 요소 가져오기 (팔로우 버튼이 포함된 행)
        var followerId = row.data("follower"); // 팔로우한 사람
        var followeeId = row.data("followee"); // 팔로우당한 사람
        var isFollowing = link.text().includes("팔로잉"); // 현재 상태 판단

        // AJAX 요청
        $.ajax({
            url: isFollowing ? "/member/follow/unfollowing" : "/member/follow/following",
            type: "POST", // 또는 "GET" 등
            data: {
                followerId: followerId,
                followeeId: followeeId
            },
            success: function (response) {
                if (isFollowing) {
                    link.html('<i class="fa-solid fa-plus"></i> 팔로우');
                } else {
                    link.html('<i class="fa-solid fa-check"></i> 팔로잉');
                }
            },
            error: function () {
                console.error("팔로우/팔로우해제 요청에 오류가 발생했습니다.");
            }
        });
    });
});
</script>




<div class="container w-800">
    <div class="row">
    	<h1>
        <i class="fa-regular fa-heart red"></i> 
        내가 팔로잉하는 서퍼
        <i class="fa-regular fa-bell yellow"></i>
        </h1>
    </div>

	<c:forEach var="memberFollowDto" items="${list}">
       <div class="row" style="display: flex; border: 1px solid #2c8de0; border-radius: 5px; 
       margin-top:5px; margin-bottom:10px; padding-top:5px; padding-bottom:5px;">
        
          <div style="flex-grow: 1; justify-content: center; align-items: center;">
           </div>
            
           <div class="left ml-20" style="flex-grow: 3;"
             data-follower="${memberFollowDto.followerId}" 
             data-followee="${memberFollowDto.followeeId}">
             
                <div style="height: 50%; display: flex; flex-direction: column; 
                	justify-content: center;" class="w-100">
                		${memberFollowDto.followeeId}
                </div>
                <div style="height: 50%; display: flex; flex-direction: column; 
	                justify-content: center;"class="w-100">
	                	팔로우 날짜 : ${memberFollowDto.followDate}
                </div>
                
           </div>

           <div style="flex-grow: 1; display: flex; justify-content: center; align-items: center;"
            data-follower="${memberFollowDto.followerId}" 
            data-followee="${memberFollowDto.followeeId}">
            	<c:choose>
                  <c:when test="${memberFollowDto.followYN == 'Y'}">
                      <button class="btn">
                          <a class="link">
                              <i class="fa-solid fa-check"></i> 팔로잉
                          </a>
                      </button>
                    </c:when>
                    <c:otherwise>
                       <button class="btn">
                          <a class="link">
                              <i class="fa-solid fa-plus"></i> 팔로우
                          </a>
                        </button>
                    </c:otherwise>
                </c:choose>
           	</div>
       	</div>
    </c:forEach>
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
