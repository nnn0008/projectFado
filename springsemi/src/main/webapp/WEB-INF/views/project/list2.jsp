<%--  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
 
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:if test="${sessionScope.name != null}">
	<div class="row right">
		<c:if test="${sessionScope.level == '관리자'}">
		<button type="submit" class="btn btn-negative delete-btn">
			<i class="fa-solid fa-trash"></i>
			일괄삭제
		</button>
		</c:if>
	
		<a href="write" class="btn">
			<i class="fa-solid fa-pen"></i>
			글쓰기
		</a>
	</div>
	</c:if>
	
	
		검색일 경우 검색어를 추가로 출력 
		(참고) 논리 반환값을 가지는 getter 메소드는 get이 아니라 is로 시작한다
	
	<c:if test="${vo.search}">
	<div class="row left">
		&quot;${vo.keyword}&quot;에 대한 검색 결과
	</div>
	</c:if>
	
	<div class="row">
		<table class="table table-slit">
			<thead>
				<tr>
					<c:if test="${sessionScope.level == '관리자'}">
					<th>
						<!-- 전체선택 체크박스 -->
						<input type="checkbox" class="check-all">
					</th>
					</c:if>
					<th>번호</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>펀딩 시작일</th>
					<th>펀딩 마감일</th>
					<th>등록일</th>
					<th>내용</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="projectListDto" items="${list}">
				<tr>
					<c:if test="${sessionScope.level == '관리자'}">
					<td>
						<!-- 개별항목 체크박스 -->
						<input type="checkbox" class="check-item" name="boardNoList" value="${boardListDto.boardNo}">
					</td>
	</c:if>
	</tr>
	</c:forEach>
	</tbody>
	</table>
	</div>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>  --%>