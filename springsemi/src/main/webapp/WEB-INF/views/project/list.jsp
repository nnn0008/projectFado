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
            <h1 style="font-size:30px;">검색결과</h1>
            <h4></h4>
            <hr style="border-color:#2c8de0; border-width:0.5px;">
        	</div>
        </div>
        
        
	<div class="list_wrap row">
	<ul>
	
	
	<c:forEach var="projectListAttachDto" items="${projectList}">
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
								<p class="ms-10">n일 남음</p>
							</div>
						</div> 
                   	</li>
	</c:forEach>
	</ul>
	</div>
        

<!-- <div class="container w-800"> -->
<!-- 	<div class="row"> -->
<!-- 		<table> -->
<!-- 			<thead> -->
<!-- 				<tr> -->
<!-- 					<th>번호</th> -->
<!-- 					<th>제목</th> -->
<!-- 					<th>판매자</th> -->
<!-- 					<th>등록일</th> -->
<!-- 					<th>시작일</th> -->
<!-- 					<th>종료일</th> -->
<!-- 					<th>목표금액</th> -->
<!-- 					<th>모인금액</th> -->
<!-- 					<th>조회수</th> -->
<!-- 					<th>좋아요</th> -->
<!-- 					<th>대분류</th> -->
<!-- 					<th>소분류</th> -->
<!-- 					<th>심사일</th> -->
<!-- 					<th>심사단계</th>			 -->
<!-- 				</tr> -->
<!-- 			</thead> -->
<!-- 			<tbody> -->
<%-- 				<c:forEach var="projectListDto" items="${projectList}"> --%>
<!-- 				<tr> -->
<%-- 					<td>${projectListDto.projectNo }</td> --%>
<!-- 					<td> -->
<%-- 					<a class="link" href="detail?projectNo=${projectListDto.projectNo}"> --%>
<%-- 						${projectListDto.projectTitle} --%>
<!-- 					</a> -->
<!-- 					</td> -->
<%-- 					<td>${projectListDto.projectOwner}</td> --%>
<%-- 					<td>${projectListDto.projectRegDate}</td> --%>
<%-- 					<td>${projectListDto.projectStartDate }</td> --%>
<%-- 					<td>${projectListDto.projectEndDate}</td> --%>
<%-- 					<td>${projectListDto.projectGoalPrice }</td> --%>
<%-- 					<td>${projectListDto.projectTotalPrice }</td> --%>
<%-- 					<td>${projectListDto.projectReadcount}</td> --%>
<%-- 					<td>${projectListDto.projectLikecount }</td> --%>
<%-- 					<td>${projectListDto.majorCategoryType}</td> --%>
<%-- 					<td>${projectListDto.minorCategoryType}</td>	 --%>
<%-- 					<td>${projectListDto.judgeDate}</td> --%>
<%-- 					<td>${projectListDto.judgeStatus}</td>				 --%>
<!-- 				</tr> -->
<%-- 				</c:forEach> --%>
<!-- 			</tbody> -->
<!-- 		</table> -->
<!-- 		<br> -->
<div class="container w-600">
		<div class="row">			
			<!-- 페이지 네비게이터 출력 -->
			<h3>
			<!-- 이전 버튼 : begin이 1이면 없다 -->
			<c:if test="${begin > 1}">
			<!-- 링크는 검색과 목록을 따로 구현 -->
				<c:choose>
					<c:when test="${isSearch }">
						<a href="list?page=${begin-1}&keyword=${param.keyword}">&lt;</a>
					</c:when>
					<c:otherwise>
						<a href="list?page=${begin-1}">&lt;</a> <!-- 다른 페이지라면 링크가 포함된 숫자를 보여주기 -->
					</c:otherwise>
				</c:choose>	
			</c:if>
			<!-- 숫자 부분 -->
				<c:forEach var="i" begin="${begin}" end="${end}" step="1">
					<c:choose>
						<c:when test="${page == i }">
							${i} <!-- 현재페이지라면 숫자만 보여주기 -->
						</c:when>
						<c:otherwise>
							<!-- 링크는 검색과 목록을 따로 구현 -->
							<c:choose>
								<c:when test="${isSearch }">
									<a href="list?page=${i}&keyword=${param.keyword}"></a>
								</c:when>
								<c:otherwise>
									<a href="list?page=${i}">${i}</a> <!-- 다른 페이지라면 링크가 포함된 숫자를 보여주기 -->
								</c:otherwise>
							</c:choose>	
						</c:otherwise>						
					</c:choose>
				</c:forEach>
			<!-- 다음 버튼 : 마지막 숫자(end)가 pageCount보다 크면 없다 -->
			<c:if test="${end < pageCount}">
				<!-- 링크는 검색과 목록을 따로 구현 -->
				<c:choose>
					<c:when test="${isSearch}">
						<a href="list?page=${end+1}&keyword=${param.keyword}">&gt;</a>
					</c:when>
					<c:otherwise>
						<a href="list?page=${end+t}">&gt;</a> <!-- 다른 페이지라면 링크가 포함된 숫자를 보여주기 -->
					</c:otherwise>
				</c:choose>	 
			</c:if>
			</h3>
			
			
		<br>
	</div>
</div> 
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>