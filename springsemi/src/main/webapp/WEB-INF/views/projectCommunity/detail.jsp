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
        .btn.btn-positive{
        	display: inline-block;
		    text-decoration: none;
		    vertical-align: bottom;
		    font-size: 13px;
		    padding: 0.5em 1em;
		    outline: none; /*outline은 입력 창 선택 시 강조 효과 */
		    border: 1px solid #2c8de0 ;
		    border-radius: 1em;
		    line-height: 1.2em;
        }
</style>

<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>



<script>
window.contextPath = "${pageContext.request.contextPath}";
$(function(){
	
	$(".projectReply-insert-form").submit(function(e){
		e.preventDefault();
		
		$.ajax({
			url:window.contextPath+"/rest/projectReply/insert",
			method:"post",
			data : $(e.target).serialize(),
			success:function(response){
				$("[name=projectReplyContent]").val("");//입력창 초기화
				loadList();//목록 갱신
			}
		});
	});
	
	loadList();
	
	
	function loadList() {
		var params = new URLSearchParams(location.search);
		var no = params.get("projectCommunityNo");
		var memberId = "${sessionScope.name}";
		
		//비동기 통신으로 화면 갱신
		$.ajax({
			url:window.contextPath+"/rest/projectReply/list",
			method:"post",
			data:{ projectReplyOrigin : no },
			success:function(response){
				//화면 청소
				$(".projectReply-list").empty();//자기 자신을 제외한 내부 코드 삭제
				
				for(var i=0; i < response.length; i++) {
					var projectReply = response[i];
					
					var template = $("#projectReply-template").html();
					var htmlTemplate = $.parseHTML(template);
					
					$(htmlTemplate).find(".projectReplyWriter").text(projectReply.projectReplyWriter || "탈퇴한 사용자");
					$(htmlTemplate).find(".projectReplyContent").text(projectReply.projectReplyContent);
					$(htmlTemplate).find(".projectReplyTime").text(projectReply.projectReplyTime);
					
					//내가 작성한 댓글이 아니라면
					if(memberId.length == 0 || memberId != projectReply.projectReplyWriter) {
						//버튼 삭제
						$(htmlTemplate).find(".w-25").empty();
					}
					
					$(htmlTemplate).find(".btn-delete")
										.attr("data-projectReply-no", projectReply.projectReplyNo)
										.click(function(e){
						var projectReplyNo = $(this).attr("data-projectReply-no");
						$.ajax({
							url:window.contextPath+"/rest/projectReply/delete",
							method:"post",
							data:{projectReplyNo : projectReplyNo},
							success:function(response){
								loadList();
							},
						});
					});
					
					$(htmlTemplate).find(".btn-edit")
											.attr("data-projectReply-no", projectReply.projectReplyNo)
											.click(function(){
						//this == 수정버튼
						var editTemplate = $("#projectReply-edit-template").html();
						var editHtmlTemplate = $.parseHTML(editTemplate);
						
						//value 설정
						var projectReplyNo = $(this).attr("data-projectReply-no");
						var projectReplyContent = $(this).parents(".view-container")
																.find(".projectReplyContent").text();
						$(editHtmlTemplate).find("[name=projectReplyNo]").val(projectReplyNo);
						$(editHtmlTemplate).find("[name=projectReplyContent]").val(projectReplyContent);
						
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
								url:window.contextPath+"/rest/projectReply/edit",
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
					
					$(".projectReply-list").append(htmlTemplate);
				}
			},
		});
	}
});
</script>
<script id="projectReply-template" type="text/template">
		<div class="row flex-container view-container">
			<div class="w-75">
				<div class="row left">
					<h3 class="projectReplyWriter">작성자</h3>
				</div>
				<div class="row left">
					<pre class="projectReplyContent">내용</pre>
				</div>
				<div class="row left">
					<span class="projectReplyTime">yyyy-MM-dd HH:mm:ss</span>
				</div>
			</div>
			<div class="w-25">
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
<script id="projectReply-edit-template" type="text/template">
		<form class="projectReply-edit-form edit-container">
		<input type="hidden" name="projectReplyNo" value="?">
		<div class="row flex-container">
			<div class="w-75">
				<textarea name="projectReplyContent" class="form-input w-100" rows="4">?</textarea>
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
		<h1 style="color:#2c8de0;">프로젝트 커뮤니티</h1>
	</div>
   <div class="left box">
   
      <div class="right">
          작성자 : ${writerDto.memberNickname}
      </div>

      
      <div>
         <span>${projectCommunityDto.projectCommunityContent}</span>
      </div>
      
   </div>
</div>



	<%-- 각종 버튼이 위치하는 곳 --%>
	<div class="row">
	<c:if test="${sessionScope.name != null}">
		<%-- 수정/삭제는 소유자일 경우만 나와야 한다 --%>
		<c:if test="${sessionScope.name == projectCommunityDto.projectCommunityWriter}">
		<a class="btn btn-negative" href="edit?projectCommunityNo=${projectCommunityDto.projectCommunityNo}">
			<i class="fa-solid fa-pen-to-square"></i>
			수정
		</a>
		<a class="btn btn-negative" href="delete?projectCommunityNo=${projectCommunityDto.projectCommunityNo}">
			<i class="fa-solid fa-trash"></i>
			삭제
		</a>
		<a class="btn" href="/project/detail?projectNo=${projectCommunityDto.projectNo}">
			<i class="fa-solid fa-bars"></i>
			목록
		</a>
		
		</c:if>
		</c:if>
		
		</div>



	<%-- 댓글과 관련된 화면이 작성될 위치 --%>
	<div class="container w-1000">
	<c:if test="${sessionScope.name != null}">
	<div class="row left mt-100 ms-100 me-100">
		<form class="projectReply-insert-form">
			<input type="hidden" name="projectReplyOrigin" value="${projectCommunityDto.projectCommunityNo}">
		
			<div class="row ms-100 me-100">
				<textarea name="projectReplyContent" class="form-input w-100" rows="4" style="resize:none;"></textarea>
			</div>
			<div class="row ms-100 me-100">
				<button class="btn btn-positive w-30 mt-10">
					<i class="fa-solid fa-pen"></i>
					댓글등록
				</button>
			</div>
		</form>
	</div>
	</c:if>
	
		<%-- 댓글 목록이 표시될 영역 --%>
	<div class="row left projectReply-list"></div>
	</div>
	
	
	



		
		
		



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>