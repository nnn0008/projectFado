<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    <div class="container w-900">
    	<div class="row">
    		<h5>${projectDto.projectCategory}</h5>
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
    				모인금액<br>
    				<fmt:formatNumber value="${projectDto.projectTotalPrice }" pattern="#,###"/>원<br>
    				남은시간
    				<label class="timer"></label>
    				${difference / 1000} 초
    				<br>
    				후원자
    				X명<br>
    				<hr>
    				목표금액
    				<fmt:formatNumber value="${projectDto.projectGoalPrice }" pattern="#,###"/>원<br>
    				펀딩기간
    				${projectDto.projectStartDate} ~ ${projectDto.projectEndDate}<br>
    				결제
    				목표금액 달성시 ${projectDto.projectEndDate}에 결제 진행
    				<i class="fa-solid fa-heart"></i><br>
    				<button class="btn btn-positive">이 프로젝트 후원하기</button>
    			</div>
    		</div>
    		<div class="row left">
    		<label>프로젝트 계획</label> <label>업데이트</label> <label>커뮤니티</label> <label>추천</label>
    		</div>
    		<div class="flex-container">
    			<div class="w-100 left">
    				${projectDto.projectContent }
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
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   