package com.kh.springsemi.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
@ConfigurationProperties(prefix = "custom.email")
public class EmailProperties {
	private String host;
	private int port;
	private String username, password;
	

}
