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
    <link rel="stylesheet" type="text/css" href="/css/commons.css">
    <!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->

	<!-- swiper cdn -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />

<style>
        .btn .btn-positive {
            width: 150px;
            height: 150px;
            padding-left: 100px;
            padding-right: 100px;
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
        }
    </style>
    
	<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


    <!-- javascript 작성 공간 -->
    <script>
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
        });
    </script>



</head>

<body>

    <header>
        <div class="logo">
            <a href=""><img src="/images/smallfado.jpg" style="height: 60px;" class="me-50"></a>
        </div>
        <div class="title">

        </div>
        <div class="etc">
            <i class="me-10 fa-solid fa-heart" style="color: #fa7d90;"></i>

            <i class="me-20 fa-solid fa-bell" style="color: #2c8de0;"></i>

            <a href="http://localhost:8080/member/login" class="btn btn-positive" style="padding-left: 60px;
             padding-right: 60px; height:40px; 
             padding-bottom:38px;">
             login
            <!-- <a href="http://localhost:8080/member/login" class="link">login</a> -->    
            </a>
            
        </div>
       
    </header>

    <!-- <hr> -->

    <nav>
        <!-- 애니메이션 추가하고싶음 -->
        <ul class="menu">
            <li>
                <div style="display: flex; align-items:center;">
                    <i class=" fa-solid fa-bars" style="color: #2a0779; 
                    padding-left: 10px;"></i>
                    <a>카테고리</a>
                </div>
                <ul>
                    <li style="display: flex; list-style: 
                                none; padding: 0;">
                    <li><a href="#">전체</a></li>
                    <li><a href="#">의류</a></li>
                    <li><a href="#">향수</a></li>
                    <li><a href="#">반려동물</a></li>
                    <li><a href="#">푸드</a></li>
                    <li><a href="#">푸드</a></li>
                    <li><a href="#">푸드</a></li>
                    <li><a href="#">푸드</a></li>
                    <li><a href="#">푸드</a></li>
                    <li><a href="#">푸드</a></li>
                    <li><a href="#">푸드</a></li>
                    <li><a href="#">푸드</a></li>
                    <li><a href="#">푸드</a></li>

                </ul>
            </li>

            <li>
                <a href="#" class="ms-20">홈</a>

            </li>

            <li>
                <a href="#">인기</a>
            </li>

            <li>
                <a href="#">신규</a>
            </li>

            <li>
                <a href="#">마감임박</a>
            </li>

            <li>
                <a class="ms-20" href="http://localhost:8080/helperCommunity/noticeList">커뮤니티</a>
            </li>
            <!-- 검색창 -->
            
            <a>
            
                <div class="w-300 ms-500" style="width: 300px;">
                    <i class="fa-solid fa-magnifying-glass" style="color: #2c8de0;"></i>
                 <input type="search" class="pointer w-100 focus" name="keyword" placeholder="검색어를 입력해주세요" value="">
                 </div> 


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
