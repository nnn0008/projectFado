package com.kh.springsemi.interceptor;

import javax.security.sasl.AuthenticationException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.springsemi.dao.ReviewDao;
import com.kh.springsemi.dto.ReviewDto;

@Component
public class ReviewOwnerInterceptor implements HandlerInterceptor{
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, //파라미터(boardNo), 세션 모두 request 를 통해 읽음
							HttpServletResponse response, 
							Object handler)
			throws Exception {
	
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("name");
		
		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		
		if(reviewDto.getReviewWriter().equals(memberId)) {
			return true;
		}
		else {
			throw new AuthenticationException("게시글 소유자가 아닙니다.");
		}
	}
}
