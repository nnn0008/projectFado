<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	

	 <div class="container w-800">
            <div class="row">
                <!-- Slider main container -->
                <div class="swiper">
                    <!-- Additional required wrapper -->
                    <div class="swiper-wrapper">
                        <!-- Slides -->
                        <div class="swiper-slide">
                            <img src="https://picsum.photos/id/101/600/300" width="200% " height="200%">
                        </div>
                        <div class="swiper-slide">
                            <img src="https://picsum.photos/id/101/600/300" width="100%" height="100%">
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

        <div class="container-project">

            <!-- <div class="item"> -->

           <div class="item item1">
            <img src="https://picsum.photos/id/101/600/300" width="100%" height="100%">
            </div>
            
            <div class="item item2">
                <!-- <img src="./image/noshowoff.jpg" width="100%" height="100%"> -->
                </div>

            <div class="item item3">
                <!-- <img src="./image/noshowoff.jpg" width="100%" height="100%"> -->
            </div>

        <!-- </div> -->
        </div>
    </section>
	

	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
