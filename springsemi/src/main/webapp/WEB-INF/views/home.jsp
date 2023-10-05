<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>

	

</script>
	<style>
	 ul,li{
            list-style: none;
        }

        a{
            text-decoration: none;
            color: inherit;
        }

        .list_wrap{
            /* 가로길이 고정 */
            width: 90%;
            /* 최소 가로길이 */
            min-width: 1000px;
            /* 최대 가로길이 */
            max-width: 1200px;
            /* 가운데 정렬 */
            margin: 0 auto;
            padding: 40px;
            margin-top: 15%;
        }

        .list_wrap ul{
            font-size: 0;
        }

        .list_wrap .item {
            width: 20%;
            display: inline-block;
            margin-left: 2%;
            margin-right: 2%;
            margin-top: 2%;
            margin-bottom: 2%;
            box-shadow: 0px 0px 4px rgba(0, 0, 0, 0.5);
        }

        .list_wrap .item .image{
            width: 100%;
            height: 150px;
/*             background: url(./image/noshowoff.jpg); */
            background-repeat: no-repeat;
            background-position: 50% 50%;
            background-size: cover;
        }

        .list_wrap .item .cont{
            padding: 4px;
        }

        .list_wrap .item strong {
            /* 이게 있어야 마진이 적용됨 */
            display: block;
            /* 이미지랑 제목, 내용 간격띄우기 */
            margin: 8px 0 5px 0;
            font-size: 16px;
            /* 글자간격줄이기 */
            letter-spacing: -1px;
        }

        .list_wrap .item p{
            font-size: 12px;
            letter-spacing: -1px;
        }

        .list_wrap .item a{
            /* p태그랑 겹치지 않게하기위함 */
            display: inline-block;
            /* 상하좌우 여백 */
            padding: 3px 6px;
            /* background: #2c8ce09e; */
            border: 1px solid #2c8ce09e;
            font-size: 12px;
            letter-spacing: -1px;
            margin-top: 5px;
            /* transition: ; */
            
        }

        .list_wrap .item a:hover{
            background: #dddddd32;
            color: #2c8ce053;
            
        }
        </style>

	 <div class="container w-600" >
            <div class="row">
                <!-- Slider main container -->
                <div class="swiper">
                    <!-- Additional required wrapper -->
                    <div class="swiper-wrapper">
                        <!-- Slides -->
                        <div class="swiper-slide">
                            <img src="/images/fado1.jpg" width="100% " height="60%">
                        </div>
                        <div class="swiper-slide">
                            <img src="/images/fado2.jpg" width="100%" height="100%">
                        </div>                      
                    </div>
                    <!-- If we need pagination -->
                    <div class="swiper-pagination"></div>
                    <!-- If we need navigation buttons -->
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                    <!-- If we need scrollbar -->
                    <!-- <div class="swiper-scrollbar"></div> -->
                    
                </div>
            </div>
            
        </div>

		
            <!-- 펀딩목록 -->

       <!--  <div class="container-project">

            <div class="item">

           <div class="item item1">
            <img src="https://picsum.photos/id/101/600/300" width="100%" height="100%">
            </div>
            
            <div class="item item2">
                  <img src="./image/noshowoff.jpg" width="100%" height="100%">
                </div>

            <div class="item item3">
                 <img src="./image/noshowoff.jpg" width="100%" height="100%">
            </div>

        </div>
        </div> -->

<!--                     <li class="item"> -->
        
<!--                         <div class="image"> -->
                            
<!--                         </div>     				 -->
        				
<!--                         <div class="cont"> -->
<!--                             <strong>제목</strong> -->
<!--                             <p>내용</p> -->
<!--                             <a href="#">바로가기</a> -->
<!--                         </div> -->
        
<!--                     </li> -->
				



					<c:forEach var="projectListAttachDto" items="${readCountList}" end="7">
	                    <li class="item">
	                    <a href="/project/detail?projectNo=${projectListAttachDto.projectNo}">
	                        <div class="image">
								<img src="/rest/project/download?attachNo=${projectListAttachDto.attachNo}">
							</div>
	                        <div class="cont">
	                        	<p>${projectListAttachDto.majorCategoryType} | ${projectListAttachDto.minorCategoryType }</p>
	                            <strong>${projectListAttachDto.projectTitle}</strong>
	                            <p><fmt:formatNumber value="${projectListAttachDto.achievementRate * 100}" pattern="0.#"/>% 달성</p>
<!-- 	                            <a href="#">바로가기</a> --></a>
	                        </div>                
	                    </li>
					</c:forEach>
          


					<c:forEach var="projectListAttachDto" items="${likeCountList}" end="7">
	                    <li class="item">
	                    <a href="/project/detail?projectNo=${projectListAttachDto.projectNo}">
	                        <div class="image">
								<img src="/rest/project/download?attachNo=${projectListAttachDto.attachNo}">
							</div>
	                        <div class="cont">
	                        	<p>${projectListAttachDto.majorCategoryType} | ${projectListAttachDto.minorCategoryType }</p>
	                            <strong>${projectListAttachDto.projectTitle}</strong>
	                            <p><fmt:formatNumber value="${projectListAttachDto.achievementRate * 100}" pattern="0.#"/>% 달성</p>
<!-- 	                            <a href="#">바로가기</a> --></a>
	                        </div>                
	                    </li>
					</c:forEach>
				



                <c:forEach var="projectListAttachDto" items="${achievementList}" end="7">
                    <li class="item">
                    	<a href="/project/detail?projectNo=${projectListAttachDto.projectNo}">
                        <div class="image">
							<img src="/rest/project/download?attachNo=${projectListAttachDto.attachNo}">
						</div>
                        <div class="cont">
                        	<p>${projectListAttachDto.majorCategoryType} | ${projectListAttachDto.minorCategoryType }</p>
                            <strong>${projectListAttachDto.projectTitle}</strong>
                            <p><fmt:formatNumber value="${projectListAttachDto.achievementRate * 100}" pattern="0.#"/>% 달성</p>
<!-- 	                            <a href="#">바로가기</a> --></a>
                        </div>                
                    </li>
				</c:forEach>    
                    
                </ul>
            </div>

					<c:forEach var="ProjectListAttachDto" items="${readCountList}" end="7">
						<div class="row">
							<a href="/project/detail?projectNo=${ProjectListAttachDto.projectNo}">
							
							
								<div class="row"> <!-- 상품 하나  -->
									 <div class="image">
										<img src="/rest/project/download?attachNo=${ProjectListAttachDto.attachNo}">
									</div>
										
										<div class="row">
											<p>${ProjectListAttachDto.majorCategoryType} | ${ProjectListAttachDto.minorCategoryType }</p>
											<strong>${ProjectListAttachDto.projectTitle}</strong>
											
											<div class='flex-container auto-width'>
												<p><fmt:formatNumber value="${ProjectListAttachDto.achievementRate * 100}" pattern="0.#"/>% 달성</p>
												<p>n일 남음</p>
											</div>
										</div>
									
								</div>
							
							
							</a>
						</div>
					</c:forEach>
	                	


    </section>
	

	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>