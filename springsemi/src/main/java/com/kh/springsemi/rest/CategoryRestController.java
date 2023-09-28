package com.kh.springsemi.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.MajorCategoryDao;
import com.kh.springsemi.dao.MinorCategoryDao;
import com.kh.springsemi.dto.MajorCategoryDto;
import com.kh.springsemi.dto.MinorCategoryDto;

@RestController
@RequestMapping("/rest/category")
public class CategoryRestController {
	@Autowired
	private MajorCategoryDao majorCategoryDao;
	
	@Autowired
	private MinorCategoryDao minorCategoryDao;
	
	@PostMapping("/insert")
	public void insert(@ModelAttribute MajorCategoryDto majorCategoryDto) {
		int majorCategoryNo = majorCategoryDao.sequence();
		majorCategoryDto.setMajorCategoryNo(majorCategoryNo);
		
		majorCategoryDao.insert(majorCategoryDto);
	}
	
	@PostMapping("/majorList")
	public List<MajorCategoryDto> majorList(){
		List<MajorCategoryDto> majorList = majorCategoryDao.selectList();
		return majorList; //화면은 프론트가 해준다
	}
	
	@PostMapping("/minorList")
	public List<MinorCategoryDto> minorList(){
		List<MinorCategoryDto> minorList = minorCategoryDao.selectList();
		return minorList;
	}
	
}
