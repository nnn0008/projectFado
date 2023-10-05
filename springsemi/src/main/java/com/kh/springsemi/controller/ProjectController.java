 package com.kh.springsemi.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springsemi.configuration.FileUploadProperties;
import com.kh.springsemi.dao.AttachDao;
import com.kh.springsemi.dao.JudgeDao;
import com.kh.springsemi.dao.MajorCategoryDao;
import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.MinorCategoryDao;
import com.kh.springsemi.dao.ProjectCommunityDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dao.ProjectPhotoDao;
import com.kh.springsemi.dao.ProjectSubPhotoDao;
import com.kh.springsemi.dao.ReviewDao;
import com.kh.springsemi.dao.RewardDao;
import com.kh.springsemi.dto.AttachDto;
import com.kh.springsemi.dto.JudgeDto;
import com.kh.springsemi.dto.MajorCategoryDto;
import com.kh.springsemi.dto.MemberDto;
import com.kh.springsemi.dto.MinorCategoryDto;
import com.kh.springsemi.dto.ProjectCommunityDto;
import com.kh.springsemi.dto.ProjectDto;
import com.kh.springsemi.dto.ProjectListAttachDto;
import com.kh.springsemi.dto.ProjectListDto;
import com.kh.springsemi.dto.ProjectPhotoDto;
import com.kh.springsemi.dto.ProjectSubPhotoDto;
import com.kh.springsemi.dto.ReviewListDto;
import com.kh.springsemi.dto.RewardDto;
import com.kh.springsemi.error.AuthorityException;
import com.kh.springsemi.error.NoTargetException;

@Controller
@RequestMapping("/project")
public class ProjectController {
	
	@Autowired
	private ProjectDao projectDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MajorCategoryDao majorCategoryDao;
	
	@Autowired
	private MinorCategoryDao minorCategoryDao;
	
	@Autowired
	private JudgeDao judgeDao;
	
	@Autowired
	private RewardDao rewardDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private ProjectCommunityDao projectCommunityDao;
	
	@Autowired
	private ProjectPhotoDao projectPhotoDao;
	
	@Autowired
	private ProjectSubPhotoDao projectSubPhotoDao;
	
	//프로젝트 등록
	@GetMapping("/write")
	public String write(Model majorModel, Model minorModel) {
		List<MajorCategoryDto> majorList = majorCategoryDao.selectList();
		majorModel.addAttribute("majorList", majorList);
		List<MinorCategoryDto> minorList = minorCategoryDao.selectList();
		minorModel.addAttribute("minorList", minorList);
		return "/WEB-INF/views/project/write.jsp";
	}
	
	//미리 작성해둔 커스텀 속성을 불러와서 디렉터리 객체까지 생성
	@Autowired
	private FileUploadProperties props;
	
	private File dir;
		
