<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

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
      disableHtml: true // HTML 태그 비활성화
    });
//  // projectStartDate 입력란의 변경 이벤트를 감지하여 projectEndDate 업데이트
//     $("[name=projectStartDate]").change(function () {
//         var startDate = new Date($(this).val()); // 선택된 시작 날짜
//         var endDateSelect = $("[name=projectEndDate]"); // 프로젝트 종료일 선택 요소

//         if (!isNaN(startDate.getTime())) {
//             // 시작 날짜가 유효한 경우
//             // 15일 후 날짜 계산
//             var endDate15Days = new Date(startDate);
//             endDate15Days.setDate(startDate.getDate() + 15);

//             // 30일 후 날짜 계산
//             var endDate30Days = new Date(startDate);
//             endDate30Days.setDate(startDate.getDate() + 30);

//             // projectEndDate 선택 요소 업데이트
//             endDateSelect.empty(); // 기존 옵션 삭제
//             endDateSelect.append(new Option(endDate15Days.toISOString().split('T')[0], endDate15Days.toISOString().split('T')[0]));
//             endDateSelect.append(new Option(endDate30Days.toISOString().split('T')[0], endDate30Days.toISOString().split('T')[0]));
//         }
//     });
    
    
  });

window.addEventListener("load", function(){
   // projectStartDate 입력란의 변경 이벤트를 감지하여 projectEndDate 업데이트
   document.getElementById("projectStartDate").addEventListener("change", function () {
            var startDate = new Date(this.value); // 선택된 시작 날짜
            var endDateSelect = document.getElementById("projectEndDate"); // 프로젝트 종료일 선택 요소
    
            if (!isNaN(startDate.getTime())) {
                // 시작 날짜가 유효한 경우
                // 15일 후 날짜 계산
                var endDate15Days = new Date(startDate);
                endDate15Days.setDate(startDate.getDate() + 15);
    
                // 30일 후 날짜 계산
                var endDate30Days = new Date(startDate);
                endDate30Days.setDate(startDate.getDate() + 30);
    
                // projectEndDate 선택 요소 업데이트
                endDateSelect.innerHTML = ""; // 기존 옵션 삭제
                endDateSelect.options[endDateSelect.options.length] = new Option(endDate15Days.toISOString().split('T')[0], endDate15Days.toISOString().split('T')[0]);
                endDateSelect.options[endDateSelect.options.length] = new Option(endDate30Days.toISOString().split('T')[0], endDate30Days.toISOString().split('T')[0]);
            }
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
         제목
         <input type="text" name="projectTitle" class="form-input w-100" placeholder="제목을 입력하세요">
      </div>
      <div class="row">
         목표 금액
         <input type="number" name="projectGoalPrice" class="form-input w-100" placeholder="목표로 하는 금액을 입력하세요">
      </div>
      <div class="row left">
            희망날짜 선택(심사에는 평균적으로 5영업일이 소모됩니다)
            <input type="date" name="projectStartDate" id="projectStartDate" class="form-input w-100">
        </div>
        <div class="row left">
            프로젝트 기간(15일 후 또는 30일 후로 선택이 가능합니다)
            <select name="projectEndDate" id="projectEndDate" class="form-input w-100">
                <option value="">선택하세요</option>
                <option value="15">15일</option>
                <option value="30">30일</option>
            </select>
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