package com.kh.springsemi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.springsemi.dao.MemberDao;
import com.kh.springsemi.dao.PaymentDao;
import com.kh.springsemi.dao.ProjectDao;
import com.kh.springsemi.dto.PaymentCheckDto;
import com.kh.springsemi.dto.ProjectListDto;

//@Slf4j
@Service
public class RegularServiceImpl implements RegularService {
	
	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private ProjectDao projectDao;
	
	@Autowired
	private MemberDao memberDao;

//	@Scheduled(cron = "* * * * * *")// 매 분 마다
//	@Scheduled(cron = "0 0 0 * * *")//매일 자정마다
//	@Override
//	public void finishPayment() {
//		//펀딩 종료 날짜가 지난 결제 자료들을 저장
//		List<PaymentCheckDto> paymentList = paymentDao.selectListOverPaymentDate();
//		//펀딩 리스트를 출력
//		List<ProjectListDto> projectList = projectDao.selectList();
//		System.out.println("paymentList : " + paymentList);
//		System.out.println("projectList : " + projectList.size());
//		for(ProjectListDto projectListDto : projectList) {
//			if(projectListDto.getProjectGoalPrice() >= projectListDto.getProjectTotalPrice()) { //펀딩이 성공했다면
//				for(PaymentCheckDto paymentCheckDto : paymentList) {
//					if(paymentCheckDto.getMemberPoint() >= paymentCheckDto.getOrdersPrice()) { //멤버 보유 포인트 > 실제 리워드 가격
//						memberDao.minusPoint(paymentCheckDto.getOrdersPrice(), paymentCheckDto.getMemberId());
//						paymentDao.successPayment();//회원의 보유포인트를 감소시키자
//						System.out.println(paymentCheckDto.getOrdersNo() + " : 결제완료");
//					}
//					else if(paymentCheckDto.getMemberPoint() < paymentCheckDto.getOrdersPrice()){
//						paymentDao.failPayment();
//						System.out.println(paymentCheckDto.getOrdersNo() + " : 결제실패");
//					}	
//				}
//			}	
//		}
		//펀딩 리스트를 출력
//		List<ProjectListDto> projectList = projectDao.selectList();
//		
//		List<ServiceVO> paymentList = paymentDao.selectListEnoughPointMember(projectList.);
//		for(ServiceVO serviceVO : paymentList) {
//		
//		}
//	}
	
	
	
}