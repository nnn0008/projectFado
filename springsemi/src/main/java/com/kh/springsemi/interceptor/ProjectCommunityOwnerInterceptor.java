package com.kh.springsemi.interceptor;

import javax.security.sasl.AuthenticationException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.springsemi.dao.ProjectCommunityDao;
import com.kh.springsemi.dto.ProjectCommunityDto;

@Component
public class ProjectCommunityOwnerInterceptor implements HandlerInterceptor{
	
	@Autowired
	private ProjectCommunityDao projectCommunityDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, //파라미터(boardNo), 세션 모두 request 를 통해 읽음
							HttpServletResponse response, 
							Object handler)
			throws Exception {
	
		
		//아이디 저장
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("name");
		
		//등급 저장
		HttpSession session2 = request.getSession();
		String memberLevel = (String)session2.getAttribute("level");
		
		
		int projectCommunityNo = Integer.parseInt(request.getParameter("projectCommunityNo"));
		ProjectCommunityDto projectCommunityDto = projectCommunityDao.selectOne(projectCommunityNo);

		
		
		if (projectCommunityDto.getProjectCommunityWriter().equals(memberId)) {
		    // 게시글 소유자인 경우
		    if (!"관리자".equals(memberLevel) && projectCommunityDto.getProjectCommunityType().equals("공지사항")) {
		        // 회원 레벨이 '관리자'가 아니고 게시글이 '공지사항'인 경우
		        throw new AuthenticationException("접근할 권한이 없습니다.");
		    } 
		    else {
		        return true;
		    }
		} 
		else {
		    throw new AuthenticationException("게시글 소유자가 아닙니다.");
			}
		
		
		
	}
}