package com.kh.springsemi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;


@EnableScheduling
@SpringBootApplication
public class SpringsemiApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringsemiApplication.class, args);
	}

}
