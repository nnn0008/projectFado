package com.kh.springsemi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.springsemi.error.AuthorityException;

//회원인지 아닌지 검사하여 비회원을 차단하는 인터셉터 구현
// - 세션에 name 이라는 이름의 값이 있으면 회원, 없으면 비회원

@Component
public class MemberInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
			HttpSession session = request.getSession();
			
			String memberId = (String) session.getAttribute("name");
			boolean isLogin = memberId != null;
			
			if(isLogin) { //회원이면 
				return true;
			}
			else {
				throw new AuthorityException("로그인 후 이용해주세요");
			}
		
		
	}

	
	
}
