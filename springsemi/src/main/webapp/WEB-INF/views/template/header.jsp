<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>main</title>

    <!-- css 파일을 불러오는 코드 -->

    <!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
    <link rel="stylesheet" type="text/css"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <!-- 구글 웹 폰트 사용을 위한 CDN -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!-- 내가 만든 CSS 파일-->
    <!-- <link rel="stylesheet" type="text/css" href="/css/reset.css"> -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons.css">
    <!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->

    <!-- jquery cdn -->
	<script src="${pageContext.request.contextPath}/js/easytimer.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/moment-duration-format@2.3.2/lib/moment-duration-format.min.js"></script>
	<!-- swiper cdn -->
	<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
	
<style>
		

		a{
		text-decoration: none;
		   color: #2c8de0;;
		}
            
        .btn .btn-positive1 {
            width: 150px;
            height: 150px;
            padding-left: 100px;
            padding-right: 100px;
            background-color:#ffffff00;
            border-color:#ffffff00;
            font-color:black;
        }

        /* .hr1{
            border: 0.1px solid #2a0779;
            /* box-shadow: 0 0 0 0.4px #2907799b; */
        /* box-shadow: 0 5px 10px #2a0779(0, 0, 0, 10); */

        /* /* } */
        .hr1 {
            border: none;
            /* 기본 가로선 제거 */
            height: 1px;
            /* 원하는 높이로 설정 */
            background-color: #2a0779;
            /* 가로선의 색상 지정 */

            /* 배너를 위한 style */
            :root {
                --swiper-theme-color: #2c8de0;
            }

            .swiper {
                width: 300%;
                height: 300px;
            }

            /* 배너 */
            .container1 {
                margin-left: auto;
                margin-right: auto;
                /* 주 축이 위에서 아래로 */
                display: column;
                /* 크기 */
                flex-grow: 2;
                /* 더 많이 줄어들게 */
                flex-shrink: 2;
            }


            /* 상품 */
            .container-project {
                height: 100vh;
                /* 가로정렬 */
                display: flex;
                /* row는 왼쪽에서 오른쪽으로 */
                flex-direction: row;
                /* 화면이 작아져도 밀리지않게 화면이 작아졌을때 아래로 밀리게 하려면 wrap */
                flex-wrap: nowrap;
                /* 왼쪽배치 End는 순서고정 오른쪽붙혀서 배치 center로 지정하면 양쪽 공백 가운데지정 */
                justify-content: space-evenly;
                /* 상품여러개배치 (랭킹 넣을때 써볼게) */
                /* align-content: space-between; */
            }

            .item {
                width: 40px;
                height: 40px;
                border: solid white;
                /* display: flex; */
            }

            .item1 {
                /* 크기 */
                /* flex-grow: 1; */
                /* 더 많이 줄어들게 */
                /* flex-shrink: 1; */
                /* 해당 스타일만 개인설정 */
                /* align-self: right; */
                background-color: #fa7d90;

            }

            .item2 {
                /* 크기 */
                /* flex-grow: 1; */
                /* 더 많이 줄어들게 */
                /* flex-shrink: 1; */
                /* 해당 스타일만 개인설정 */
                /* align-self: right; */
                background-color: #fa7d90;

            }

            .item3 {
                /* 크기 */
                /* flex-grow: 1; */
                /* 더 많이 줄어들게 */
                /* flex-shrink: 1; */
                /* 해당 스타일만 개인설정 */
                /* align-self: right; */
                background-color: #fa7d90;

            }

            .item4 {
                /* 크기 */
                /* flex-grow: 1; */
                /* 더 많이 줄어들게 */
                /* flex-shrink: 1; */
                /* 해당 스타일만 개인설정 */
                /* align-self: right; */
                background-color: #fa7d90;

            }
            
            /* 검색창 */
            /* 초기에 숨겨진 검색창 */
			/* .backdrop {
			    display: none;
			    position: fixed;
			    top: 0;
			    left: 0;
			    width: 100%;
			    height: 100%;
			    background-color: rgba(0, 0, 0, 0.7);
			    z-index: 999;
			} */
			
			/* 확장된 검색창 스타일 */
			/* .container.w-900 {
			    position: fixed;
			    top: 50%;
			    left: 50%;
			    transform: translate(-50%, -50%);
			    background-color: #fff;
			    padding: 20px;
			    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
			    z-index: 1000;
			} */
			
			/* 검색창 확장 시 스타일 */
			/* .search-expanded .backdrop {
			    display: block;
			} */
			
			/* 검색창 닫힘 시 스타일 */
			/* .search-collapsed .backdrop {
			    display: none;
			}
        } */
    </style>
    
	<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


    <!-- javascript 작성 공간 -->
    <script>
    window.contextPath = "${pageContext.request.contextPath}";
        // 목표 : 버튼을 누르면 안녕! 이라는 alert이 뜨게 해보자!
        // 단, onclick 안쓰고 해야됨

        // 1. 버튼을 선택한다
        // 2. 버튼에 클릭 이벤트를 설정한다
        // 3. 클릭 이벤트에서 함수를 실행한다


        // window.addEventListener("이벤트종류",함수);
    
       /*  window.addEventListener("load", function () {
            var btn = document.querySelector(".btn");
            btn.addEventListener("click", function () {
                alert("빵빵아");
            });
        }); */

        // 배너를 위한 스크립트


        $(function () {
            loadList();
            var swiper = new Swiper('.swiper', {
                //direction: 'vertical',//슬라이드 방향
                loop: true,//슬라이드의 순환 설정

                pagination: {
                    el: '.swiper-pagination',//적용할 요소
                    type: 'bullets',//페이지네이션 유형 (progressbar/bullets/fraction)
                    clickable: true,//페이지네이션 클릭가능여부
                },

                // 이동 화살표
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                    hideOnClick: true,//클릭 시 숨김 처리 여부
                },

                // 스크롤바
                // scrollbar: {
                //     el: '.swiper-scrollbar',
                // },

                // 자동재생
                autoplay: {
                    delay: 2000,//재생간격(ms)
                    pauseOnMouseEnter: true,//마우스 진입 시 멈춤 여부
                },

                //이펙트(전환효과) 설정
                effect: "slide",//(slide/fade/cube/coverflow/flip/creative/cards)
            });
            
            //반복문을 통해 카테고리를 찍어주겠다
            function loadList(){
            	$(".majorCategory").empty();
            	$.ajax({
					url:window.contextPath+"/rest/category/majorList",            		
            		method:"post",
            		data:{},
            		success:function(response){
            			for(var i = 0; i < response.length; i++){
            				var aTag = $("<a>").attr("href", window.contextPath+"/project/list?keyword="+response[i].majorCategoryType).text(response[i].majorCategoryType);

            				aTag.appendTo(".majorCategory");
            			}
            		}
            	});
            }
            
            
        });
        
        
        /* 검색창  */
        /* $(document).ready(function () { */
    // 검색창 클릭 이벤트
  /*   $(".search-container").click(function () {
        // 검색창 상태에 따라 클래스를 토글하여 확장/축소
        if ($(".backdrop").hasClass("search-expanded")) {
            $(".backdrop").removeClass("search-expanded");
        } else {
            $(".backdrop").addClass("search-expanded");
        }
    });
    
    // 검색창 닫기 버튼 클릭 이벤트
    $(".exit").click(function () {
        $(".backdrop").removeClass("search-expanded");
    });
}); */
        
    </script>



