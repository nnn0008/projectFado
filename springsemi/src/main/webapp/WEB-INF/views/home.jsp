<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	
	<c:if test="${sessionScope.name != null}">

<script>
	//좋아요 처리
	//[1] 페이지가 로드되면 비동기 통신으로 좋아요 상태를 체크하여 하트 생성
	//[2] 하트에 클릭 이벤트를 설정하여 좋아요 처리가 가능하도록 구현
	$(function(){
		var params = new URLSearchParams(location.search);
		var projectNo = params.get("projectNo");
	
		$.ajax({
			url:"/rest/like/check",
			method:"post",
			data:{projectNo : projectNo},
			success:function(response) {
				//response는 {"check":true, "count":0} 형태의 JSON이다
			
				if(response.check) {
					$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
				}
				else{
					$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
				}
				//전달받은 좋아요 개수를 하트 뒤의 span에 출력
				$(".fa-heart").next("span").text(response.count);
			}
		});
		
		//[2]
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
					//전달받은 좋아요 개수를 하트 뒤의 span에 출력
					$(".fa-heart").next("span").text(response.count);
				}
			});
		});
	});
</script>

</c:if>
	
<div class="container w-500">
	
	
		
	<div class="row">
		<h3>1조 화이팅! :D </h3>
	</div>
	
	
		<i class="fa-regular fa-heart red"></i> 
		<span>?</span>
	
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</div>