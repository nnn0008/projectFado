package com.kh.springsemi.interceptor;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.error.NoTargetException;

@Component
public class ProjectDefenderInterceptor implements HandlerInterceptor{
	
	@Autowired
	private ProjectDao projectDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		int projectNo = Integer.parseInt(request.getParameter("projectNo"));
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		if(projectDto == null) {
			throw new NoTargetException("존재하지 않는 프로젝트");
		}
		
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("name");
		
		Set<Integer> history;
		if(session.getAttribute("history") != null) {
			history = (Set<Integer>)session.getAttribute("history");
		}
		else {
			history = new HashSet<>();
		}
		
		System.out.println("history: " + history);
		
		boolean isRead = history.contains(projectNo);
		
	    System.out.println("projectNo: " + projectNo);
	    System.out.println("isRead: " + isRead);
		
	    boolean isOwner = projectDto.getProjectOwner() != null
	    		&& memberId != null && projectDto.getProjectOwner().equals(memberId);
	    
		if(!isOwner && !isRead) {
			history.add(projectNo);
			session.setAttribute("history", history);
			projectDao.updateProjectReadcount(projectNo);
		}
		
	    System.out.println("isOwner: " + isOwner);
	    
		return true;
	}
}