</head>

<body>

    <header>
        <div class="logo">
            <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/images/smallfado.jpg" style="height: 60px;" class="me-50"></a>
        </div>
        
        <div class="title flex-container row">
			<!--  <div class="backdrop"> -->
        <form action ="/project/list" method="get">
        	<div class="container">
	        	<div class="flex-container" style="border: 3px solid #2c8de0; border-radius: 5px;">
					<div class="w-100">
		        		<input type="search" class="pointer w-100 focus p-10" name="keyword" 
		        		placeholder="검색어를 입력해주세요" value="" 
		        		style="width:350px; height:50px; border:none;">
					</div>     
					<div class="me-20 mt-10 ms-10">
		           	 	<i class="fa-solid fa-magnifying-glass fa-2x" style="color:#2c8de0;"></i>
					</div>
       		</div>
					
	        			<!-- <i class="fa-solid fa-x exit"></i>	 -->				

					<!-- <hr> -->	        	

	        	<!-- <div class="row left">
	        		최근검색어
	        		
	        	</div>
	        	<div class="row left">
	        		파도 인기 검색어
	        		
	        	</div> -->
        	</div>
        </form>
        </div>
        
        
        <div class="etc">
	        <div class="me-20">
	        	<a href="${pageContext.request.contextPath}/member/pointPlus">
		        	<button type="button" class="btn">
		        		포인트 충전 <i class="fa-solid fa-coins" style="color: #508fe0;"></i>
		        	</button>
        		</a>
	        </div>
           <a class="me-50" href="${pageContext.request.contextPath}/main">main</a>
              <div style="font-size:14px" style="color:#2c8de0;">
                 <c:choose>
                    <c:when test="${sessionScope.name != null }">
                 <a href="${pageContext.request.contextPath}/project/write">프로젝트업로드
                   <i class="fa-solid fa-pen" style="color:#2c8de0;"></i></a>
                   </c:when>
                   
                   <c:otherwise>
                   </c:otherwise>
                   </c:choose>
            	</div>
			
			
				
				
				
				<!-- 로그인 버튼 관련 -->
						
						<div class="row etc-menu custom-menu navy ms-30">
						<c:choose>
							<c:when test="${sessionScope.name != null }">
						
								
									<span>
										 
										<a class="left" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>	
									</span>
									
								<div class="custom-service">
									<a class="left" href="${pageContext.request.contextPath}/member/mypage">마이페이지</a>
									<a class="left" href="${pageContext.request.contextPath}/mainCommunity/noticeList">공지사항</a>
									
									
									<c:if test="${sessionScope.level == '관리자'}">
										<a href="${pageContext.request.contextPath}/admin/home">관리자메뉴</a>
									</c:if>
								</div>
								
							</c:when>
						
						<c:otherwise>
							
								<span>
									<a href="${pageContext.request.contextPath}/member/login">로그인<i class="fa-solid fa-angle-down"></i></a>
								</span>
							<div class="custom-service">
								
								<a class="left" href="${pageContext.request.contextPath}/member/join">회원가입</a>

							</div>	
							
							
							
						</c:otherwise>
						</c:choose>
						</div>
						
            </div>
        
       

    </header>

    <!-- <hr> -->

    <nav>
        <!-- 애니메이션 추가하고싶음 -->
        <ul class="menu center flex-container">
            <li>
                <div style="display: flex; align-items:center;" class="ms-10">
                    <i class=" fa-solid fa-bars" style="color: #2a0779; 
                    padding-left: 10px;"></i>
                    <a>카테고리</a>
                </div>
                <ul>
                    <li style="display: flex; list-style: 
                                none; padding: 0;">
                    <li class="majorCategory">
