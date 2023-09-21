package com.kh.springsemi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class TestInterceptor implements HandlerInterceptor {
/*
 *		컨트롤러가 실행되기 직전 시점을 간섭하는 메소드 
 * 		- true를 반환 하면 요청에 대한 작업을 진행하겠다 
 * 		- false를 반환 하면 요청에 대한 작업을 차단하겠다
 * 		- handler에는 이 요청을 처리할 대상 컨트롤러/메소드 정보가 있다  
 * */	
	
		@Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
				throws Exception {
		System.out.println("postHandle 실행 ");
			return  true;
		}
		
		/**
		 * postHandle은 컨트롤러 처리 후 화면 생성 전 시점을 간섭하는 메소드
		 * - 유일하게 Model의 정보와 들어있는 데이터를 확인할 수 있다.
		 * - 검사, 모니터링, 치환 등의 작업을 할 수 있다
		 */
		
		@Override
		public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
			System.out.println("postHandle 실행 ");
		
		}
 
		/**
		 * afterCompletion은 화면 생성 후 (모든 처리가 끝난 후) 시점을 간섭하는 메소드
		 * -  유일하게 예외의 발생 여부를 알 수 있는 곳
		 * - 발생한 예외에 따라 처리할 내용들을 이곳에 작성할 수 있다.
		 * - 사용자가 볼 페이지를 변경할 수는 없다(모니터링, 로깅-기록을 남기는 행위, ...)
		 */
		
		
		@Override
		public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
			System.out.println("afterCompletion 실");
			System.out.println(ex);
		}

}
