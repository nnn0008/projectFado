<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
</style>

<script>
$(function(){
	//상태 객체
	var status = {
        memberNickname:false,
        memberEmail:false,
        memberContact:false,
        memberBirth:false,
        ok:function(){
            return this.memberNickname && this.memberEmail
                        && this.memberContact && this.memberBirth;
        },
    };

	$("[name=memberNickname]").blur(function(e){
		var nicknameValue = $(e.target).val(); //내 닉네임 
        var regex = /^[가-힣0-9]{1,10}$/; //정규표현식
        var isValid = regex.test($(e.target).val()); //형식에 맞는가
        
        if(isValid) {//형식 통과

            $.ajax({
                url:"http://localhost:8080/rest/member/nicknameCheck",
                method:"post",
                data : { memberNickname : $(e.target).val() },
                success : function(response){
                    $(e.target).removeClass("success fail fail2");
                    if(response == "Y") {//사용 가능한 닉네임
                        $(e.target).addClass("success");
                        status.memberNickname = true;
                    } //닉네임을 변경하지 않는다면
                    else if (nicknameValue == "${memberDto.memberNickname}") {
                        $(e.target).removeClass("success fail fail2");
                        status.memberNickname = true; //통과
                    } else {//이미 사용중인 닉네임
                        $(e.target).addClass("fail2");
                        status.memberNickname = false;
                    }
                },
                error : function(){
                    alert("서버와의 통신이 원활하지 않습니다");
                },
            });

        }
        else {//형식 오류
            $(e.target).removeClass("success fail fail2");
            $(e.target).addClass("fail");
            status.memberNickname = false;
        }
    });
	
	 $("[name=memberEmail]").blur(function(){
	        var regex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
	        var email = $(this).val();
	        var isValid = regex.test(email);
	        
	        $(this).removeClass("success fail fail2");
	        if(email.length == 0) {
	            $(this).addClass("fail2");
	            status.memberEmail = false;
	        } else if (isValid) {
	        	$(this).addClass("success");
	            status.memberEmail = true;
	        } else {
	        	$(this).addClass("fail");
	            status.memberEmail = false;
	        }
	    });
	 
	 $("[name=memberContact]").blur(function(){
	        var regex = /^010[1-9][0-9]{7}$/;
	        var contact = $(this).val();
	        var isValid = contact.length == 0 || regex.test(contact);
	        $(this).removeClass("success fail");
	        $(this).addClass(isValid ? "success" : "fail");
	        status.memberContact = isValid;
	    });
	
	$("[name=memberBirth]").blur(function(){
        var regex = /^(19[0-9]{2}|20[0-9]{2})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/;
        var birth = $(this).val();
        var isValid = birth.length == 0 || regex.test(birth);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.memberBirth = isValid;
    });

	//페이지 이탈 방지
    //- window에 beforeunload 이벤트 설정
    $(window).on("beforeunload", function(){
        return false;
    });

    //- form 전송할 때는 beforeunload 이벤트를 제거
    $(".change-form").submit(function(e){
        $(".form-input").blur();
        if(!status.ok()) {
            e.preventDefault();
            //return false;
        }
        else {
            $(window).off("beforeunload");
        }
    });

});
</script>

<form action="change" method="post" autocomplete="off" class="change-form">
<div class="center container w-500">


	<div class="row fado mt-100">
		<h1>개인정보 변경</h1>
	</div>
	
	<div class="row left fado">
	
		<label>닉네임</label>
	  	<input type="text" name="memberNickname"  class="form-input w-100 mt-10"
	  	 value="${memberDto.memberNickname}"  style="	font-size: 15px;">
		<div class="success-feedback">사용 가능한 닉네임입니다.</div>
		<div class="fail-feedback">닉네임은 한글 또는 숫자로 2~10자 이내에 작성해주세요.</div>
		<div class="fail2-feedback">이미 사용중인 닉네임입니다.</div>
	  	
	</div>
	
	<hr class="hr-style">
	
	<div class="row left fado">
		<label>이메일</label>
    	<input type="email" name="memberEmail"  class="form-input w-100 mt-10"
   	 	value="${memberDto.memberEmail}" placeholder="testuser@kh.com" style="font-size: 15px;">
	</div>
	
	<hr class="hr-style">
	
	<div class="row left fado">
		<label>연락처</label>
    	<input type="tel" name="memberContact"  class="form-input w-100 mt-10"
     	value="${memberDto.memberContact}" placeholder="- 제외하고 입력" style="font-size: 15px;">
	</div>
	
	<hr class="hr-style">
	
	<div class="row left fado">
		<label>생년월일</label>
    	<input type="date" name="memberBirth" value="${memberDto.memberBirth}"
    	class="form-input w-100 mt-10" style="font-size: 15px;">
	</div>
	
	<hr class="hr-style">
	
	<div class="row left fado">
		<label>비밀번호 확인</label>
    	<input type="password" name="memberPw" required class="form-input w-100 mt-10" style="font-size: 15px;"> 
	</div>
	
	<hr class="hr-style">
	
    <div class="row left">
        <button type="submit" class="btn btn-positive w-100">변경하기</button>
    </div>
    
    <c:if test="${param.error != null}">
   		<div class = "row red">
			<h3>입력하신 비밀번호가 일치하지 않습니다.</h3>
		</div>
	</c:if>
	
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>