package com.kh.springsemi.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.springsemi.interceptor.AdminInterceptor;
import com.kh.springsemi.interceptor.MainCommunityOwnerInterceptor;
import com.kh.springsemi.interceptor.MemberInterceptor;
import com.kh.springsemi.interceptor.ProjectCommunityOwnerInterceptor;
import com.kh.springsemi.interceptor.ProjectDefenderInterceptor;
import com.kh.springsemi.interceptor.ProjectOwnerInterceptor;
import com.kh.springsemi.interceptor.ReviewOwnerInterceptor;
import com.kh.springsemi.interceptor.TestInterceptor;

@Configuration//등록 
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
	
	@Autowired
	private MainCommunityOwnerInterceptor mainCommunityOwnerInterceptor;
	
	@Autowired
	private ProjectCommunityOwnerInterceptor projectCommunityOwnerInterceptor;
	
	@Autowired
	private ReviewOwnerInterceptor reviewOwnerInterceptor;
	
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		//admin
		registry.addInterceptor(adminInterceptor)
				.addPathPatterns(
						"/admin/**",
						"/rest/category/**"
						);
		
		
		//mainCommunity 글 소유자 외 접근차단
		registry.addInterceptor(mainCommunityOwnerInterceptor)
				.addPathPatterns(
						"/mainCommunity/edit",
						"/mainCommunity/delete"
						);
		
		
		//projectCommunity 글 소유자 외 접근차단
		registry.addInterceptor(projectCommunityOwnerInterceptor)
				.addPathPatterns(
						"/projectCommunity/edit",
						"/projectCommunity/delete"
						);
		
		
		//review 글 소유자 외 접근 차단
		registry.addInterceptor(reviewOwnerInterceptor)
				.addPathPatterns(
						"/review/edit",
						"/review/delete"
						);
		
		//project 글 소유자 외 접근 차단
		registry.addInterceptor(projectOwnerInterceptor)
				.addPathPatterns(
						"/project/edit",
						"/project/delete"
						);
		
		
		//게시글 조회수 중복방지
		registry.addInterceptor(projectDefenderInterceptor)
				.addPathPatterns(
						"/project/detail"
						);
		
		
		//member 로그인 or 비로그인 시 
		registry.addInterceptor(memberInterceptor)
				.addPathPatterns(
						"/member/**",
						"/mainCommunity/write",
						"/projectCommunity/write",
						"/rest/mainReply/**",
						"/rest/projectReply/**",
						"/review/write",
						"/project/write",
						"/project/reward/write",
						"/delivery/**",
						"/orders/**",
						"/payment/**",
						"/rest/category"
						)
				.excludePathPatterns(
						"/member/join",
						"/member/joinFinish",
						"/member/login",
						"/member/logout",
						"/member/exit/",
						"/member/findPw",
						"/member/findPwFinish",
						"/rest/mainReply/list",
						"/rest/projectReply/list"
						);
							
	}
}

