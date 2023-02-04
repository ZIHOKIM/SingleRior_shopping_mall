package com.E1I4.project.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString

public class LoginLog {

	private String memberId;
	private String loginTime;
	private String dateTime;
	private String loginCheck;
}