	@PostConstruct //모든 로딩이 끝나면 자동으로 실행되는 메소드
	public void init() {
		dir = new File(props.getHome());
		dir.mkdirs();
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute ProjectDto projectDto, HttpSession session,
			@ModelAttribute JudgeDto judgeDto, @ModelAttribute ProjectPhotoDto projectPhotoDto,
			@ModelAttribute ProjectSubPhotoDto projectSubPhotoDto ,@RequestParam MultipartFile mainAttach,
			@RequestParam MultipartFile subAttach) throws IllegalStateException, IOException {
		int projectNo = projectDao.sequence();
		int judgeNo = judgeDao.sequence();
		
		//첨부파일등록
		int mainAttachNo = attachDao.sequence();
		int subAttachNo = attachDao.sequence();
		projectPhotoDto.setProjectNo(projectNo);
		projectPhotoDto.setAttachNo(mainAttachNo);
		projectSubPhotoDto.setProjectNo(projectNo);
		projectSubPhotoDto.setAttachNo(subAttachNo);
		
		File mainTarget = new File(dir, String.valueOf(mainAttachNo));
		mainAttach.transferTo(mainTarget);
		File subTarget = new File(dir, String.valueOf(subAttachNo));
		subAttach.transferTo(subTarget);
		
		//메인사진 insert
		AttachDto mainAttachDto = new AttachDto();
		mainAttachDto.setAttachNo(mainAttachNo);
		mainAttachDto.setAttachName(mainAttach.getOriginalFilename());
		mainAttachDto.setAttachSize(mainAttach.getSize());
		mainAttachDto.setAttachType(mainAttach.getContentType());
		attachDao.insert(mainAttachDto);
		
		//서브사진 insert
		AttachDto subAttachDto = new AttachDto();
		subAttachDto.setAttachNo(subAttachNo);
		subAttachDto.setAttachName(subAttach.getOriginalFilename());
		subAttachDto.setAttachSize(subAttach.getSize());
		subAttachDto.setAttachType(subAttachDto.getAttachType());
		attachDao.insert(subAttachDto);
		
		//사진 등록 후 프로젝트 등록
		projectDto.setProjectNo(projectNo);
		String memberId = (String)session.getAttribute("name");
		projectDto.setProjectOwner(memberId);
		projectDao.insert(projectDto);	
		
		projectPhotoDao.insert(projectPhotoDto);
		projectSubPhotoDao.insert(projectSubPhotoDto);
		
		judgeDto.setProjectNo(projectNo);
		judgeDto.setJudgeNo(judgeNo);
		judgeDao.insert(judgeDto);
		return "redirect:reward/write?projectNo="+projectNo;
	}
	
//	@GetMapping("/reward/write")
//	public String rewardWrite(@RequestParam int projectNo) {
//		return "/WEB-INF/views/reward/write.jsp";
//	}
//	
//	@PostMapping("/reward/write")
//	public String rewardWrite(@ModelAttribute RewardDto rewardDto, 
//											@RequestParam int projectNo) {
//		return "redirect:detail?projectNo="+projectNo;
//	}
	
	@RequestMapping("/reward/write")
	public String write(@RequestParam int projectNo, Model model) {
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		model.addAttribute("projectDto",projectDto);
		return "/WEB-INF/views/reward/write.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int projectNo, HttpSession session, Model model) {
		JudgeDto judgeDto = judgeDao.selectOneByProjectNo(projectNo);
		String memberLevel = (String)session.getAttribute("level");
		if(memberLevel != null && memberLevel.equals("관리자")) {
			judgeDto.setJudgeStatus("심사진행중");
			judgeDao.update(judgeDto);
		}
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		MinorCategoryDto minorCategoryDto = minorCategoryDao.selectOne(projectDto.getMinorCategoryNo());
		MajorCategoryDto majorCategoryDto = majorCategoryDao.selectOne(minorCategoryDto.getMajorCategoryNo());
		ProjectPhotoDto projectPhotoDto = projectPhotoDao.selectOne(projectNo);
		AttachDto mainAttachDto = attachDao.selectOne(projectPhotoDto.getAttachNo());
		ProjectSubPhotoDto projectSubPhotoDto = projectSubPhotoDao.selectOne(projectNo);
		AttachDto subAttachDto = attachDao.selectOne(projectSubPhotoDto.getAttachNo());
		ProjectListDto projectListDto = projectDao.selectOneByProjectList(projectNo);
		
		model.addAttribute("projectDto", projectDto);
		model.addAttribute("minorCategoryDto", minorCategoryDto);
		model.addAttribute("majorCategoryDto", majorCategoryDto);
		model.addAttribute("mainAttachDto", mainAttachDto);
		model.addAttribute("subAttachDto", subAttachDto);
		model.addAttribute("projectListDto", projectListDto);
		
		List<RewardDto> rewardList = rewardDao.selectListByProjectNo(projectNo);
		model.addAttribute("rewardList", rewardList);
		
		Date currentTime = new Date();
		Date endTime = projectDto.getProjectEndDate();
		long difference = endTime.getTime() - currentTime.getTime();
		model.addAttribute("difference", difference);
		
		String projectOwner = projectDto.getProjectOwner();
		if(projectOwner != null) {
			MemberDto memberDto = memberDao.selectOne(projectOwner);
			model.addAttribute("OwnerDto", memberDto);
		}
		
	
		
		
		
		List<ReviewListDto> reviewList = reviewDao.selectList(projectNo);
		model.addAttribute("reviewList", reviewList);
		
		//이거 지워야돼!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		System.out.println("리뷰 리스트=" + reviewList);
		
		List<ProjectCommunityDto> noticeList = projectCommunityDao.selectNoticeList(projectNo);
		model.addAttribute("noticeList", noticeList);
		
		List<ProjectCommunityDto> qnaList = projectCommunityDao.selectQnAList(projectNo);
		model.addAttribute("qnaList", qnaList);
		
		return "/WEB-INF/views/project/detail.jsp";
	}
	

//	@RequestMapping("/list")
//	public String list(Model model) {
//		List<ProjectListDto> projectList = projectDao.selectList();
//		model.addAttribute("projectList", projectList);;
//		
//		return "/WEB-INF/views/project/list.jsp";
//	}
	
