<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- moment.js -->
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
<!-- Lightpick  CDN -->
<link rel="stylesheet" href="/css/lightpick.css">
<script src="/js/lightpick.js"></script>

<script>
$(function () {
    
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
    //목표 : 
    $(".btn-save").click(function(){
	    //파일 선택창을 Javascript로 불러와야함
	    var input = $(".file-chooser")[0];
	    
	    //input이 file이라면 files 라는 항목이 존재
// 	    console.log(input.files);
	    if(input.files.length == 0) return;
	    
	    //비동기 통신
	    //- form으로 파일 전송 시에 multipart/form-data 설정을 해야함
	    //- 비동기 통신일 때는 
	    //- processData : false로 설정
	    //- contentType: false로 설정
	    //- FormData 객체를 만들어 파일을 추가한 뒤에 전송
	    var form = new FormData();
	    //form.append("이름", 데이터);
	    form.append("attach", input.files[0]); //우측에는 선택한 파일이 하나이므로 
	    
	    $.ajax({
	    	url:"/rest/project/upload",
	    	method:"post", //get방식은 파일전송이 안된다
	    	processData:false,
	    	contentType:false,
	    	data:form, //form으로 전송되는 것 처럼 날아감
	    	success:function(response){
// 	    		console.log(response);
	    		//이미지의 src를 바꾸는 코드
	    		$(".img").attr("src", "/rest/project/download?attachNo="+response.attachNo);
	    	},
	    	error:function(){
	    		window.alert("통신 오류 발생 \n 잠시 후 다시 시도해 주세요");
	    	},
	    });
    });
    
    	
    
  });
</script>

<form action="write" method="post">

      <input type="hidden" name="projectOwner" value="${sessionScope.name}">
   <div class="container w-600">
      <div class="row">
         <h1>fado 프로젝트 등록하기</h1>            
      </div>
      <div class="row">
      	<input type="file" class="file-chooser" accept="image/*">
      	<button class="btn-save" type="button">설정하기</button>
      </div>
      <div class="row">
      	<img src="https://dummyimage.com/200x200/000/fff" class="img">
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
           <select name="projectPeriod" class="form-input w-100">
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
<!-- 					<option value="">분류를 고르세요</option> -->
				<c:forEach var="minorCategoryDto" items="${minorList}">
			     	<option value="${minorCategoryDto.minorCategoryNo}">${minorCategoryDto.minorCategoryType}</option>
				</c:forEach>
				</select>
			</div>
         </div>
      <div class="row">
         <textarea name="projectContent" placeholder="내용을 작성하세요"></textarea>
      </div>
      <div class="row">
         <button type="submit" class="btn btn-positive w-100">작성하기</button>
      </div>
      </div>
   </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>      