<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>






<div class="container w-800">

   <div class="row mt-50">
      <a class="btn" style="background-color: #DEF2FF" href="/helperCommunity/noticeList">공지사항</a>
      <a class="btn" href="/helperCommunity/qnaList">Q & A</a>
   </div>

   <%-- 
      검색일 경우 검색어를 추가로 출력 
      (참고) 논리 반환값을 가지는 getter 메소드는 get이 아니라 is로 시작한다
   --%>
   <c:if test="${vo.search}">
   <div class="row left">
      &quot;${vo.keyword}&quot;에 대한 검색 결과
   </div>
   </c:if>

   
       <div class="container w-600">
        <div class="row mb-50 mt-50">
            <h1 style="font-size:30px;">공지사항</h1>
            <hr style="border-color:#2c8de0; border-width:0.5px;">
        </div>
        
         <c:if test="${sessionScope.name != null && sessionScope.level == '관리자'}">
       <div class="row right">
           <a href="write" class="btn btn-positive">
               <i class="fa-solid fa-pen"></i>
               글쓰기
           </a>
       </div>
      </c:if>
        <div class="mt-30">
           <c:forEach var="mainCommunityListDto" items="${noticeList}">
           <div class="">
               <a class="link" href="detail?mainCommunityNo=${mainCommunityListDto.mainCommunityNo}"
                  style="font-weight:bold; font-size:18px;">
                        ${mainCommunityListDto.mainCommunityTitle}</a>
           </div>
           <div class="flex-container">
              <div>
               ${mainCommunityListDto.getMainCommunityWriterString()}
              </div>
              <div class="ms-20 me-10">
                 <i class="fa-regular fa-window-minimize fa-rotate-90"></i>
              </div>
              <div>
               ${mainCommunityListDto.mainCommunityRegDate}
              </div>
           </div>
           <div class="mt-20 mb-20">
               <hr>
           </div>
           </c:forEach>
        </div>
    </div>
   

   
      <div class="row page-navigator mv-30 mt-50">
      <!-- 이전 버튼 -->
      <c:if test="${!vo.first}">
      
         <a href="notictList?${vo.prevQueryString}">
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
               <a href="noticeList?${vo.getQueryString(i)}">${i}</a> 
            </c:otherwise>
         </c:choose>
      </c:forEach>
      
      <!-- 다음 버튼 -->
      <c:if test="${!vo.last}">
         <a href="noticeList?${vo.nextQueryString}">
            <i class="fa-solid fa-angle-right"></i>
         </a>
      </c:if>
   </div>
   
   <!-- 검색창 -->
   <form action="noticeList" method="get">
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