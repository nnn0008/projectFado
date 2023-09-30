<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- Lightpick  CDN -->
<link rel="stylesheet" href="/css/lightpick.css">
<script src="/js/lightpick.js"></script>
<script src="/js/multipage.js"></script>

<script>
$(function () {
	
	$(function(){
        //최초 게이지 계산
        refreshProgressbar();

        //이전이나 다음버튼을 누르면 진행상황을 파악하여 게이지 계산
        $(".btn-prev, .btn-next").click(function(){
            refreshProgressbar();
        });

        function refreshProgressbar() {
            //page중에 보여지는 태그를 찾아서 계산
            //- 전체 페이지 수 + 보여지는 페이지 번호

            var count = 0;
            var index = 0;
            $(".page").each(function(idx, el){
                //if(현재 태그가 표시중이라면) {
                if($(this).is(":visible")) {
                    index = idx+1;
                }
                count++;
            });

            var percent = index * 100 / count;
            $(".progressbar > .guage").css("width", percent+"%");
        }
    });
    
    //마감일자는 모든 정보를 입력하기 전까지 보여주지 않는다
    $('.end').hide();
    $("[name=projectStartDate], [name=projectPeriod]").on("input", function(){
    	var startDate = $("[name=projectStartDate]").val();
    	var period = $("[name=projectPeriod]").val(); //문자열로 값을 얻어온다
    	
    	if(startDate.length == 0 || period.length == 0) {
    		$('.end').hide();
    		return;
    	}
    	
    	$('.end').show();
    	var future = moment(startDate, 'YYYY-MM-DD').add(parseInt(period) - 1, 'days'); //따라서 숫자로 바꿔줘야 한다
    	$(".future").text(future.format('YYYY-MM-DD'));
    });
    

	var picker = new Lightpick({
		field: document.querySelector("[name=projectStartDate]"), //타겟찾아서
		singleDate: true, //단일 날짜를 선택(true)
		numberOfColumns: 2,
		numberOfMonths:2, //두 달이 보이게 설정
		format: 'YYYY-MM-DD', //날짜형식 설정
		minDate : moment().startOf(new Date()).add(14, 'day'),
// 		minDate: new Date(), //오늘 이전의 날짜를 선택하지 못하게 설정	
	});

    $(".minor").hide();
    $("[name=majorCategoryNo]").change(function(){
    	if($("[name=majorCategoryNo]").val() == ""){
    		$(".minor").hide();		
    	}
    	else{
	    	$(".minor").show();	
	    	
	    	var majorNo = $(this).val();
	    	
	    	$.ajax({
	    		url:"/rest/project/classifyCheck",
	    		method:"post",
	    		data:{
	    			majorCategoryNo : majorNo
	    		},
	    		success:function(response){
	    			$("[name=minorCategoryNo]").empty();
	    			$.each(response, function(minorCategoryNo, minorCategoryType){
		    			$("[name=minorCategoryNo]").append($('<option>',{
		    				value: minorCategoryNo,
		    				text: minorCategoryType
		    			}));
	    			});
	    		},
	    	});
    	} 	
    });
    
//     $("[name=projectGoalPrice]").on("input", function(){
//     	if($(this).val < 0){
    		
//     	}
//     	else{
    		
//     	}
//     });
    
    
    
  });
</script>

<form action="write" method="post">
      <input type="hidden" name="projectOwner" value="${sessionScope.name}">
      
   <div class="container w-600">
     <div class="row">
        <h1>fado 프로젝트 등록하기</h1>            
     </div>
     <div class="row">
        <div class="progressbar">
            <div class="guage"></div>
        </div>
	</div>
	
	<div class="row page">
      <div class="row left">
         제목
         <input type="text" name="projectTitle" class="form-input w-100" placeholder="제목을 입력하세요">
      </div>
      카테고리 선택
         <div class="flex-container">
         	<div class="w-50">
	         	대분류
	         <select name="majorCategoryNo" class="form-input w-100">
					<option value="">분류를 고르세요</option>
				<c:forEach var="majorCategoryDto" items="${majorList}">
			     	<option value="${majorCategoryDto.majorCategoryNo}">${majorCategoryDto.majorCategoryType}</option>
				</c:forEach>
	         </select>
			</div>
			<div class="w-50 minor">
				소분류
				<select name="minorCategoryNo" class="form-input w-100">
				<c:forEach var="minorCategoryDto" items="${minorList}">
			     	<option value="${minorCategoryDto.minorCategoryNo}">${minorCategoryDto.minorCategoryType}</option>
				</c:forEach>
				</select>
			</div>
	      <div class="row">
	         <textarea name="projectContent" placeholder="내용을 작성하세요"></textarea>
	      </div>
	      
	      <div class="row right">
            <button type="button" class="btn btn-prev">
                <i class="fa-solid fa-arrow-left"></i>
            </button>
            <button type="button" class="btn btn-next">
                <i class="fa-solid fa-arrow-right"></i>
            </button>
        </div>
      </div>
      <div class="row page">
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
	           <select name="projectPeriod" class="form-input w-100">
	               <option value="">프로젝트 마감 날짜를 고르세요</option>
	               <option value="15">15일</option>
	               <option value="30">30일</option>
	           </select>
	           <div class="end">
	           		예상 마감 일자는 <span class="future">YYYY-MM-DD</span>입니다
	           </div>
	      </div>
	      
	      <div class="row right">
            <button type="button" class="btn btn-prev">
                <i class="fa-solid fa-arrow-left"></i>
            </button>
            <button type="button" class="btn btn-next">
                <i class="fa-solid fa-arrow-right"></i>
            </button>
        </div>
      </div>
      
      <div class="row page">
      	
      	<div class="container flex-container w-800">
      		<div class="row">
      			<div class="row">
      				<h1>내가 만든 리워드</h1>
      			</div>
      			<div class="row reward-list"></div>
      		</div>
      		<div class="row">
      			<form class="reward-insert-form">
      				<div class="row">
						<h1>리워드 등록</h1>
					</div>
					<div class="row">
						<input type="text" name="rewardType" class="form-input w-100"
						placeholder="리워드 구성">
					</div>
					<div class="row">
						<input type="number" name="rewardPrice" class="form-input w-100"
						placeholder="리워드 가격">
					</div>
					<div class="row me-10">
						<button type="submit" class="btn btn-positive w-100 btn-adds">
							<i class="fa-solid fa-plus"></i>
								추가
						</button>
					</div>
      			</form>
      		</div>
      	</div>
      
      	<div class="row right">
            <button type="button" class="btn btn-prev">
                <i class="fa-solid fa-arrow-left"></i>
            </button>
            <button type="button" class="btn btn-next">
                <i class="fa-solid fa-arrow-right"></i>
            </button>
            <button type="submit" class="btn btn-positive w-100">작성하기</button>
        </div>
        
      </div>
      
      </div>
   </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>      