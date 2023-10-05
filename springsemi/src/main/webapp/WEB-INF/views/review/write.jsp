<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
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

<div class="container center w-600 mb-50">
   	<hr>
   	<h2>서핑 후기 작성</h2>
   	<hr>
</div>
<form action="write" method="post" enctype="multipart/form-data">
<div class="container w-600">
	<input type="hidden" name="projectNo" value="${param.projectNo}">

	<div class="mb-10">
		첨부파일 등록 <input type="file" name="attach" accept="image/*">
	</div>
	<div>
		<textarea name="reviewContent" class="form-input1 w-100" rows="15" style="resize:none;"></textarea>
		<span class="form-input-length">0</span>/1000
	</div>
	<div class="right mt-10">
		<button class="btn btn-positive">작성하기</button>
	</div>
</div>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>