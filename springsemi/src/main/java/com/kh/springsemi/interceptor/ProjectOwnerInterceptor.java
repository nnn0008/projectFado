package com.kh.springsemi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.error.AuthorityException;

@Component
public class ProjectOwnerInterceptor implements HandlerInterceptor{
	
	@Autowired
	private ProjectDao projectDao;
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("name");
		
		int projectNo = Integer.parseInt(request.getParameter("projectNo"));
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		
		if(projectDto.getProjectOwner().equals(memberId)) {
			return true;
		}
		else {
			throw new AuthorityException("프로젝트 소유자가 아닙니다");
		}
	}
	
}
