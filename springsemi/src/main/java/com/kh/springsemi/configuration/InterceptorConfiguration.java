package com.kh.springsemi.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.springsemi.interceptor.AdminInterceptor;
import com.kh.springsemi.interceptor.MemberInterceptor;
import com.kh.springsemi.interceptor.ProjectDefenderInterceptor;
import com.kh.springsemi.interceptor.ProjectOwnerInterceptor;
import com.kh.springsemi.interceptor.TestInterceptor;

/**
스프링에서 제공하는 설정파일
- application.properties에서 설정할 수 없는 내용들을 설정하는 파일

//만드는 법
//1. 등록(@Configuration)
//2. 필요 시 상속(WebMvcConfigurer)
//3. 상황에 맞는 메소드 재정의 및 코드 작성
//*/
//
//@Configuration//등록 
public class InterceptorConfiguration implements WebMvcConfigurer {
	
	@Autowired
	private AdminInterceptor adminInterceptor;
	
	@Autowired
	private TestInterceptor testInterceptor;
	
	@Autowired
	private MemberInterceptor memberInterceptor;
	
	@Autowired
	private ProjectDefenderInterceptor projectDefenderInterceptor;
	
	@Autowired
	private ProjectOwnerInterceptor projectOwnerInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(memberInterceptor)
				.addPathPatterns(
						"/member/**",
						"/project/**"
						)
//				제외시킬 주소(비회원) 
				.excludePathPatterns(
						  "/member/join*",
						  "/member/login*",
						"/project/list/like*",
						"/project/list/lank*",
						"/project/list/category*",
						"/project/list/period*",
						"/project/list/detail*",
						"/project/list/Community/QnA*",
						"/project/list/Community/notice*",
						"/project/list/Community/review"
						
						 );
		
		registry.addInterceptor(projectDefenderInterceptor)
		.addPathPatterns("/project/detail");

		registry.addInterceptor(projectOwnerInterceptor)
		.addPathPatterns("/project/edit", "/project/delete");
//	@Override
//	public void addInterceptors(InterceptorRegistry registry) {
//		
//		registry.addInterceptor(memberInterceptor)
//				.addPathPatterns(
//						"/member/**",
//						"/project/**"
//						)
////				제외시킬 주소(비회원) 
//				.excludePathPatterns(
//						  "/member/join*",
//						  "/member/login*",
//						"/project/list/like*",
//						"/project/list/lank*",
//						"/project/list/category*",
//						"/project/list/period*",
//						"/project/list/detail*",
//						"/project/list/Community/QnA*",
//						"/project/list/Community/notice*",
//						"/project/list/Community/review"
//						
//						 );
	
				
		
		
		
		
//	registry.addInterceptor(adminInterceptor)
//			.addPathPatterns(
//					"/admin/**"
//					)
//			.excludePathPatterns(
//					"/admin/member/list*"
//					);
			
		
		
			
	}
}

