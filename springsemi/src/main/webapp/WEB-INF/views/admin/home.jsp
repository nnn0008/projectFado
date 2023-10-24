<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    <div class="container row">
    <h3>관리자페이지 </h3>
    
    
    <h4><a href="/admin/member/list">회원관리</a></h4>
    <h4><a href="/admin/project/list">프로젝트관리</a></h4>
    <h4><a href="/admin/category/list">카테고리관리</a></h4>
    </div>
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>