<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<!-- Lightpick  CDN -->
<link rel="stylesheet" href="/css/lightpick.css">
<script src="/js/lightpick.js"></script>

<script>
$(function () {
    $('[name=projectContent]').summernote({
      placeholder: '내용을 작성하세요',
      tabsize: 2, //탭을 누르면 이동할 간격
      height: 200, //에디터 높이
      minHeight: 200, //에디터 최소높이
      lineHeight: 20, //기본 줄간격(px)
      toolbar: [
        ['style', ['style']],
        ['font', ['bold', 'italic', 'underline']],
        ['color', ['color']],
        ['para', ['paragraph']],
        ['table', ['table']],
        ['insert', ['link']],
      ],
    });  
    
    //마감일자는 모든 정보를 입력하기 전까지 보여주지 않는다
    $('.end').hide();
    $("[name=projectStartDate], [name=projectDuration]").on("input", function(){
    	var startDate = $("[name=projectStartDate]").val();
    	var duration = $("[name=projectDuration]").val(); //문자열로 값을 얻어온다
    	
    	if(startDate.length == 0 || duration.length == 0) {
    		$('.end').hide();
    		return;
    	}
    	
    	$('.end').show();
    	var future = moment(startDate, 'YYYY-MM-DD').add(parseInt(duration) - 1, 'days'); //따라서 숫자로 바꿔줘야 한다
    	$(".future").text(future.format('YYYY-MM-DD'));
    });
    

	var picker = new Lightpick({
		field: document.querySelector("[name=projectStartDate]"), //타겟찾아서
		singleDate: true, //단일 날짜를 선택(true)
		format: 'YYYY-MM-DD', //날짜형식 설정
		minDate: new Date(), //오늘 이전의 날짜를 선택하지 못하게 설정	
	});

    
  });
</script>

<form action="write" method="post">

      <input type="hidden" name="projectOwner" value="${sessionScope.name}">
   <div class="container w-600">
      <div class="row">
         <h1>fado 프로젝트 등록하기</h1>            
      </div>
      <div class="row left">
         제목
         <input type="text" name="projectTitle" class="form-input w-100" placeholder="제목을 입력하세요">
      </div>
      <div class="row left">
         목표 금액
         <input type="number" name="projectGoalPrice" class="form-input w-100" placeholder="목표로 하는 금액을 입력하세요">
      </div>
      <div class="row left">
            시작날짜 선택
            <input type="text" name="projectStartDate"  class="form-input w-100" placeholder="프로젝트 시작날짜를 선택하세요">
        </div>
        <div class="row left">
            프로젝트 마감날짜 선택
            <select name="projectDuration"  class="form-input w-100">
                <option value="">프로젝트 마감 날짜를 고르세요</option>
                <option value="15">15일</option>
                <option value="30">30일</option>
            </select>
            <div class="end">
            	예상 마감 일자는 <span class="future">YYYY-MM-DD</span>입니다
            </div>
      </div>
      <div class="row left">
         카테고리 선택
         <select name="projectCategory" class="form-input w-100">
            <option value="project_category">의류(추가해야함)</option>
            <option value="project_category">게임</option>
         </select>
      </div>
      <div class="row">
         <textarea name="projectContent" placeholder="내용을 작성하세요"></textarea>
      </div>
      <div class="row">
         <button type="submit" class="btn btn-positive w-100">작성하기</button>
      </div>
         
   </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>      