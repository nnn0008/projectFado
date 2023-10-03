$(function(){

    var status = {
        rewardType:false,
        rewardPrice:false,
        ok:function(){
            return this.rewardType 
                    && this.rewardPrice;
        },
    };

    $("[name=rewardType]").blur(function(){
        var regex = /^[가-힣]{2,4}$/;
        var isValid = regex.test($(this).val());
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.rewardType = isValid;
    });

    $("[name=rewardPrice]").blur(function(){
        var contactRegex =  /^010[1-9][0-9]{7}$/;
        var con = $(this).val();
        var isValid = con.length != 0 || contactRegex.test(con);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.rewardPrice = isValid;
    });

    $(window).on("beforeunload", function(){
        return false;
    });

    $(".delivery-insert-form").submit(function(e){
        $(".form-input").blur(); 
        if(!status.ok()) {
            e.preventDefault();
        }
        else {
            $(window).off("beforeunload");
        }
    });

    $(".post-clear").click(function(){
        $("[name=deliveryPost],[name=deliveryAddr1],[name=deliveryAddr2]").val("").removeClass("success fail");
    });
    $("[name=memberAddr2]").on("input blur", function(){
        var post = $("[name=deliveryPost]").val();
        var addr1 = $("[name=deliveryAddr1]").val();
        var addr2 = $("[name=deliveryAddr2]").val();
        if(post.length == 0 && addr1.length == 0 && addr2.length == 0) {
            $(".post-clear").hide();				
        }
        else {
            $(".post-clear").show();        	
        }
    });
    $(".post-clear").hide();

    $(".post-search").click(function(){
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                $("[name=deliveryPost]").val(data.zonecode);
                $("[name=deliveryAddr1]").val(addr);
                $("[name=deliveryAddr2]").focus();
                $(".post-clear").show();
            }
        }).open();
    });

});