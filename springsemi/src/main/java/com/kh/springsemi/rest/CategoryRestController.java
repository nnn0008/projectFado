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

//@CrossOrigin
@RestController
@RequestMapping("/rest/category")
public class CategoryRestController {
	@Autowired
	private MajorCategoryDao majorCategoryDao;
	
	@Autowired
	private MinorCategoryDao minorCategoryDao;
	
	@PostMapping("/majorList")
	public List<MajorCategoryDto> majorList(){
		List<MajorCategoryDto> majorList = majorCategoryDao.selectList();
		return majorList; //화면은 프론트가 해준다
	}
	
	@PostMapping("/minorList")
	public List<MinorCategoryDto> minorList(@RequestParam String majorCategoryType){
		String replace = majorCategoryType.replaceAll("X", "");
		MajorCategoryDto majorCategoryDto = majorCategoryDao.selectOne(replace);
		//이름 넣어서 DTO 선택
//		MajorCategoryDto majorCategoryDto = majorCategoryDao.selectOne(majorCategoryType);
		//거기서 번호를 추출
		List<MinorCategoryDto> minorList  = minorCategoryDao.selectClassifyByNo(majorCategoryDto.getMajorCategoryNo());
//		Map <Integer, String> minorMap = new TreeMap<>(); 
//		for(MinorCategoryDto minorCategoryDto : minorList) {
//			minorMap.put(minorCategoryDto.getMinorCategoryNo(),minorCategoryDto.getMinorCategoryType()); //Map에 소분류의 번호와 타입
//		}
		return minorList;
	}
	
//	@PostMapping("/minorList")
//	public Map <Integer, String> classifyCheck(@RequestParam String majorCategoryType){
//		String replace = majorCategoryType.replaceAll("X", "");
//		MajorCategoryDto majorCategoryDto = majorCategoryDao.selectOne(replace);
//		List<MinorCategoryDto> list = minorCategoryDao.selectClassifyByNo(majorCategoryDto.getMajorCategoryNo()); // 대분류 번호를 jsp에서 받아서 dto값 넣었음
//		Map <Integer, String> classify = new TreeMap<>(); 
////		Set<Object> set = new TreeSet<>();
////		MajorCategoryDto majorCategoryDto = new MajorCategoryDto();
//		for(MinorCategoryDto minorCategoryDto : list) {
////			set.add(minorCategoryDto.getMinorCategoryNo());
////			set.add(minorCategoryDto.getMinorCategoryType());
//			classify.put(minorCategoryDto.getMinorCategoryNo(),minorCategoryDto.getMinorCategoryType()); //Map에 소분류의 번호와 타입
//		}	
////		return set;
//		return classify;
//	}
	
	//대분류 추가
	//기존 목록의 아래쪽으로 구현
	//등록만 하면 되기 때문에 반환형이 없다
	//관리자는 대분류 타입만 작성(majorCategoryType)
	//번호는 시퀀스로 생성
	@PostMapping("/majorInsert")
	public void majorInsert(@ModelAttribute MajorCategoryDto majorCategoryDto) {
		int majorNo = majorCategoryDao.sequence();
		majorCategoryDto.setMajorCategoryNo(majorNo);
		majorCategoryDao.insert(majorCategoryDto);
		//(대분류)카테고리 개수 업데이트
		majorCategoryDao.updateMajorCategoryCount();
	}
	
	@PostMapping("/minorInsert")
	public void minorInsert(@RequestParam String majorCategoryType, @RequestParam String minorCategoryType, @ModelAttribute MinorCategoryDto minorCategoryDto) {
		//시퀀스로 부여받은 번호 넣기
		int minorNo = minorCategoryDao.sequence();
		minorCategoryDto.setMinorCategoryNo(minorNo);
		//jsp에서 보내준 majorCategoryType을 넣어주고(X)표시가 있다
		String majorReplace = majorCategoryType.replaceAll("X", "");
		//대분류 테이블에서 majorCategoryDto추출
		MajorCategoryDto majorCategoryDto = majorCategoryDao.selectOne(majorReplace);		
		//jsp에서 보내준 minorCategoryType을 minorCategoryType에 세팅
		minorCategoryDto.setMinorCategoryType(minorCategoryType);
		//대분류에서 얻은 번호를 소분류의 번호로 세팅해주고
		minorCategoryDto.setMajorCategoryNo(majorCategoryDto.getMajorCategoryNo());
		minorCategoryDao.insert(minorCategoryDto);
	}
	
	@PostMapping("/majorCheck")
	public String majorCheck(@RequestParam String majorCategoryType) {
		MajorCategoryDto majorCategoryDto = majorCategoryDao.selectOne(majorCategoryType);
		
		if(majorCategoryDto != null) { //이미 있는 카테고리라면
			return "N";	
		}
		else {
			return "Y";
		}
	}
	
	@PostMapping("/minorCheck")
	public String minorCheck(@RequestParam String minorCategoryType) {
		MinorCategoryDto minorCategoryDto = minorCategoryDao.selectOne(minorCategoryType);
		
		if(minorCategoryDto != null) { //이미 있는 카테고리라면
			return "N";	
		}
		else {
			return "Y";
		}
	}
	
	@PostMapping("/majorDelete")
	public void majorDelete(@RequestParam String majorCategoryType) {
//		String replace = majorCategoryType.replaceAll("X", "");
		
		MajorCategoryDto majorCategoryDto = majorCategoryDao.selectOne(majorCategoryType);
		majorCategoryDao.delete(majorCategoryDto.getMajorCategoryNo());
		
		//(대분류)카테고리 개수 업데이트
		majorCategoryDao.updateMajorCategoryCount();
	}
	
	@PostMapping("/minorDelete")
	public void minorDelete(@RequestParam String minorCategoryType) {
//		String replace = minorCategoryType.replaceAll("X", "");
//		System.out.println("replace : " + replace);
		MinorCategoryDto minorCategoryDto = minorCategoryDao.selectOne(minorCategoryType);
//		System.out.println("minorCategoryDto.getMinorCategoryNo() : " + minorCategoryDto.getMinorCategoryNo());
		minorCategoryDao.delete(minorCategoryDto.getMinorCategoryNo());
	}
	
	
	
}
