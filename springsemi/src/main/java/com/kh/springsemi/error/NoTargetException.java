package com.kh.springsemi.error;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class NoTargetException extends RuntimeException{
	public NoTargetException(String message) {
		super(message);
	}

}
