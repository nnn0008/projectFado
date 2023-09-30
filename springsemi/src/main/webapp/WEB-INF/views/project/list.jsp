<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800">
	<div class="row">
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>판매자</th>
					<th>등록일</th>
					<th>시작일</th>
					<th>종료일</th>
					<th>목표금액</th>
					<th>모인금액</th>
					<th>조회수</th>
					<th>좋아요</th>
					<th>대분류</th>
					<th>소분류</th>
					<th>심사일</th>
					<th>심사단계</th>			
				</tr>
			</thead>
			<tbody>
				<c:forEach var="projectListDto" items="${projectList}">
				<tr>
					<td>${projectListDto.projectNo }</td>
					<td>
					<a class="link" href="detail?projectNo=${projectListDto.projectNo}">
						${projectListDto.projectTitle}
					</a>
					</td>
					<td>${projectListDto.projectOwner}</td>
					<td>${projectListDto.projectRegDate}</td>
					<td>${projectListDto.projectStartDate }</td>
					<td>${projectListDto.projectEndDate}</td>
					<td>${projectListDto.projectGoalPrice }</td>
					<td>${projectListDto.projectTotalPrice }</td>
					<td>${projectListDto.projectReadcount}</td>
					<td>${projectListDto.projectLikecount }</td>
					<td>${projectListDto.majorCategoryType}</td>
					<td>${projectListDto.minorCategoryType}</td>	
					<td>${projectListDto.judgeDate}</td>
					<td>${projectListDto.judgeStatus}</td>				
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>
			
			<!-- 페이지 네비게이터 출력 -->
			<h3>
			<!-- 이전 버튼 : begin이 1이면 없다 -->
			<c:if test="${begin > 1}">
			<%-- 링크는 검색과 목록을 따로 구현 --%>
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
							${i} <%-- 현재페이지라면 숫자만 보여주기 --%>
						</c:when>
						<c:otherwise>
							<%-- 링크는 검색과 목록을 따로 구현 --%>
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
				<%-- 링크는 검색과 목록을 따로 구현 --%>
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