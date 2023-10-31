<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">


    <style>
   .note-editable{
   line-height: 2em !important;
   }
   
   .select{
   display: inline-block;
    text-decoration: none;
    vertical-align: bottom;

    font-size: 15px;
    padding: 0.5em 1em;
    outline: none; /*outline은 입력 창 선택 시 강조 효과 */
    border: 1px solid #2c8de0 ;
    border-radius: 0.5em;
    line-height: 1.2em;
   }
   
   .form-input1
   {
    /* a 태그 때문에 추가한 속성 */
    display: inline-block;
    text-decoration: none;
    vertical-align: bottom;

    font-size: 15px;
    padding: 0.5em 1em;
    outline: none; /*outline은 입력 창 선택 시 강조 효과 */
    border: 1px solid #2c8de0 ;
    border-radius: 0.5em;
    line-height: 1.2em;
}
    </style>
    <script>
        $(function(){
            $(".form-input1").on("input", function(){
                var content = $(this).val();
                
                $(this).next(".form-input-length").text(content.length);

                if(content.length > 1000) {
                    $(this).next(".form-input-length").addClass("red");
                }
                else {
                    $(this).next(".form-input-length").removeClass("red");
                }
            });
        });
    </script>
    
    
<script src="${pageContext.request.contextPath}/js/boardWrite.js"></script>



<form action="write" method="post" autocomplete="off">
<div class="container w-600">
   
   <c:choose>
      <c:when test="${sessionScope.level == '판매자'}">
         <input type="hidden" name="projectCommunityType" value="공지사항">
      </c:when>
      
      <c:otherwise>
         <input type="hidden" name="projectCommunityType" value="Q&A">
      </c:otherwise>
   </c:choose>
   
   <input type="hidden" name="projectNo" value="${param.projectNo}">

   <div>
      <textarea name="projectCommunityContent" class="form-input1 w-100" rows="15" style="resize:none;"
      placeholder="내용을 입력해주세요."></textarea>
      <span class="form-input-length">0</span> / 1000
   </div>
   <div class="right mt-10">
      <button class="btn btn-positive">작성하기</button>
   </div>
</div>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>