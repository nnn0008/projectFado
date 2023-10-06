$(function(){

    var status = {
        projectTitle:false,
        projectGoalPrice:false,
        projectStartDate:false,
        projectPeriod:false,
        majorCategoryNo:false,
        minorCategoryNo:false,
        mainAttach:false,
        subAttach:false,
        ok:function(){
            return this.projectTitle 
                    && this.projectGoalPrice 
                    && this.projectStartDate 
                    && this.projectPeriod 
                    && this.mainAttach 
                    && this.subAttach 
                    && this.majorCategoryNo 
                    && this.minorCategoryNo;
        },
    };

    $("[name=mainAttach]").blur(function(){
        var con = $(this).val();
        var isValid = con.length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.mainAttach = isValid;
    });
    
    $("[name=subAttach]").blur(function(){
        var con = $(this).val();
        var isValid = con.length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.subAttach = isValid;
    });
    $("[name=projectTitle]").blur(function(){
        var con = $(this).val();
        var isValid = con.length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.projectTitle = isValid;
    });

    $("[name=projectGoalPrice]").blur(function(){
        var con = $(this).val();
        var isValid = con.length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.projectGoalPrice = isValid;
    });
    
    $("[name=projectStartDate]").blur(function(){
        var con = $(this).val();
        var isValid = con.length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.projectStartDate = isValid;
    });
    
    $("[name=projectPeriod]").blur(function(){
        var con = $(this).val();
        var isValid = con.length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.projectPeriod = isValid;
    });
    
    $("[name=majorCategoryNo]").blur(function(){
        var no = $(this).val();
        var isValid = no.length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.majorCategoryNo = isValid;
    });
    
    $("[name=minorCategoryNo]").blur(function(){
        var no = $(this).val();
        var isValid = no.length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.minorCategoryNo = isValid;
    });


    $(window).on("beforeunload", function(){
        return false;
    });

    $(".project-insert-form").submit(function(e){
        $(".form-input").blur(); 
        if(!status.ok()) {
            e.preventDefault();
        }
        else {
            $(window).off("beforeunload");
        }
    });


});