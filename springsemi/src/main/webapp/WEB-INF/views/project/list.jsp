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
					<th>심사단계</th>			
				</tr>
			</thead>
			<tbody>
				<c:forEach var="projectListDto" items="${projectList }">
				<tr>
					<td>${projectListDto.projectNo}</td>
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
					<td>심사여부</td>				
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>