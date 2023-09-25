<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
   $(function(){
       //처음에 로딩아이콘 숨김
       $(".btn-send").find(".fa-spinner").hide();
       $(".cert-wrapper").hide();

       //인증번호 보내기 버튼을 누르면 서버로 비동기 통신을 보내 인증메일 발송 요청
       $(".btn-send").click(function(){
           var email = $("[name=memberEmail]").val();
           if (email.length == 0) return;

           $(this).prop("disabled", true);
           $(this).find(".fa-spinner").show();
           $(".btn-send").find("span").text("이메일 발송 중");
           $.ajax({
               url:"http://localhost:8080/rest/cert/send",
               method:"post",
               data:{certEmail : email},
               success:function(){
                   $(".btn-send").prop("disabled", false);
                   $(".btn-send").find(".fa-spinner").hide();
                   $(".btn-send").find("span").text("인증번호 보내기");

                   $(".cert-wrapper").show();
                   window.email = email;
               },
           });
       });

       //확인 버튼을 누르면 이메일과 인증번호를 서버로 전달하여 검사
       $(".btn-cert").click(function(){
           var email = $("[name=memberEmail]").val();
           var number = $(".cert-input").val();

           if(email.length == 0 || number.length == 0) return;

           $.ajax({
               url:"http://localhost:8080/rest/cert/check",
               method:"post",
               data: {
                   certEmail : email,
                   certNumber : number,
               },
               success:function(response){
                   if(response.result) { //인증 성공
                       $(".cert-input").removeClass("success fail")
                                               .addClass("success");
                       $(".btn-cert").prop("disabled", true);
                       //상태객체에 상태 저장하는 코드
                   }
                   else { //인증 실패
                       $(".cert-input").removeClass("success fail")
                                           .addClass("fail");
                       //상태겍체에 상태 저장하는 코드
                   }
               }
           });
       });
   });
</script>

<div class="container w-400">

	<div class="row">
		<input class="form-input" type ="email" name="memberEmail" placeholder="이메일을 입력해주세요.">
	</div>
	
	<div class="row">
		<button class="btn btn-positive btn-send">
	        <i class="fa-solid fa-spinner fa-spin"></i>
	        <span>인증번호 보내기</span>
    	</button>
	</div>
	
	<div class="cert-wrapper">
        <input type="text" class="form-input cert-input">
        <button class="btn btn-positive btn-cert">확인</button>
    </div>


</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
