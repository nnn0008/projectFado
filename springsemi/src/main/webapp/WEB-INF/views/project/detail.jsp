<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
/* 수평선 스타일 */
.hr {
            border: none; 
            height: 2px; /* 수평선의 높이(굵기) 설정 */
            background-color: #2c8de0;
            opacity: 0.2; 
            margin: 1.5em 0px;
        }
        
      	.notice-box {
        box-shadow: 0px 0px 1px 0px #2c8de0;
          color: #202020;
          padding: 20px;
          border-radius: 10px;
          padding-bottom: 20%;
          box-shadow: 0 2px 5px rgba(0, 0, 0, 0.4); /* 그림자 효과 */
      }
      .qna-box {
        box-shadow: 0px 0px 2px 0px #2c8de0;
          color: #202020;
          padding: 20px;
          border-radius: 10px;
      }
</style>
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
		var format = duration.format('d일 h시 m분 s초 남았습니다.');
		
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

</c:if>

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
//Q&A랑 후기 버튼으로 넘기기
    $(function(){
        $(".page").hide().first().show(); 
        $(".btn-prev").first().remove();
        $(".btn-next").last().remove();

        $(".btn-next").click(function(){
            $(this).parent(".page").hide().next(".page").show(); 
        });

        $(".btn-prev").click(function(){
            $(this).parent(".page").hide().prev(".page").show();
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
    			<div class="w-50 left pt-50">
    				<div class="mb-20">
    					<span>모인금액</span>
    					<span class="bold text-shadow" style="margin-left: 3px;">
    						<fmt:formatNumber value="${projectDto.projectTotalPrice}" pattern="#,###"/>
    					</span>
    					<span style="font-size:12px; margin-left: 2px;">원</span>
    				</div>
    				<div class="mb-20">
    					남은시간
<!--     				<label class="timer"></label> -->
<%--     				${difference / 1000} 초 --%>
						<label class="timer" style="margin-left: 3px;">0일 0시 0분 0초 남았습니다.</label>
    				</div>
    				
    				<div>
    					<span>후원자</span>
    					<span style="margin-left: 3px;">n</span>
    					<span>명</span>
    				</div>
    				
    				<hr class="hr">
    				
    				<div class="mb-20">
    					<span class="bold">목표금액</span>
    					<span class="bold text-shadow" style="margin-left: 3px;">
    						<fmt:formatNumber value="${projectDto.projectGoalPrice}" pattern="#,###"/>
    					</span>
    					<span style="font-size:12px; margin-left: 2px;">원</span>
    				</div>
    				
    				<div class="mb-20">
    					<span class="bold">펀딩기간</span>
    					<span style="margin-left: 3px;">${projectDto.projectStartDate} ~ ${projectDto.projectEndDate}</span>
    				</div>
    				
    				<div class="mb-20">
    					<span class="bold">결제진행</span>
    					<span style="margin-left: 3px;">목표 높이 달성 시 ${projectDto.projectEndDate}</span>
    				</div>
    				
					<div>
						<i class="fa-heart fa-regular red"></i> 
						<span>?</span>
						<button class="btn btn-positive w-70">이 프로젝트 후원하기</button>
					</div>
    				
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
    		<button class="btn btn-positive">
    			<a class="link" href="/orders/write?projectNo=${projectDto.projectNo}"></a>
    			주문하기
    		</button>
    	</div>
    	</div> 
    </div>
    
    
    
    
    
    
    
    <div class="left">
	<div class="left" id="notice; qna; review">
		<hr>
	</div>
	
	
	
<div class="container">
    <!-- 
    !!!공지사항!!! 
    --> 
    <div class="container w-800 noticePage">
		<c:if test="${sessionScope.name != null && sessionScope.level == '판매자'}">
		    <div class="row right">
		        <a href="/projectCommunity/write?projectNo=${projectDto.projectNo}" class="btn btn-positive">
		            <i class="fa-solid fa-pen"></i>
		            글쓰기
		        </a>
		    </div>
		</c:if>
	
	    <div class="row">
	        <hr class="hr">
	        <h3 class="fado">서퍼 공지 업데이트</h3>
	        <hr class="hr">
	    </div>
	    
       <div class="mt-30" >
           <c:forEach var="projectCommunityDto" items="${noticeList}">
           <div class="notice-box">
               <a class="link" href="/projectCommunity/detail?projectCommunityNo=${projectCommunityDto.projectCommunityNo}"
                  style="font-weight:bold; font-size:16px;">
                        ${projectCommunityDto.projectCommunityContent}</a>
           </div>
           <div class="flex-container mt-10">
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
	
	


        <div class="row page-wrapper">
            <div class="page">
                <button class ="btn btn-prev">Q&A</button>
                <button class ="btn btn-next">후기</button>
    
			                <!-- 
			           !!!Q&A!!! 
			           --> 
			           <div class="container w-800 qnaPage">
			            <c:if test="${sessionScope.name != null && sessionScop.level != '관리자'}">
			             <div class="row right">
			                 <a href="/projectCommunity/write?projectNo=${projectDto.projectNo}" class="btn btn-positive">
			                     <i class="fa-solid fa-pen"></i>
			                     글쓰기
			                 </a>
			             </div>
			         </c:if>
			    
			       
			         <div class="row">
			                 <hr class="hr">
			                     <h3 class="fado">서퍼 Q&A</h3>
			                 <hr class="hr">
			         </div>
			            <div class="mt-30">
			            <c:forEach var="projectCommunityDto" items="${qnaList}">
			            <div class="qna-box left">
			                <a class="link" href="/projectCommunity/detail?projectCommunityNo=${projectCommunityDto.projectCommunityNo}"
			                   style="font-weight:bold; font-size:16px;">
			                         ${projectCommunityDto.projectCommunityContent}</a>
			            </div>
			            <div class="flex-container mt-10">
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
			    
			            </div>
			            <div class="page">
			                <button class ="btn btn-prev">Q&A</button>
			                <button class ="btn btn-next">후기</button>
			    
			                <!-- 
			           !!!후기!!! 
			           --> 
			           <div class="container w-800 reviewPage">
			            <c:if test="${sessionScope.name != null && sessionScope.level == '구매자'}">
			          <div class="row right">
			              <a href="/review/write?projectNo=${projectDto.projectNo}" class="btn btn-positive">
			                  <i class="fa-solid fa-pen"></i>
			                  글쓰기
			              </a>
			          </div>
			    </c:if>
			      <div class="row">
			          <hr class="hr">
			          <h3 class="fado">서핑 후기</h3>
			          <hr class="hr">
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
    
    
            </div>
        </div>
    </div>

</div>

    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   