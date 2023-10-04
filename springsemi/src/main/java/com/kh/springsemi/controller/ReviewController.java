package com.kh.springsemi.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springsemi.dao.AttachDao;
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.ReviewDao;
import com.kh.springsemi.dto.AttachDto;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.ReviewDto;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private MemberDao memberDao;
	
	
	
	
	@GetMapping("/write")  //프로젝트 별 후기 글 작성
	public String insert(@RequestParam int projectNo) {
		return "/WEB-INF/views/review/write.jsp";
	}
	
	@PostMapping("/write")
	public String insert(@ModelAttribute ReviewDto reviewDto,
						@ModelAttribute ProjectDto projectDto, HttpSession session,
						@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		
		//프로젝트 번호 따와서 후기 글 쓸 준비 
		String memberId = (String) session.getAttribute("name");
		
		int reviewNo = reviewDao.sequence();
		int projectNo = projectDto.getProjectNo();
		
		reviewDto.setReviewNo(reviewNo);
		reviewDto.setProjectNo(projectNo);
		reviewDto.setReviewWriter(memberId);
		
		reviewDao.insert(reviewDto);
		//첨부파일 등록
		if(!attach.isEmpty()) {
			//첨부파일등록(파일이 있을때만)
			int attachNo = attachDao.sequence();
			
			String home = System.getProperty("user.home");
			File dir = new File(home, "fado");
			dir.mkdirs();
			File target = new File(dir, String.valueOf(attachNo));
			attach.transferTo(target);
			
			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);
			
			//연결(파일이 있을때만)
			reviewDao.connect(reviewNo, attachNo);
		}
		
		return "redirect:/project/detail?projectNo="+projectNo;
	}
	
	
	
	//파일 다운로드
	@ResponseBody
	@RequestMapping("/image")
	public ResponseEntity<ByteArrayResource> image(@RequestParam int reviewNo) throws IOException{
		
		AttachDto attachDto = reviewDao.findReviewPhoto(reviewNo);
		if(attachDto == null) {
			return ResponseEntity.notFound().build();   //404반환
		}
		
		String home = System.getProperty("user.home");
		File dir = new File(home, "fado");
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
		
		byte[] data = FileUtils.readFileToByteArray(target); //실제 파일정보 불러오기
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
						  .header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
						  .contentLength(attachDto.getAttachSize())
						  .header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
						  .header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment()
								  .filename(attachDto.getAttachName(), StandardCharsets.UTF_8)
								  .build().toString())
						  .body(resource);
	}
	
	//상세
	@RequestMapping("/detail")
	public String detail(@RequestParam int reviewNo, Model model) {
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		model.addAttribute("reviewDto", reviewDto);
		
		String reviewWriter = reviewDto.getReviewWriter();
		if(reviewWriter != null) {
			MemberDto memberDto = memberDao.selectOne(reviewWriter);
			model.addAttribute("reviewWriterDto", memberDto);
		}
		return "/WEB-INF/views/review/detail.jsp";
	}

	
//	//목록
//	@RequestMapping("/list")
//	public String list(@ModelAttribute ProjectDto projectDto, Model model,
//						@ModelAttribute ReviewDto reviewDto) {
//		
//		int projectNo = projectDto.getProjectNo();
//		reviewDto.setProjectNo(projectNo);
//		
//		List <ReviewDto> reviewList = reviewDao.selectList(projectNo);
//		model.addAttribute("reviewList", reviewList);
//		
//		return "/WEB-INF/views/review/list.jsp";
//	}
	
	//수정
	@GetMapping("/edit")
	public String edit(@RequestParam int reviewNo, Model model) {
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		
		model.addAttribute("reviewDto", reviewDto);
		return "/WEB-INF/views/review/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute ReviewDto reviewDto,
						@RequestParam MultipartFile attach,
						@ModelAttribute ProjectDto projectDto) throws IllegalStateException, IOException {
		reviewDao.update(reviewDto);
		
		
		int projectNo = projectDto.getProjectNo();
		
		reviewDto.setProjectNo(projectNo);
		
		if(!attach.isEmpty()) { //파일이 있으면
			//파익삭제
			AttachDto attachDto = reviewDao.findReviewPhoto(reviewDto.getReviewNo());
			String home = System.getProperty("user.home");
			File dir = new File(home, "fado");
			
			if(attachDto != null) {
				attachDao.delete(attachDto.getAttachNo());
				File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
				target.delete();
			}
			
			
			//파일 추가 및 연결
			int attachNo = attachDao.sequence();
			
			File insertTarget = new File(dir, String.valueOf(attachNo));
			attach.transferTo(insertTarget);
			
			AttachDto insertDto = new AttachDto();
			insertDto.setAttachNo(attachNo);
			insertDto.setAttachName(attach.getOriginalFilename());
			insertDto.setAttachSize(attach.getSize());
			insertDto.setAttachType(attach.getContentType());
			attachDao.insert(insertDto);
			
			reviewDao.connect(reviewDto.getReviewNo(), attachNo);
		}
		return "redirect:/project/detail?projectNo="+projectNo;
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int reviewNo,
						@ModelAttribute ProjectDto projectDto,
						@ModelAttribute ReviewDto reviewDto) {
		
		int projectNo = projectDto.getProjectNo();
		reviewDto.setProjectNo(projectNo);
		
		
		AttachDto attachDto = reviewDao.findReviewPhoto(reviewNo);
		reviewDao.delete(reviewNo);
		
		if(attachDto != null) {
			
			String home = System.getProperty("user.home");
			File dir = new File(home, "fado");
			File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
			target.delete(); //실제 파일 삭제
		}
		
		attachDao.delete(attachDto.getAttachNo()); //파일정보 삭제
		return "redirect:/project/detail?projectNo="+projectNo;
	}
}