	//목록+검색(keyword의 차이)
	//페이징 관련 처리
	@RequestMapping("/list")
	public String list(Model model, @RequestParam(required = false) String keyword
			,@RequestParam(required = false, defaultValue="1") int page) {
		boolean isSearch = keyword != null;
		
		//페이징과 관련된 값들을 계산하여 JSP로 전달 
		int begin = (page - 1) / 10 * 10 + 1;
		int end = begin + 9;
		int count = isSearch ? projectDao.countList(keyword) : projectDao.countList(); //목록 개수 or 검색 결과 수를 모름
		int pageCount = (count - 1) / 10 * 1 + 1;
		model.addAttribute("page", page);
		model.addAttribute("begin", begin);
		model.addAttribute("end", Math.min(pageCount, end)); //둘 중에 작은 값이 페이지의 마지막이 되어야 한다
		model.addAttribute("pageCount", pageCount);
				
		if(isSearch) { //검색이라면
			//List<ProjectListDto> projectList = projectDao.selectList(keyword);
			List<ProjectListDto> projectList = projectDao.selectListByPage(keyword, page);
			model.addAttribute("projectList", projectList);
			model.addAttribute("isSearch", true);
		}
		else { //목록이라면
//			List<ProjectListDto> projectList = projectDao.selectList();
			List<ProjectListDto> projectList = projectDao.selectListByPage(page);
			model.addAttribute("projectList",projectList);
			model.addAttribute("isSearch", false);
		}
		return "/WEB-INF/views/project/list.jsp";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int projectNo, Model model) {
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		model.addAttribute("projectDto", projectDto);
		return "/WEB-INF/views/project/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute ProjectDto projectDto) {
		if(projectDao.update(projectDto)) {
			return "redirect:detail?projectNo=" + projectDto.getProjectNo();
		}
		else throw new NoTargetException("존재하지 않는 프로젝트 번호");
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int projectNo, HttpSession session) {
		ProjectDto projectDto = projectDao.selectOne(projectNo);
		String memberId = (String) session.getAttribute("name");
		String projectOwner = projectDto.getProjectOwner();
		if(memberId.equals(projectOwner)) {
			projectDao.delete(projectNo);
			return "redirect:list";
		}
		else { 
			throw new AuthorityException("프로젝트 소유자가 아닙니다");
		}
	}
	
//	@RequestMapping("/list2")
//	public String list(@ModelAttribute(name = "vo") PaginationVO vo,
//									Model model) {
//		int count = projectDao.countList(vo);
//		vo.setCount(count);
//		model.addAttribute("vo", vo);
//		
//	List<ProjectDto> list = projectDao.selectListByPage(vo);
//	model.addAttribute("list", list);
//	
//	return "/WEB-INF/views/project/list2.jsp";
//}
//	

	@RequestMapping("/fundinglist")
	public String fundinglist () {
		return "/WEB-INF/views/project/fundinglist.jsp";
	}
	
	
	
}
