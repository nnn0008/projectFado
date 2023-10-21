<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>




<style>
.box{
	border: 1px solid #2c8de0; 
	border-radius: 5px;"
}
</style>
<script>
$(document).ready(function() {
    $(".add-amount").on("click", function() {
        var amount = parseInt($(this).data("amount"));
        var currentAmount = parseInt($("input[name=memberPoint]").val() || 0);
        var newAmount = currentAmount + amount;
        $("input[name=memberPoint]").val(newAmount);
    });
});

</script>



<form action="pointPlus" method="post" autocomplete="off" class="change-form">
<div class="box container center" style="width: 50%;">
    <div class="left mb-20 ps-20 pe-20 pt-10 pb-10" style="height: 200px;">
        <div class="row fado bold">현재 보유한 포인트</div>
        <div style="font-size:30px" class="me-10 row">
		     <fmt:formatNumber value="${memberDto.memberPoint}" 
		                            pattern="#,##0"></fmt:formatNumber> pt 
        </div>
    </div>

	<div class="row">
	     <div class="row fado bold mt-10">충전 포인트</div>
	        <div class="row">
			<div class="row">
			    <input type="number" class="form-input" name="memberPoint">pt
			</div>
	        </div>
	        <div class="row">
	            <button type="button" class="btn add-amount" data-amount="1000">+1,000원</button>
	            <button type="button" class="btn add-amount" data-amount="5000">+5,000원</button>
	            <button type="button" class="btn add-amount" data-amount="10000">+10,000원</button>
	            <button type="button" class="btn add-amount" data-amount="50000">+50,000원</button>
	        </div>
	        
	        <div>
	        	<button type="submit" class="btn btn-positive">충전하기</button>
	        </div>
		
	</div>
    
    
    
</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>