<%--                     <c:forEach var="majorCategoryDto" items="noSearch"> --%>
                    <a href="/majorCategoryList?majorCategoryNo=${majorCategoryDto.majorCategoryNo}">
                    ${majorCategoryDto.majorCategoryType}
                    </a>
<%--                     </c:forEach> --%>
                    </li>
 
                    

                </ul>
            </li>
            
            <li>
                <a href="/project/fundinglist" >펀딩 +</a>
            </li>


            <li>
                <a href="${pageContext.request.contextPath}/project/readCountList">Hot펀딩</a>
            </li>


            <li>
                <a href="${pageContext.request.contextPath}/project/likeCountList">추천펀딩</a>
            </li>
            
            <li>
                <a href="${pageContext.request.contextPath}/project/achievementList">인기펀딩</a>
            </li>

            <!-- <li>
                <a href="#">신규</a>
            </li> -->

            <!-- <li>
                <a href="#">마감임박</a>
            </li> -->

            <li>
                <a href="${pageContext.request.contextPath}/mainCommunity/noticeList">커뮤니티</a>
            </li>
            
            <%-- 관리자인 경우 추가 메뉴 출력 --%>
								<c:if test="${sessionScope.level == '관리자'}">
									<li>
									<a class="ms-20" href="${pageContext.request.contextPath}/admin/home">관리자메뉴</a>
									</li>
								</c:if>
        	</ul>
           




				<!-- 조장님이 만든 검색창  -->

		<!-- <div class="backdrop">
        <form action ="/project/list" method="get">
        	<div class="container w-900">
	        	<div class="flex-container">
					<div class="w-100">
		           		<i class="fa-solid fa-magnifying-glass"></i>
		        		<input type="search" class="pointer w-100 focus" name="keyword" placeholder="검색어를 입력해주세요" value="">
					</div>
					
	        			<i class="fa-solid fa-x exit"></i>					

	        	</div>

					<hr>	        	

	        	<div class="row left">
	        		최근검색어
	        		
	        	</div>
	        	<div class="row left">
	        		파도 인기 검색어
	        		
	        	</div>
        	</div>
        </form>
        </div>  -->
		
	        	 
            </a>

        </ul>

        <!-- 줄 연하게하고 그림자살짝 넣고싶음 -->
        <!-- <div style="box-shadow: 0 5 2px 0px red;"> -->
        <hr class="hr1">
        <!-- </div> -->


    </nav>
    
    <section>