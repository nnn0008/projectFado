<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:forEach var="projectListAttachDto" items="${readCountList}" end="7">
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




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>