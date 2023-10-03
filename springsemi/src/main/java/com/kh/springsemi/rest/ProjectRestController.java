package com.kh.springsemi.rest;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springsemi.configuration.FileUploadProperties;
import com.kh.springsemi.dao.AttachDao;
import com.kh.springsemi.dao.MajorCategoryDao;
import com.kh.springsemi.dao.MinorCategoryDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dto.AttachDto;
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
	
	//비동기통신에 대한 사진 업로드
	@Autowired
	private AttachDao attachDao;
	
	//미리 작성해둔 커스텀 속성을 불러와서 디렉터리 객체까지 생성
	@Autowired
	private FileUploadProperties props;
	
	private File dir;
	
	@PostConstruct //모든 로딩이 끝나면 자동으로 실행되는 메소드
	public void init() {
		dir = new File(props.getHome());
		dir.mkdirs();
	}
	
	//업로드는 무조건 PostMapping
	//비동기통신에서는 화면에서 작업이 가능하도록 파일번호 등을 전달
	@PostMapping("/upload")
	public Map<String, Object> upload(@RequestParam MultipartFile attach,
			HttpSession session) throws IllegalStateException, IOException {
		//절대규칙 - 파일은 하드디스크에, 정보는 DB에!
		
		//[1] 시퀀스 번호를 생성한다
		int attachNo = attachDao.sequence();
		
		//[2] 시퀀스 번호를 파일명으로 하여 실제 파일을 저장한다
		//- 같은 이름에 대한 충돌을 방지하기 위해		
		File target = new File(dir, String.valueOf(attachNo));//저장할파일
		attach.transferTo(target);//저장
		
		//[3] DB에 저장한 파일의 정보를 모아서 INSERT
		AttachDto attachDto = new AttachDto();
		attachDto.setAttachNo(attachNo);
		attachDto.setAttachName(attach.getOriginalFilename());
		attachDto.setAttachSize(attach.getSize());
		attachDto.setAttachType(attach.getContentType());
		attachDao.insert(attachDto);
		
		//파일 업로드가 완료되면 프로젝트와 파일번호를 연결
//		int projectNo = projectDao.sequence();
//		projectDao.insertPhoto(projectNo, attachNo);//신규 이미지를 추가
				
		//화면에서 사용할 수 있도록 파일번호 또는 다운주소를 반환
		//return 객체 or Map;
		return Map.of("attachNo", attachNo);
	}
	//다운로드는 비동기/동기가 같다(파일번호만 필요)
	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource> download(@RequestParam int attachNo) throws IOException{
		AttachDto attachDto = attachDao.selectOne(attachNo);
		
		if(attachDto == null) {
			//throw new NoTargetException("파일 없음");//내가만든 예외로 통합
			return ResponseEntity.notFound().build();//404 반환
		}
		
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
		
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize())
				.header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
				.header(HttpHeaders.CONTENT_DISPOSITION, 
					ContentDisposition.attachment()
					.filename(attachDto.getAttachName(), StandardCharsets.UTF_8)
					.build().toString()
				)
			.body(resource);
	}
	
//	@PostMapping("/getNickname")
//	public String getNickname(@RequestParam int projectNo) {
//		
//	}
	
	
	
	
	
}
