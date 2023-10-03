<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!--  프로젝트 디테일 스크립트 -->
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
	    displayText('0초');
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

<script>
	$(function(){
		var params = new URLSearchParams(location.search);
		var projectNo = params.get("projectNo");
	
		$.ajax({
			url:"/rest/like/check",
			method:"post",
			data:{projectNo : projectNo},
			success:function(response) {
			
				if(response.check) {
					$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
				}
				else{
					$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
				}
				$(".fa-heart").next("span").text(response.count);
			}
		});
		
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
					$(".fa-heart").next("span").text(response.count);
				}
			});
		});
	});
</script>

<script>
	$(function(){
		var followButton = $(this);
		var btn = followButton.closest("button");
		var followeeId = btn.data("followee");
		var params = new URLSearchParams(location.search);
		var projectNo = params.get("projectNo");
	
		$.ajax({
			url:"/rest/follow/check",
			method:"post",
			data:{
				followeeId : followeeId,
				projectNo : projectNo
			},
			success:function(response) {
				if(response.check) {
					$(".ic").removeClass("fa-check fa-plus").addClass("fa-check");
				}
				else{
					$(".ic").removeClass("fa-check fa-plus").addClass("fa-plus");
				}
			}
		});
		
		$(".follow-button").click(function(){
			$.ajax({
				url:"/rest/follow/action",
				method:"post",
				data:{
					followeeId : followeeId,
					projectNo : projectNo
				},
				success:function(response){
					if(response.check) {
						$(".ic").removeClass("fa-check fa-plus").addClass("fa-check");
					}
					else{
						$(".ic").removeClass("fa-check fa-plus").addClass("fa-plus");
					}
				}
			});
		});
	});
</script>

