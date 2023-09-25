<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.size-15 {
	font-size: 15px;
}
</style>

<script>
$(function(){
    var status = {
        memberId:false,
        memberPw:false,
        memberPwCheck:false,
        memberNickname:false,
        memberBirth:false,
        memberContact:false,
        memberEmail:false,
        ok:function(){
            return this.memberId && this.memberPw 
                        && this.memberPwCheck && this.memberNickname 
                        && this.memberBirth && this.memberContact
                        && this.memberEmail;
        },
    };

    $("[name=memberId]").blur(function(e){
        var regex = /^[a-z][a-z0-9-_]{4,19}$/;
        var isValid = regex.test($(e.target).val());
        
        if(isValid) {//형식이 유효하다면
            
            $.ajax({
                url:"http://localhost:8080/rest/member/idCheck",
                method:"post",
                data : { memberId : $(e.target).val() },
                success : function(response){
                    $(e.target).removeClass("success fail fail2");
                    if(response == "Y") {//사용가능
                        $(e.target).addClass("success");
                        status.memberId = true;
                    }
                    else {//사용불가(중복)
                        $(e.target).addClass("fail2");
                        status.memberId = false;
                    }
                },
                error : function(){
                    alert("서버와의 통신이 원활하지 않습니다");
                },
            });
            
        }
        else {//형식이 유효하지 않다면(1차실패)
            $(e.target).removeClass("success fail fail2");
            $(e.target).addClass("fail");
            status.memberId = false;
        }
    });
    $("[name=memberPw]").blur(function(){
        var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
        var isValid = regex.test($(this).val());
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.memberPw = isValid;
    });
    $("#password-check").blur(function(){
        var pw1 = $("[name=memberPw]").val();
        var pw2 = $(this).val();
        $(this).removeClass("success fail fail2");
        if(pw1.length == 0) {
            $(this).addClass("fail2");
            status.memberPwCheck = false;
        }
        else if(pw1 == pw2) {
            $(this).addClass("success");
            status.memberPwCheck = true;
        }
        else {
            $(this).addClass("fail");
            status.memberPwCheck = false;
        }
    });
    $("[name=memberNickname]").blur(function(e){
        var regex = /^[가-힣0-9]{1,10}$/;
        var isValid = regex.test($(e.target).val());
        
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
                    }
                    else {//이미 사용중인 닉네임
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

    $("[name=memberBirth]").blur(function(){
        var regex = /^(19[0-9]{2}|20[0-9]{2})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/;
        var birth = $(this).val();
        var isValid = birth.length == 0 || regex.test(birth);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.memberBirth = isValid;
    });

    $("[name=memberContact]").blur(function(){
        var regex = /^010[1-9][0-9]{7}$/;
        var contact = $(this).val();
        var isValid = contact.length == 0 || regex.test(contact);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.memberContact = isValid;
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

     //페이지 이탈 방지
     //- window에 beforeunload 이벤트 설정
     $(window).on("beforeunload", function(){
         return false;
     });

    //- form 전송할 때는 beforeunload 이벤트를 제거
    $(".join-form").submit(function(e){
        $(".form-input").blur();
        if(!status.ok()) {
            e.preventDefault();
        }
        else {
            $(window).off("beforeunload");
        }
    });
    
});

//체크박스
function refreshCheckbox(tag) {
    if(tag.classList.contains("check-all")) {
        var itemList = document.querySelectorAll(".check-item");
        var allList = document.querySelectorAll(".check-all");

        for(var i=0; i < itemList.length; i++) {
            itemList[i].checked = tag.checked;
        }
        for(var i=0; i < allList.length; i++) {
            allList[i].checked = tag.checked;
        }

        var btn = document.querySelector(".btn-positive");
        btn.disabled = !tag.checked;
    }
    else if(tag.classList.contains("check-item")) {
        var itemList = document.querySelectorAll(".check-item");
        var checkedItemList = document.querySelectorAll(".check-item:checked");
        var allChecked = itemList.length == checkedItemList.length;

        var allList = document.querySelectorAll(".check-all");
        for(var i=0; i < allList.length; i++) {
            allList[i].checked = allChecked;
        }

        var btn = document.querySelector(".btn-positive");
        btn.disabled = !allChecked;
    }
}
</script>


<form action="join" method="post"  class="join-form" autocomplete="off">
	<div class="container w-600">
	
		<div class="row fado">
			<h2>회원 가입</h2>
		</div>
		
		<div class="row left">
	            <label>아이디 <i class="fa-solid fa-asterisk red"></i></label>
	            <input type="text" name="memberId" placeholder="영문 소문자, 숫자 5~20자 이내로 작성하세요."
	                    class="form-input w-100 size-15 ">
	            <div class="success-feedback">사용 가능한 아이디입니다.</div>
	            <div class="fail-feedback">아이디 형식이 올바르지 않습니다.</div>
	            <div class="fail2-feedback">이미 사용중인 아이디입니다.</div>
	    </div>
	    
	    <div class="row left">
	            <label>비밀번호 <i class="fa-solid fa-asterisk red"></i></label>
	            <input type="password" name="memberPw" 
	                    placeholder="영문, 숫자, 특수문자 반드시 1개 이상 포함하여 작성하세요."
	                    class="form-input w-100 size-15">
	            <div class="success-feedback">올바른 비밀번호 형식입니다.</div>
	            <div class="fail-feedback">잘못된 비밀번호 형식입니다.</div>
	    </div>
	    
	    <div class="row left">
	            <label>비밀번호 확인 <i class="fa-solid fa-asterisk red"></i></label>
	            <input type="password" id="password-check" 
	                    placeholder="비밀번호를 한 번 더 입력하세요." class="form-input w-100 size-15">
	            <div class="success-feedback">비밀번호가 일치합니다.</div>
	            <div class="fail-feedback">비밀번호가 일치하지 않습니다.</div>
	            <div class="fail2-feedback">비밀번호를 먼저 작성하세요.</div>
	    </div>
	    
	      <div class="row left">
	            <label>닉네임 <i class="fa-solid fa-asterisk red"></i></label>
	            <input type="text" name="memberNickname" 
	                placeholder="한글 또는 숫자 2~10자 이내로 입력하세요." class="form-input w-100 size-15">
	            <div class="success-feedback">사용 가능한 닉네임입니다.</div>
	            <div class="fail-feedback">닉네임 형식이 올바르지 않습니다.</div>
	            <div class="fail2-feedback">이미 사용중인 닉네임입니다.</div>
	    </div>
	        
	    <div class="row left">
	            <label>생년월일</label>
	            <input type="date" name="memberBirth" class="form-input w-100 size-15">
	            <div class="fail-feedback">잘못된 날짜를 선택하셨습니다.</div>
	    </div>
	    
	    <div class="row left">
	            <label>연락처</label>
	            <input type="tel" name="memberContact" placeholder="010XXXXXXXX (- 없이)"
	                    class="form-input w-100 size-15">
	            <div class="fail-feedback">전화번호 형식이 올바르지 않습니다.</div>
	    </div>
	    
	    <div class="row left">
	            <label>이메일 <i class="fa-solid fa-asterisk red"></i></label>
	            <input type="text" name="memberEmail" 
	                    placeholder="test@gmail.com" class="form-input w-100 size-15">
	            <div class="fail-feedback">이메일 형식이 올바르지 않습니다.</div>
	            <div class="fail2-feedback">이메일을 입력해주세요.</div>
	    </div>
	    
	    <div class="row left">
            <label>
                <input type="checkbox" class="check-all" oninput="refreshCheckbox(this)"> 전체동의
            </label>
        </div>

        <div class="row left">
            <textarea class="form-input w-100" readonly>dummy text</textarea>
        </div>
        <div class="row left">
            <label>
                <input type="checkbox" class="check-item" oninput="refreshCheckbox(this)"> 만 14세 이상입니다.(필수)
            </label>
        </div>
        <div class="row left">
            <textarea class="form-input w-100" readonly>dummy text</textarea>
        </div>
        <div class="row left">
            <label>
                <input type="checkbox" class="check-item" oninput="refreshCheckbox(this)"> 파도 이용약관 동의(필수)
            </label>
        </div>
        <div class="row left">
            <textarea class="form-input w-100" readonly>dummy text</textarea>
        </div>
        <div class="row left">
            <label>
                <input type="checkbox" class="check-item" oninput="refreshCheckbox(this)"> 개인정보 수집 및 동의(필수)
            </label>
        </div>
	    
	    <div class="row">
		    <button type="submit" class="btn btn-positive w-100">
		    가입하기
		    </button>  
	    </div>
	    
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>