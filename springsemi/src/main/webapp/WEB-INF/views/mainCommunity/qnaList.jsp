<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>






<div class="container w-800">

   <div class="row">
      <a class="btn" href="/mainCommunity/noticeList">공지사항</a>
      <a class="btn" style="background-color: #DEF2FF" href="/mainCommunity/qnaList">Q & A</a>
   </div>
   <%-- 글쓰기는 로그인 상태인 경우에만 출력 --%>
   <c:if test="${sessionScope.name != null && sessionScop.level == '관리자'}">
   <div class="row right">
      <a href="write" class="btn btn-positive">
         <i class="fa-solid fa-pen"></i>
         글쓰기
      </a>
   </div>
   </c:if>
   
   <%-- 
      검색일 경우 검색어를 추가로 출력 
      (참고) 논리 반환값을 가지는 getter 메소드는 get이 아니라 is로 시작한다
   --%>
   <c:if test="${vo.search}">
   <div class="row left">
      &quot;${vo.keyword}&quot;에 대한 검색 결과
   </div>
   </c:if>

   
   
   
   
   
   <div class="row">
      <table class="table table-slit">
         <thead>
            <tr>
               <th>번호</th>
               <th>분류</th>
               <th>작성자</th>
               <th width="40%">제목</th>
               <th>작성일</th>
            </tr>
         </thead>
         <tbody>
         <c:forEach var="mainCommunityListDto" items="${qnaList}">
            <tr>
               <td>${mainCommunityListDto.mainCommunityNo}</td>
               <td>${mainCommunityListDto.mainCommunityType}</td>
               <td>${mainCommunityListDto.getMainCommunityWriterString()}</td>
               <td align="left">
                  
                  <!-- 제목을 누르면 상세페이지로 이동 -->
                  <a class="link" href="detail?mainCommunityNo=${mainCommunityListDto.mainCommunityNo}">
                     ${mainCommunityListDto.mainCommunityTitle}
                  </a>
                  
               </td>
               <td>${mainCommunityListDto.mainCommunityRegDate}</td>
            </tr>
            </c:forEach>
         </tbody>
      </table>
   </div>
   
      <div class="row page-navigator mv-30">
      <!-- 이전 버튼 -->
      <c:if test="${!vo.first}">
         <a href="qnaList?${vo.prevQueryString}">
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
               <a href="qnaList?${vo.getQueryString(i)}">${i}</a> 
            </c:otherwise>
         </c:choose>
      </c:forEach>
      
      <!-- 다음 버튼 -->
      <c:if test="${!vo.last}">
         <a href="qnaList?${vo.nextQueryString}">
            <i class="fa-solid fa-angle-right"></i>
         </a>
      </c:if>
   </div>
   
   <!-- 검색창 -->
   <form action="qnaList" method="get">
   <div class="row">

      <input type="search" name="keyword"  required class="form-input"
               placeholder="검색어 입력" value="${param.keyword}">
      <button type="submit" class="btn btn-positive">
         <i class="fa-solid fa-magnifying-glass"></i>
         검색
      </button>
   </div>
   </form>
</div>







<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>