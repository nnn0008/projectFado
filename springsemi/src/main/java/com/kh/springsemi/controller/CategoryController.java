package com.kh.springsemi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.springsemi.dao.MajorCategoryDao;
import com.kh.springsemi.dao.MinorCategoryDao;
import com.kh.springsemi.dto.MajorCategoryDto;
import com.kh.springsemi.dto.MinorCategoryDto;

@Controller
@RequestMapping("/admin/category")
public class CategoryController {
	@Autowired
	private MajorCategoryDao majorCategoryDao;
	
	@Autowired
	private MinorCategoryDao minorCategoryDao;
	
	@GetMapping("/list")
	public String write(Model majorModel, Model minorModel) {
		List<MajorCategoryDto> majorList = majorCategoryDao.selectList();
		majorModel.addAttribute("majorList", majorList);
		List<MinorCategoryDto> minorList = minorCategoryDao.selectList();
		minorModel.addAttribute("minorList",minorList);
		return "/WEB-INF/views/admin/category/list.jsp";
	}
	
	@PostMapping("/list")
	public String write(@ModelAttribute MajorCategoryDto majorCategoryDto, @ModelAttribute MinorCategoryDto minorCategoryDto) {
		//소분류의 정보가 필요없을 때(대분류의 정보만 삽입이 필요할 때가 있다)
		if(minorCategoryDto.getMinorCategoryType().equals(null)) { //대분류만 넣고 싶을 때
			int majorCategoryNo = majorCategoryDao.sequence();
			majorCategoryDto.setMajorCategoryNo(majorCategoryNo);
			majorCategoryDao.insert(majorCategoryDto);
		}
		else { //대분류와 소분류를 모두 넣고 싶을 때
			int majorCategoryNo = majorCategoryDao.sequence();
			int minorCategoryNo = minorCategoryDao.sequence();
			majorCategoryDto.setMajorCategoryNo(majorCategoryNo);
			minorCategoryDto.setMajorCategoryNo(majorCategoryNo);
			minorCategoryDto.setMinorCategoryNo(minorCategoryNo);
			majorCategoryDao.insert(majorCategoryDto);
			minorCategoryDao.insert(minorCategoryDto);
		}
		return "/WEB-INF/views/admin/category/list.jsp";
	}
		
		
	
	
}
