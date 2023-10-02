<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">


<style>
   .note-viewer{
      line-height: 2em !important;
   }
   
    .box {
          box-shadow: 0px 0px 1px 0px #2c8de0;
            color: #202020;
            padding: 20px;
            border-radius: 10px;
            padding-bottom: 20%;
        }
        
        /* 수평선 스타일 */
      .hr-style {
            border: none; 
            height: 2px; /* 수평선의 높이(굵기) 설정 */
            background-color: #2c8de0;
            opacity: 0.2; 
            margin: 1em 0px;
        }
</style>

<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script>
$(function(){
   
   $(".mainReply-insert-form").submit(function(e){
      e.preventDefault();
      
      $.ajax({
         url:"/rest/mainReply/insert",
         method:"post",
         data : $(e.target).serialize(),
         success:function(response){
            $("[name=mainReplyContent]").val("");//입력창 초기화
            loadList();//목록 갱신
         }
      });
   });
   
   loadList();
   
   
   function loadList() {
      var params = new URLSearchParams(location.search);
      var no = params.get("mainCommunityNo");
      var memberId = "${sessionScope.name}";
      
      //비동기 통신으로 화면 갱신
      $.ajax({
         url:"/rest/mainReply/list",
         method:"post",
         data:{ mainReplyOrigin : no },
         success:function(response){
            //화면 청소
            $(".mainReply-list").empty();//자기 자신을 제외한 내부 코드 삭제
            
            for(var i=0; i < response.length; i++) {
               var mainReply = response[i];
               
               var template = $("#mainReply-template").html();
               var htmlTemplate = $.parseHTML(template);
               
               $(htmlTemplate).find(".mainReplyWriter").text(mainReply.mainReplyWriter || "탈퇴한 사용자");
               $(htmlTemplate).find(".mainReplyContent").text(mainReply.mainReplyContent);
               $(htmlTemplate).find(".mainReplyTime").text(mainReply.mainReplyTime);
               
               //내가 작성한 댓글이 아니라면
               if(memberId.length == 0 || memberId != mainReply.mainReplyWriter) {
                  //버튼 삭제
                  $(htmlTemplate).find(".w-25").empty();
               }
               
               $(htmlTemplate).find(".btn-delete")
                              .attr("data-mainReply-no", mainReply.mainReplyNo)
                              .click(function(e){
                  var mainReplyNo = $(this).attr("data-mainReply-no");
                  $.ajax({
                     url:"/rest/mainReply/delete",
                     method:"post",
                     data:{mainReplyNo : mainReplyNo},
                     success:function(response){
                        loadList();
                     },
                  });
               });
               
               $(htmlTemplate).find(".btn-edit")
                                 .attr("data-mainReply-no", mainReply.mainReplyNo)
                                 .click(function(){
                  //this == 수정버튼
                  var editTemplate = $("#mainReply-edit-template").html();
                  var editHtmlTemplate = $.parseHTML(editTemplate);
                  
                  //value 설정
                  var mainReplyNo = $(this).attr("data-mainReply-no");
                  var mainReplyContent = $(this).parents(".view-container")
                                                .find(".mainReplyContent").text();
                  $(editHtmlTemplate).find("[name=mainReplyNo]").val(mainReplyNo);
                  $(editHtmlTemplate).find("[name=mainReplyContent]").val(mainReplyContent);
                  
                  //취소 버튼에 대한 처리 구현
                  $(editHtmlTemplate).find(".btn-cancel")
                                       .click(function(){
                     //this == 취소버튼
                     $(this).parents(".edit-container")
                              .prev(".view-container").show();
                     $(this).parents(".edit-container").remove();
                  });
                  
                  $(editHtmlTemplate).submit(function(e){
                     
                     e.preventDefault();
                     
                     $.ajax({
                        url:"/rest/mainReply/edit",
                        method:"post",
                        data : $(e.target).serialize(),
                        success:function(response){
                           loadList();
                        }
                     });
                  });
                  
                  //화면 배치
                  $(this).parents(".view-container")
                           .hide()
                           .after(editHtmlTemplate);
               });
               
               $(".mainReply-list").append(htmlTemplate);
            }
         },
      });
   }
});
</script>
<script id="mainReply-template" type="text/template">
      <div class="row flex-container view-container ms-50">
         <div class="w-75">
            <div class="row left">
               <h3 class="mainReplyWriter">작성자</h3>
            </div>
            <div class="row left">
               <pre class="mainReplyContent">내용</pre>
            </div>
            <div class="row left">
               <span class="mainReplyTime">yyyy-MM-dd HH:mm:ss</span>
               <hr>
            </div>
         </div>
         <div class="w-25 me-50">
            <div class="row right">
               <button class="btn btn-edit">
                  <i class="fa-solid fa-edit"></i>
                  수정
               </button>
            </div>
            <div class="row right">
               <button class="btn btn-negative btn-delete">
                  <i class="fa-solid fa-trash"></i>
                  삭제
               </button>
            </div>
         </div>
      </div>

