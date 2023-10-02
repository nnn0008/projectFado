<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<!-- 타이머를 생성 및 카운트다운 -->
<script>
$(function(){
	//최초 시간 찍어주고
	displayText(formatTime);
	
	//타이머 생성
	var timer = new easytimer.Timer();
	
	//타이머가 1초씩 지날때마다
	timer.addEventListener('secondsUpdated', function (e) {
		console.log(timer.getTotalTimeValues());
	    formatTime = convert2text(timer.getTotalTimeValues().seconds);
	    displayText(formatTime);
	});
	
	//타이머가 종료시
	timer.addEventListener('targetAchieved', function (e) {
	    displayText('펀딩이 종료되었습니다');
	});
	
	//타이머 실행
	timer.start({countdown: true, startValues: {seconds:${difference / 1000}}, target:{days:0, seconds:0}});
	
	var formatTime = convert2text(timer.getTotalTimeValues().seconds);
	
	//momentjs+date-format라이브러리
	function convert2text(seconds){
		var duration = moment.duration(seconds, 'seconds');
		var format = duration.format('d일 h시 m분 s초 남았습니다');
		
		return format;
	}
	
	//글자 출력 함수
	function displayText(text){
		$(".timer").html(text);
	}

});	

</script>

<c:if test="${sessionScope.name != null}">

<script>
	//좋아요 처리
	//[1] 페이지가 로드되면 비동기 통신으로 좋아요 상태를 체크하여 하트 생성
	//[2] 하트에 클릭 이벤트를 설정하여 좋아요 처리가 가능하도록 구현
	$(function(){
		var params = new URLSearchParams(location.search);
		var projectNo = params.get("projectNo");
	
		$.ajax({
			url:"/rest/like/check",
			method:"post",
			data:{projectNo : projectNo},
			success:function(response) {
				//response는 {"check":true, "count":0} 형태의 JSON이다
			
				if(response.check) {
					$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
				}
				else{
					$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
				}
				//전달받은 좋아요 개수를 하트 뒤의 span에 출력
				$(".fa-heart").next("span").text(response.count);
			}
		});
		
		//[2]
		$(".fa-heart").click(function(){
			$.ajax({
				url:"/rest/like/action",
				method:"post",
				data: {projectNo : projectNo},
				success:function(response){
					if(response.check) {
						$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
					}
					else{
						$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
					}
					//전달받은 좋아요 개수를 하트 뒤의 span에 출력
					$(".fa-heart").next("span").text(response.count);
				}
			});
		});
	});
</script>

</c:if>

    <div class="container w-1000">
    	<div class="row">
    		<h5>${majorCategoryDto.majorCategoryType} ${minorCategoryDto.minorCategoryType}</h5>
    	</div>
    	<div class="row">
    		<h1>${projectDto.projectTitle}</h1>
    	</div>
    	<div class="row">
    		<div class="flex-container">
    			<div class="w-100 left">
    				<img src="https://dummyimage.com/600x400/000/fff">
    			</div>
    			<div class="w-100 left">
    				모인금액
    				<fmt:formatNumber value="${projectDto.projectTotalPrice }" pattern="#,###"/>원<br>
    				남은시간
<!--     				<label class="timer"></label> -->
<%--     				${difference / 1000} 초 --%>
    				<label class="timer">0일 0시 0분 0초 남았습니다</label>
    				<br>
    				후원자
    				X명<br>
    				<hr>
    				목표금액
    				<fmt:formatNumber value="${projectDto.projectGoalPrice}" pattern="#,###"/>원<br>
    				펀딩기간
    				${projectDto.projectStartDate} ~ ${projectDto.projectEndDate}<br>
    				
    				목표금액 달성시 ${projectDto.projectEndDate}에 결제 진행
    				<i class="fa-heart fa-regular red"></i> 
					<span>?</span>
    				<button class="btn btn-positive">이 프로젝트 후원하기</button>
    			</div>
    		</div>
    		<div class="row left">
    		<label>프로젝트 계획</label> <label>업데이트</label> <label>커뮤니티</label> <label>추천</label>
    		</div>
    		<div class="flex-container">
    			<div class="w-100 left">
    				${projectDto.projectContent}
    			</div>
    			<div class="w-100">
    				창작자 소개<br>
    				리워드1<br>
    				리워드2<br>
    				조회수 : ${projectDto.projectReadcount}<br>
    			</div>
    		</div>
    	</div>
    </div>


<div class="row">
	<hr>
</div>


<div class="container w-800">

	<div class="row">
		<a class="btn" href="/projectCommunity/noticeList?projectNo=${projectDto.projectNo}">공지사항</a>
		<a class="btn" href="/projectCommunity/qnaList?projectNo=${projectDto.projectNo}">Q & A</a>
		<a class="btn" href="/review/list?projectNo=${projectDto.projectNo}">후기</a>
	</div>
	<%-- 글쓰기는 로그인 상태인 경우에만 출력 --%>
	<c:if test="${sessionScope.name != null && sessionScop.level != '관리자'}">
	<div class="row right">
		<a href="write" class="btn btn-positive">
			<i class="fa-solid fa-pen"></i>
			글쓰기
		</a>
	</div>
	</c:if>
	



	<div class="container w-600">
            <div class="row">
                <hr>
                <h2>서퍼 Q&A</h2>
                <hr>
            </div>
            <div class="flex-container">
                <img src="http://dummyimage.com/40X40/000/fff" width="40" height="40">
                <h3>${projectCommunityDto.getProjectCommunityWriterString()}</h3>
            </div>
            <div>
                ${projectCommunityDto.projectCommunityContent}
            </div>
            <div>
            	${projectCommunityDto.projectCommunityRegDate}
            </div>
            <div class="row">
                <button class="btn" href="detail?projectCommunityNo=${projectCommunityDto.projectCommunityNo}"><i class="fa-solid fa-arrow-down"></i> 더보기</button>
            </div>
        </div>
	
	
	
	
	<c:forEach var="projectCommunityDto" items="${qnaList}">
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
			<c:forEach var="projectCommunityDto" items="${qnaList}">
				<tr>
					<td>${projectCommunityDto.projectCommunityNo}</td>
					<td>${projectCommunityDto.projectCommunityType}</td>
					<td>${projectCommunityDto.getProjectCommunityWriterString()}</td>
					<td align="left">
											<a class="link" href="detail?projectCommunityNo=${projectCommunityDto.projectCommunityNo}">
							${projectCommunityDto.projectCommunityNo}
						</a>

						
					</td>
					<td>${projectCommunityDto.projectCommunityRegDate}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	        </c:forEach>
	
	
	
	
	
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
	
</div>







<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>