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
        var type = $(this).val();
        var isValid = type.length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.rewardType = isValid;
    });

    $("[name=rewardPrice]").blur(function(){
        var price = $(this).val();
        var isValid = price.length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.rewardPrice = isValid;
    });

    $(window).on("beforeunload", function(){
        return false;
    });

    $(".reward-insert-form").submit(function(e){
        $(".form-input").blur(); 
        if(!status.ok()) {
            e.preventDefault();
        }
        else {
            $(window).off("beforeunload");
        }
    });


});