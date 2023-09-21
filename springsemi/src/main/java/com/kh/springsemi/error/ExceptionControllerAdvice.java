package com.kh.springsemi.error;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;


import lombok.extern.slf4j.Slf4j;

@Slf4j
//@ControllerAdvice(annotations = {Controller.class})
public class ExceptionControllerAdvice {
	
	
	@ExceptionHandler(Exception.class)
	public String error(Exception e) {
		log.error("오류", e);
		return "/WEB-INF/views/error/500.jsp";
	}
	
	@ExceptionHandler(NoTargetException.class)
	public String noTarget(NoTargetException e) {
		return "/WEB-INF/views/error/noTarget.jsp";
	}
	
	@ExceptionHandler(AuthorityException.class)
	public String authority(AuthorityException e) {
		e.printStackTrace();
		return "/WEB-INF/views/error/authority.jsp";
	}
}
