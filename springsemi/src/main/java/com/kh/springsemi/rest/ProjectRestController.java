package com.kh.springsemi.rest;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.MajorCategoryDao;
import com.kh.springsemi.dao.MinorCategoryDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dto.MajorCategoryDto;
import com.kh.springsemi.dto.MinorCategoryDto;

@RestController
@RequestMapping("/rest/project")
public class ProjectRestController {
	
	@Autowired
	private ProjectDao projectDao;
	
	@Autowired
	private MajorCategoryDao majorCategoryDao;
	
	@Autowired
	private MinorCategoryDao minorCategoryDao;

	@PostMapping("/classifyCheck")
	public Map <Integer, String> classifyCheck(@RequestParam int majorCategoryNo){
		List<MinorCategoryDto> list = minorCategoryDao.selectClassifyByNo(majorCategoryNo); // 대분류 번호를 jsp에서 받아서 dto값 넣었음
		Map <Integer, String> classify = new TreeMap<>(); 
//		Set<Object> set = new TreeSet<>();
//		MajorCategoryDto majorCategoryDto = new MajorCategoryDto();
		for(MinorCategoryDto minorCategoryDto : list) {
//			set.add(minorCategoryDto.getMinorCategoryNo());
//			set.add(minorCategoryDto.getMinorCategoryType());
			classify.put(minorCategoryDto.getMinorCategoryNo(),minorCategoryDto.getMinorCategoryType()); //Map에 소분류의 번호와 타입
		}	
//		return set;
		return classify;
	}
}