</script>
<script id="mainReply-edit-template" type="text/template">
      <form class="mainReply-edit-form edit-container">
      <input type="hidden" name="mainReplyNo" value="?">
      <div class="row flex-container">
         <div class="w-75">
            <textarea name="mainReplyContent" class="form-input w-100" rows="4">어쩌구저쩌구</textarea>
         </div>
         <div class="w-25">
            <div class="row right">
               <button type="submit" class="btn btn-positive">
                  <i class="fa-solid fa-check"></i>
                  수정
               </button>
            </div>
            <div class="row right">
               <button type="button" class="btn btn-negative btn-cancel">
                  <i class="fa-solid fa-xmark"></i>
                  취소
               </button>
            </div>
         </div>
      </div>
      </form>
</script>






<div class="container w-800">
   <div class="row">
      <h3 style="color:#2c8de0;">${mainCommunityDto.mainCommunityNo}번 게시글</h3>
   </div>
   
   <div class="left box">
   
      <div class="right">
         <span>작성자 : ${mainCommunityDto.getMainCommunityWriterString()}</span>
      </div>
      
      
      <div>
      <h4>${mainCommunityDto.mainCommunityTitle}</h4>
      <hr class="w-100 hr-style">
      </div>
      
      <div>
         <span>${mainCommunityDto.mainCommunityContent}</span>
      </div>
      
   </div>
   
</div>




   <%-- 댓글과 관련된 화면이 작성될 위치 --%>
   <c:if test="${sessionScope.name != null}">
   <div class="row left mt-100 ms-100 me-100">
      <form class="mainReply-insert-form">
         <input type="hidden" name="mainReplyOrigin" value="${mainCommunityDto.mainCommunityNo}">
      
         <div class="row ms-100 me-100">
            <textarea name="mainReplyContent" class="form-input w-100 reply-textarea"
            style="resize:none;" rows=4; ></textarea>
         </div>
         <div class="right ms-100 me-100">
            <button class="right btn btn-positive w-30 mt-10">
               <i class="fa-solid fa-pen"></i>
               댓글등록
            </button>
         </div>
      </form>
   </div>
   </c:if>
   
      <%-- 댓글 목록이 표시될 영역 --%>
   <div class="row left mainReply-list mt-70"></div>

   
   


   <%-- 각종 버튼이 위치하는 곳 --%>
   <div class="row">
   <c:if test="${sessionScope.name != null}">
      <a class="btn btn-positive" href="write">
         <i class="fa-solid fa-pen"></i>
         새글
      </a>
      
      <%-- 수정/삭제는 소유자일 경우만 나와야 한다 --%>
      <c:if test="${sessionScope.name == mainCommunityDto.mainCommunityWriter}">
      <a class="btn btn-negative" href="edit?mainCommunityNo=${mainCommunityDto.mainCommunityNo}">
         <i class="fa-solid fa-pen-to-square"></i>
         수정
      </a>
      <a class="btn btn-negative" href="delete?mainCommunityNo=${mainCommunityDto.mainCommunityNo}">
         <i class="fa-solid fa-trash"></i>
         삭제
      </a>
      </c:if>
      </c:if>
      <c:choose>
         <c:when test="${mainCommunityDto.mainCommunityType == '공지사항'}">
            <a href="noticeList" class="btn">
               <i class="fa-solid fa-list"></i>목록
            </a>
         </c:when>
         <c:otherwise>
            <a href="qnaList" class="btn">
               <i class="fa-solid fa-list"></i>목록
            </a>
         </c:otherwise>
      </c:choose>
      </div>





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>