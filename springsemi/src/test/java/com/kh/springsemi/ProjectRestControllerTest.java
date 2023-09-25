package com.kh.springsemi;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.springsemi.dao.MinorCategoryDao;
import com.kh.springsemi.dto.MajorCategoryDto;
import com.kh.springsemi.dto.MinorCategoryDto;
import com.kh.springsemi.rest.ProjectRestController;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class ProjectRestControllerTest {

	
	@Autowired
	private MinorCategoryDao minorCategoryDao;
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectRestController.class);
	
//	@RequestMapping("/classifyCheck")
	@Test
	public void classifyCheck(){
		int majorCategoryNo = 1;
		Map <Integer, String> classify = new TreeMap<>(); //Map을 만들어서 minorCategoryNo(key) 와 majorCategoryNo(value)를 저장
		List<MinorCategoryDto> list = minorCategoryDao.selectClassifyByNo(majorCategoryNo); // 여기서 어떻게 넣는거지? 
		MajorCategoryDto majorCategoryDto = new MajorCategoryDto();
//		Set<Integer> set = new TreeSet<>();
//		set = (Set<Integer>) list.stream().map(MinorCategoryDto :: getMinorCategoryNo);
//		MinorCategoryDto minorCategoryDto = new MinorCategoryDto();
		for(MinorCategoryDto minorCategoryDto : list) {
//			if(minorCategoryDto.getMajorCategoryNo() == majorCategoryDto.getMajorCategoryNo()) {
			classify.put(minorCategoryDto.getMinorCategoryNo(),minorCategoryDto.getMinorCategoryType());
//			}
//			set.add(minorCategoryDto.getMinorCategoryNo());
//			set.add(minorCategoryDto.getMinorCategoryType());
		}
		
		logger.debug("list = {}", list);
//		logger.debug("set = {}", set);
		logger.debug("classify = {}", classify);
//		return list;
	}
}
