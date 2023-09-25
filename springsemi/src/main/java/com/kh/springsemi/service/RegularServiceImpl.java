package com.kh.springsemi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.springsemi.dao.CertDao;

//@Slf4j
@Service
public class RegularServiceImpl implements RegularService {
	
	@Autowired
	private CertDao certDao;

	@Scheduled(cron = "0 0 * * * *")//매 시 정각마다
	
	@Override
	public void clearCert() {
		certDao.deleteOver5min();
	}
}
