<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="center container w-500">
        <div class="modal position-center">
            <div class="row alert">
                <div class = "row mt-10 ms-30 me-30">
                    <span style="font-weight: bold;">회원정보 변경이 완료 되었습니다.</span>
                </div>
                <div class = "row mb-10">
                    <a href ="${pageContext.request.contextPath}/" class="btn btn-positive" style="font-size:15px;">메인으로 가기</a>
                </div>
            </div>
        </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
