<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
	 ul,li{
            list-style: none;
        }

        a{
            text-decoration: none;
            color: inherit;
        }

        .list_wrap{
            /* 가로길이 고정 */
            width: 100%;
            /* 최소 가로길이 */
            min-width: 1000px;
            /* 최대 가로길이 */
            max-width: 1200px;
            /* 가운데 정렬 */
            margin: 0 auto;
            padding: 40px;
            margin-top: 5%;
        }

        /* .list_wrap ul{
            font-size: 5;
        } */

        .list_wrap .item {
            width: 20%;
            display: inline-block;
            margin-left: 2%;
            margin-right: 2%;
            margin-top: 2%;
            margin-bottom: 2%;
            /* box-shadow: 0px 0px 4px rgba(0, 0, 0, 0.5); */
        }

        .list_wrap .item .image{
            width: 100%;
            height: 150px;
/*             background: url(./image/noshowoff.jpg); */
            background-repeat: no-repeat;
            background-position: 50% 50%;
            background-size: cover;
        }

        .list_wrap .item .cont{
            padding: 4px;
        }

        .list_wrap .item strong {
            /* 이게 있어야 마진이 적용됨 */
            display: block;
            /* 이미지랑 제목, 내용 간격띄우기 */
            margin: 8px 0 5px 0;
            font-size: 16px;
            /* 글자간격줄이기 */
            letter-spacing: -1px;
        }

        .list_wrap .item p{
            font-size: 12px;
            letter-spacing: -1px;
        }

        .list_wrap .item a{
            /* p태그랑 겹치지 않게하기위함 */
            display: inline-block;
            /* 상하좌우 여백 */
            padding: 3px 6px;
            /* background: #2c8ce09e; */
           /*  border: 1px solid #2c8ce09e; */
            font-size: 12px;
            letter-spacing: -1px;
            margin-top: 5px;
            /* transition: ; */
            
        }

        .item:hover{
            color: #2c8ce053;
            
        }
        
        .product {
        height:210px;
        width:210px;
        margin: 0 auto;
        overflow: hidden; /* 이미지가 넘치는 경우를 방지하기 위해 추가 */
        display: flex;
    	justify-content: center; /* 수평 가운데 정렬 */
        }
        
        </style>
        
        <div class="container w-600">
        	<div class="row mb-50 mt-50">
            <h1 style="font-size:30px;">펀딩 + </h1>
            <h4>전체 펀딩 리스트</h4>
            <hr style="border-color:#2c8de0; border-width:0.5px;">
        	</div>
        </div>
	<div class="list_wrap">
	<ul>
	
	
	<c:forEach var="projectListAttachDto" items="${fundingList}">
                   	<li class="item">
                   		<div>
							<a href="/project/detail?projectNo=${projectListAttachDto.projectNo}">
								<img class="product w-100" src="/rest/project/download?attachNo=${projectListAttachDto.attachNo}">
							</a>
						</div>
                       	<div class="left me-10 ms-10">
							<p>${projectListAttachDto.majorCategoryType} | ${projectListAttachDto.minorCategoryType }</p>
							<a href="/project/detail?projectNo=${projectListAttachDto.projectNo}" style=" margin: 0; padding: 0;">
								<strong>${projectListAttachDto.projectTitle}</strong>
							</a>
							
							<div class="flex-container">
								<p><fmt:formatNumber value="${projectListAttachDto.achievementRate * 100}" pattern="0.#"/>% 달성</p>
							</div>
						</div> 
                   	</li>
	</c:forEach>
	
	</ul>
</div>
	<div class="container w-600">
		<div class="row page-navigator mv-30">
		<!-- 이전 버튼 -->
		<c:if test="${!vo.first}">
			<a href="readCountList?${vo.prevQueryString}">
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
					<a href="readCountList?${vo.getQueryString(i)}">${i}</a> 
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 다음 버튼 -->
		<c:if test="${!vo.last}">
			<a href="readCountList?${vo.nextQueryString}">
				<i class="fa-solid fa-angle-right"></i>
			</a>
		</c:if>
	</div>
</div> 


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>