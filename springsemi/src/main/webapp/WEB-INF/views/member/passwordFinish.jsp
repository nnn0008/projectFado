<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<div class="container w-600">
        <div class="modal position-center">
            <div class="row alert">
                <div class = "row mt-10 ms-30 me-30">
                    <span style="font-weight: bold;">비밀번호 변경이 완료 되었습니다.</span>
                </div>
                <div class = "row mb-10 mt-30">
                    <a href ="${pageContext.request.contextPath}/" class="btn btn-positive me-10" style="font-size:15px;">파도 메인으로 가기</a>
                </div>
            </div>
        </div>
    </div>
		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>