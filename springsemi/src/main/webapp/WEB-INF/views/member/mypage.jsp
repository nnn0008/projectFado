 <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
        /* 기본 마진 제거 */
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
        }
    
        /* 전체 화면을 채우도록 설정 */
        .container {
            min-height: 100%;
            display: flex;
            flex-direction: column;
        }
    
        /* 상단 내용을 채우도록 설정 */
        .flex-container.auto-width {
            flex-grow: 1;
        }
    
        .line {
            display: flex;
            flex-basis: 100%;
            align-items: center;
            color: black;
            margin: 8px 0px;
        }
    
        .graybox {
            background-color: rgb(245, 245, 245);
            color: #202020;
            padding-top:12%;
            padding-bottom:12%;
            border-radius: 15px;
            margin-right: 30%;
            align-items: center;
		    text-align: center;
		    flex-direction: column; 
            justify-content: center;
            display: flex;
            height: 150px;
        }
        
		.image {
		width:100px;
		height:100px;
		}
</style>

<div class="container mt-70" >
        <div class="flex-container auto-width">

            <!-- 프로필 왼쪽 -->
            <div class="ms-50 row w-10 mt-30 mb-100">

                <c:choose>
                    <c:when test= "${profile == null}">
                        <img src ="/images/user.png" width="100" height ="100" 
                        class="image image-circle image-border profile-image" >
                    </c:when>
                    <c:otherwise>
                    <img src ="${pageContext.request.contextPath}/rest/member/download?attachNo=${profile}" width="100" height ="100" 
                        class="image image-circle image-border profile-image" >
                    </c:otherwise>
                </c:choose>

                <label style="display: block; font-size:15px;" class="mb-10 mt-10">
                    ${memberDto.memberNickname}님의 회원 정보
                </label>
                <hr class="w-50 mb-20">
                <a class="btn" href="mypageDetail">
                    내 정보 보기
                </a>
            </div>
            
        
            <!-- 프로필 오른쪽 -->
            <div class="ms-100 flex-container auto-width w-75">

                <div class= "container">

                    <div class="flex-container graybox">
                        <div style="display:block; font-size:20px;">
                            포인트 
                            <fmt:formatNumber value="${memberDto.memberPoint}" 
                            pattern="#,##0"></fmt:formatNumber> pt 
                            
                            
                             <div class="mt-30">
					        	<a href="pointPlus">
						        	<button type="button" class="btn">
						        		포인트 충전 <i class="fa-solid fa-coins" style="color: #508fe0;"></i>
						        	</button>
				        		</a>
	       					 </div>
                        </div>
                    </div>

                    <div class="left mt-100 mb-10">
                        <span class="bold">나의 활동</span>
                    </div>
                    
                    <div class="left mb-10">
                        <a href="follow/list" class="link">팔로잉</a>
                    </div>
                </div>

                <div class= "container">
                    <div class="left graybox">
                        <span>펀딩내역</span>
                        <br>
                        <span>
                        내가 서핑한 파도
                        <br>
                        <i class="fa-regular fa-hand-point-right"></i><a href="${pageContext.request.contextPath}/orders/list" class="link"> 보러가기</a>
                        </span>
                    </div>
                    <div class="left mt-100 mb-10">
                        <span class="bold">고객센터</span>
                    </div>
                    <div class="left mb-10">
                        <a href="${pageContext.request.contextPath}/mainCommunity/noticeList" class="link">공지사항</a>
                    </div>
                </div>

            </div>

        </div>
    </div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>