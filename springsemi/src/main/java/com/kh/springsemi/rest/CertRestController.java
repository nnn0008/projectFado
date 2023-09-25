package com.kh.springsemi.rest;

import java.text.DecimalFormat;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springsemi.dao.CertDao;
import com.kh.springsemi.dto.CertDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/cert")
public class CertRestController {
	
	@Autowired 
	CertDao certDao;
	
	@Autowired
	private JavaMailSender sender;
	
	@PostMapping("/send")
	public void send(@RequestParam String certEmail) {
		Random r = new Random();
		int number = r.nextInt(1000000);
		DecimalFormat fm =  new DecimalFormat("000000");
		String certNumber = fm.format(number);
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(certEmail);
		message.setSubject("[FADO] 인증번호 안내");
		message.setText("인증번호는 [" + certNumber + "] 입니다.");
		sender.send(message); 
		
		certDao.delete(certEmail);
		CertDto certDto = new CertDto();
		certDto.setCertEmail(certEmail);
		certDto.setCertNumber(certNumber);
		certDao.insert(certDto);
	}
	
	@PostMapping("/check")
	public Map<String, Object> check(@ModelAttribute CertDto certDto) {
		CertDto findDto = certDao.selectOneIn5min(certDto.getCertEmail()); 
		if(findDto != null) {
			boolean isValid = findDto.getCertNumber().equals(certDto.getCertNumber());
			if(isValid) {
				certDao.delete(certDto.getCertEmail());
				return Map.of("result", true);
			}
		}
		return Map.of("result", false);
	}
}
