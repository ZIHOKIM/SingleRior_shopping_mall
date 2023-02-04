package com.E1I4.project.admin.dto;

import java.util.HashMap;

import lombok.Getter;

@Getter
public class ImportTokenDto {

	private int code;
	private String message;
	private HashMap<String, String> response;
	
	public ImportTokenDto() {}

	public ImportTokenDto(int code, String message, HashMap<String, String> response) {
		super();
		this.code = code;
		this.message = message;
		this.response = response;
	}

	@Override
	public String toString() {
		return "code=" + code + ", message=" + message + ", reponse=" + response;
	}
	
	
	
	
}
