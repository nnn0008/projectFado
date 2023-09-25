package com.kh.springsemi.rest;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Map;

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
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dto.AttachDto;
import com.kh.springsemi.dto.MemberDto;

@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
	
	@Autowired 
	private MemberDao memberDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private FileUploadProperties props;
	
	private File dir;
	
	//모든 로딩이 끝나면 자동으로 실행되는 메소드
	@PostConstruct
	public void init() {
		//처음 한 번만 실행하는 코드
		dir = new File(props.getHome()); //설정을 불러옴
		dir.mkdirs(); //디렉터리 생성
	}
	
	//업로드
	//비동기통신에서는 화면에서 다음 작업이 가능하도록 파일 번호 등을 전달
	@PostMapping("/upload")
	public Map<String, Object> upload(HttpSession session,
											@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		//[1] 파일 시퀀스 번호 생성
		int attachNo = attachDao.sequence();
		
		//[2] 시퀀스 번호를 파일명으로 하여 실제 파일을 저장
		File target = new File(dir, String.valueOf(attachNo)); //저장할 파일
		attach.transferTo(target); //저장
		
		//[3] DB에 저장한 파일의 정보를 모아서 insert
		AttachDto attachDto = new AttachDto();
		attachDto.setAttachNo(attachNo);
		attachDto.setAttachName(attach.getOriginalFilename());
		attachDto.setAttachSize(attach.getSize());
		attachDto.setAttachType(attach.getContentType());
		attachDao.insert(attachDto);
		
		//파일 업로드가 완료되면 아이디와 파일번호를 연결
		String memberId = (String)session.getAttribute("name");
		memberDao.deleteProfile(memberId); //아이디로 기존 이미지 제거
		memberDao.insertProfile(memberId, attachNo); //아이디로 신규 이미지를 추가
		
		//화면에서 사용할 수 있도록 파일번호 또는 다운주소를 반환 
		return Map.of("attachNo", attachNo);
	}
	
	//다운로드
	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource>
										download(@RequestParam int attachNo) throws IOException {
		AttachDto attachDto = attachDao.selectOne(attachNo);
		
		if(attachDto == null) {
			return ResponseEntity.notFound().build(); //404에러 반환
		}
		
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
		
		byte[] data = FileUtils.readFileToByteArray(target); //실제파일정보 불러옴
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
	
	@PostMapping("/delete")
	public void delete(HttpSession session) {
		String memberId = (String)session.getAttribute("name"); //세션으로 아이디 가져오기
		memberDao.deleteProfile(memberId);
	}
	
	//닉네임 중복 체크
	@PostMapping("/nicknameCheck")
	public String nicknameCheck(@RequestParam String memberNickname) {
		MemberDto memberDto = memberDao.selectOneByMemberNickname(memberNickname);
		if(memberDto == null) {
			return "Y";
		}
		else {
			return "N";
		}
	}
	
	//아이디 중복 체크
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) { //아이디가 없으면
			return "Y";
		}
		else { //아이디가 없으면
			return "N";
		}
	}
}
