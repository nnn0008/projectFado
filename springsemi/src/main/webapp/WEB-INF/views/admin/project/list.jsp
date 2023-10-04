<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



<div class="container w-800">
	<div class="row">
		<div>
			<hr>
			<h1>펀딩 심사 목록</h1>
			<hr class="mb-20">
		</div>
	<c:forEach var="projectListDto" items="${projectList}">
	
		<div class="left">
			${projectListDto.majorCategoryType} > 
			${projectListDto.minorCategoryType}
		</div>
		<div class="flex-container">
			<div style="font-weight:bold; font-size:18px;">
				${projectListDto.projectNo}
			</div>
			<div class="ms-20 me-10">
				 <i class="fa-regular fa-window-minimize fa-rotate-90"></i>
			</div>
			<div class="me-20">
				<a class="link" href="/project/detail?projectNo=${projectListDto.projectNo}"
					style="font-weight:bold; font-size:18px;">
				${projectListDto.projectTitle}
				</a>
			</div>
			<div class="me-20 mb-20">
				<i class="fa-solid fa-eye"></i> ${projectListDto.projectReadcount}
			</div>
			<div class="me-20">
				<i class="fa-solid fa-heart red"></i> ${projectListDto.projectLikecount}
			</div>
			<div>
				<a href="delete?projectNo=${projectListDto.projectNo}">
					<i class="fa-regular fa-trash-can" style="color: #ff0000;"></i>
				</a>
			</div>
		</div>
		<div class="flex-container auto-width left">
			<div>
				<div>
					등록일 : ${projectListDto.projectRegDate}
				</div>
				<div>
					시작일 : ${projectListDto.projectStartDate}
				</div>
				<div>
					종료일 : ${projectListDto.projectEndDate}
				</div>
			</div>
			<div>
				<div>
					목표금액 : ${projectListDto.projectGoalPrice}
				</div>
				<div>
					모인금액 : ${projectListDto.projectTotalPrice}
				</div>
			</div>
			<div>
				<div>
					심사일 : ${projectListDto.judgeDate}
				</div>
				<div>
					심사단계 : ${projectListDto.judgeStatus}
				</div>
			</div>
		</div>
		<hr>		
	</c:forEach>
				
		<br>
		</div>
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
						<a href="/project/list?page=${end+1}&keyword=${param.keyword}">&gt;</a>
					</c:when>
					<c:otherwise>
						<a href="/project/list?page=${end+t}">&gt;</a> <!-- 다른 페이지라면 링크가 포함된 숫자를 보여주기 -->
					</c:otherwise>
				</c:choose>	 
			</c:if>
			</h3>
		</div>
			
			
			
		<br>
	</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>