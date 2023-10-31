 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> --%>

<script>

	

</script>
	<style>
	 
            *{
    box-sizing: border-box;
}

body{
    background-color: #000;
}
header .main{
    position: absolute;
    top: 0px;
    left: 0px;
    width: 100%;
    /* padding: 60%; */
    z-index: 3;
}

header h1{
float: left;
margin-left: 50px;
}

a{
    font-size: 16px;
    text-transform: none;
}

.main-navigation{
    float: right;
    margin-top: 40px;
    margin-right: 50px;
}
.main-navigation a{
    color: #fff;
    margin-left: 40px;
}

.main-navigation a.active{
    font-weight: bold;
    border-bottom: 2px solid #004fff;
    
}

.btn{
    display: inline-block;
    color: #fff;
    font-weight: bold;
    padding: 12px 20px;
    border-radius: 24px;
    background-color: #004fff;
}

.ghost-btn{
    background-color: transparent;
    border: 1px solid #004fff;
}

.text-wrap{
    width: 500px;
    height: 100vh;
    padding: 240px 60px;
    position: absolute;
    right: 0;
    top: 0;
    background-color: #ffffff09;
    z-index: 1;
}

.text-wrap h2{
    color: #fff;
    font-size: 40px;
    line-height: 80px;
    font-weight: lighter;
    margin-bottom: 40px;

}

.text-wrap h3{
    color: #fff;
    font-size: 24px;
    line-height: 30px;
    /* font-weight: lighter; */
    margin-bottom: 20px;
    
}

.text-wrap p{
    color: #fff;
    font-size: 16px;
    line-height: 1.8;
    margin-bottom: 20px;
}    
        
        </style>

	   <!-- <header class="main">
        <h1><a href="/mainhome" style="font-size: 30px; color:#004fff; text-transform: none;">fado</a></h1>
       
            <nav class="main-navigation">
                <a class="active" href="/project/fundinglist">펀딩+</a>
                <a href="/project/fundinglist">인기</a>
                <a href="/project/fundinglist">신규</a>
                <a class="btn ghost-btn" href="/member/login">로그인</a>
             </nav>
        </header> -->



        <div class="video-wrap">

            <video src="${pageContext.request.contextPath}/images/smallpado.mp4" autoplay muted loop
            		style="height: 100vh; width: 100vw;">
            		
            		</video>
					                <!--  poster="../image/pado.poster.png">
                    해당 영상의 경로가 올바르지 않습니다.
                    해당 확장자는 지원하지 않습니다. -->
                </div>
            

                <div class="text-wrap">
                    <h2>kh정보교육원 <br>1조 펀딩 사이트</h2>
                    <h3>누구나 쉽게 시작할 수 있는 펀딩</h3>
                    <p>이것부터 저것까지 <br>없는게없는
                    펀딩 사이트임</p>
                    <div class="btn-wrap">
                        <a class="btn" href="${pageContext.request.contextPath}/mainCommunity/noticeList" style="margin-right: 6px;">공지사항</a>
                        <a class="btn " href="${pageContext.request.contextPath}/member/join" style="margin-right: 6px;">가입하기</a>
                        <a class="btn " href="${pageContext.request.contextPath}/">홈</a>
                    </div>
                </div>
            
       <!-- <footer>
        <div class="sns-wrap">
            <a href="#" class="icon icon-facebook"></a>
        </div>
       </footer>
	 -->
        
    </section>
	

	<%-- <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> --%>
