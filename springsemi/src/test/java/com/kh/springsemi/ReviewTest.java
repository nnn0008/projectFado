package com.kh.springsemi;

import static org.junit.jupiter.api.Assertions.assertNotEquals;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.springsemi.dao.ReviewDao;
import com.kh.springsemi.dto.ReviewDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class ReviewTest {
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Test
	public void test() {
		List<ReviewDto> list = reviewDao.selectList(163);
		log.debug("size = {}", list.size());
		assertNotEquals(0, list.size());
	}
	
}