<script>
$(document).ready(function() {
    var selectedReward = null; // 선택한 리워드 정보를 저장할 변수

    // 리워드 버튼 클릭 시
    $(".reward-btn").click(function() {
        // 선택한 리워드 정보 가져오기
        var price = $(this).find(".row:first-child").text().trim();
        var type = $(this).find(".row:last-child").text().trim();

        // 선택한 리워드 정보 저장
        selectedReward = {
            price: price,
            type: type
        };

        // 리워드 버튼에 선택 표시 추가 (선택한 리워드에 따라 스타일링할 수 있음)
        $(".reward-btn").removeClass("selected"); // 모든 리워드 버튼에서 선택 표시 제거
        $(this).addClass("selected"); // 클릭한 리워드 버튼에 선택 표시 추가
    });

    // 주문하기 버튼 클릭 시
    $(".order-btn").click(function() {
        if (selectedReward) {
            // 선택한 리워드 정보를 주문 페이지로 전달
            var orderPageUrl = "/orders/insert?projectNo=" + projectDto.projectNo + "&price=" + selectedReward.price + "&type=" + selectedReward.type;
            window.location.href = orderPageUrl;
        } else {
            alert("리워드를 선택하세요."); // 리워드를 선택하지 않았을 때 경고 메시지 표시
        }
    });
});
</script>

    <div class="container w-800">
    	<div class="row">
    		<h5>${majorCategoryDto.majorCategoryType} > ${minorCategoryDto.minorCategoryType}</h5>
    	</div>
    	<div class="row">
    		<h1>${projectDto.projectTitle}</h1>
    	</div>
    	<div class="row">
    		<div class="flex-container">
    			<div class="w-75 left">
    				<img src="/rest/project/download?attachNo=${mainAttachDto.attachNo}"  width="400px" height="400px">
    			</div>
    			<div class="w-50 left">
    				모인금액
    				<fmt:formatNumber value="${projectDto.projectTotalPrice}" pattern="#,###"/>원<br>
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
    				<img src="/rest/project/download?attachNo=${subAttachDto.attachNo}">
    			</div>
    				창작자 소개<br>
    				${projectDto.projectOwner}<br>
    			<div class="w-100">
    				<c:if test="${sessionScope.name != projectDto.projectOwner}">
    				<c:choose>
                        <c:when test="${isFollowing == 'true'}">
                        <button class="btn follow-button" data-followee="${memberFollowDto.followeeId}">
                                <i class="fa-solid fa-check ic"></i> 팔로잉
                           </button>
                        </c:when>
                        <c:otherwise>
                         <button class="btn follow-button"  data-followee="${memberFollowDto.followeeId}">
                                <i class="fa-solid fa-plus ic"></i> 팔로우
                            </button>
                        </c:otherwise>
                    </c:choose>
                    </c:if>
    				<br>
    				리워드1<br>
    				리워드2<br>
    				조회수 : ${projectDto.projectReadcount}<br>
    			</div>
    		</div>
    	</div>
    </div>
        
    <!--  커뮤니티 리스트 스크립트 -->
    <script>

    </script>
    
    <div class="container w-1000 flex-container">
    
    	<div class="row" style="flex-grow: 3.5;">
    		<img src="https://picsum.photos/id/2/100/100">
    	</div>
    	
    	<div class="row w-200" style="background-color: #E0F2F7; flex-frow:1.5; border: 1px solid #E0F2F7; border-radius: 10px;">
    	<div class="row">
    		리워드 선택
    	</div>
    	<c:forEach var="rewardDto" items="${rewardList}">
    		<button class="btn reward-btn" style="display: block">
	    	<div class="container w-100 mt-10" >
	    		<div class="row" style="display: block">
	    			${rewardDto.rewardPrice}원
	    		</div>
	    		<div class="row" style="display: block">
	    			${rewardDto.rewardType}
	    		</div>
	    	</div>
	    	</button>
    	</c:forEach>
    	<div class="row">
    		<button class="btn btn-positive order-btn">
    			<a class="link" href="/orders/write?projectNo=${projectDto.projectNo}"></a>
    			주문하기
    		</button>
    	</div>
    	</div> 
    </div>
    
    
    
    
    
    
    
    <div class="row">
	<div class="row" id="notice; qna; review">
		<hr>
	</div>
	
	<div class="container w-800">
		<div class="row">
			<a class="btn btn-notice" href="#notice">공지사항</a>
			<a class="btn btn-qna" href="#qna">Q & A</a>
			<a class="btn btn-review" href="review">후기</a>
		</div>
	</div>    
    
    
    
    
    <!-- 
    !!!공지사항!!! 
    --> 
    <div class="container w-600 noticePage">
		<c:if test="${sessionScope.name != null && sessionScope.level == '판매자'}">
		    <div class="row right">
		        <a href="/projectCommunity/write?projectNo=${projectDto.projectNo}" class="btn btn-positive">
		            <i class="fa-solid fa-pen"></i>
		            글쓰기
		        </a>
		    </div>
		</c:if>
	
	    <div class="row">
	        <hr>
	        <h2>서퍼 공지 업데이트</h2>
	        <hr>
	    </div>
	    
       <div class="mt-30">
           <c:forEach var="projectCommunityDto" items="${noticeList}">
           <div class="">
               <a class="link" href="/projectCommunity/detail?projectCommunityNo=${projectCommunityDto.projectCommunityNo}"
                  style="font-weight:bold; font-size:18px;">
                        ${projectCommunityDto.projectCommunityContent}</a>
           </div>
           <div class="flex-container">
              <div>
               ${projectCommunityDto.getProjectCommunityWriterString()}
              </div>
              <div class="ms-20 me-10">
                 <i class="fa-regular fa-window-minimize fa-rotate-90"></i>
              </div>
              <div>
               ${projectCommunityDto.projectCommunityRegDate}
              </div>
           </div>
           <div class="mt-20 mb-20">
               <hr>
           </div>
           </c:forEach>
       	</div>
	    </div>
	
	



	
	
	
   	<!-- 
   	!!!Q&A!!! 
   	--> 
   	<div class="container w-600 qnaPage">
   	    <c:if test="${sessionScope.name != null && sessionScop.level != '관리자'}">
			<div class="row right">
				<a href="/projectCommunity/write?projectNo=${projectDto.projectNo}" class="btn btn-positive">
					<i class="fa-solid fa-pen"></i>
					글쓰기
				</a>
			</div>
		</c:if>

      
        <div class="row">
	            <hr>
	            	<h2>서퍼 Q&A</h2>
	            <hr>
	    </div>
       	<div class="mt-30">
           <c:forEach var="projectCommunityDto" items="${qnaList}">
           <div class="">
               <a class="link" href="/projectCommunity/detail?projectCommunityNo=${projectCommunityDto.projectCommunityNo}"
                  style="font-weight:bold; font-size:18px;">
                        ${projectCommunityDto.projectCommunityContent}</a>
           </div>
           <div class="flex-container">
              <div>
               ${projectCommunityDto.getProjectCommunityWriterString()}
              </div>
              <div class="ms-20 me-10">
                 <i class="fa-regular fa-window-minimize fa-rotate-90"></i>
              </div>
              <div>
               ${projectCommunityDto.projectCommunityRegDate}
              </div>
           </div>
           <div class="mt-20 mb-20">
               <hr>
           </div>
           </c:forEach>
       	</div>
	    </div>
	
	
      
      
      
      
      
      
   	<!-- 
   	!!!후기!!! 
   	--> 
   	<div class="container w-600 reviewPage">
   	   	<c:if test="${sessionScope.name != null && sessionScope.level == '구매자'}">
		    <div class="row right">
		        <a href="/review/write?projectNo=${projectDto.projectNo}" class="btn btn-positive">
		            <i class="fa-solid fa-pen"></i>
		            글쓰기
		        </a>
		    </div>
	</c:if>
        <div class="row">
            <hr>
            <h2>서핑 후기</h2>
            <hr>
        </div>
		<c:forEach var="reviewDto" items="${reviewList}">
        	<div class="flex-container">
	             <img src="http://dummyimage.com/40X40/000/fff" width="40" height="40">
	             <h3>${reviewDto.getReviewWriterString()}</h3>
         	</div>
         <div>
             ${reviewDto.reviewContent}
         </div>
         <div>
         	${reviewDto.reviewRegDate}
         </div>

       </c:forEach>
      </div>
      
      
    </div> 
    

    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   