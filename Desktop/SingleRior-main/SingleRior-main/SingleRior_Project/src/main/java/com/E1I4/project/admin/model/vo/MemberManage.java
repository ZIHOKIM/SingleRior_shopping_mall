package com.E1I4.project.admin.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.Setter;
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class MemberManage {
	private String memberId;
	private String memberPwd;
	private String memberName;
	private String nickName;
	private String phone;
	private String email;
	private String address;
	private Date enrollDate;
	private Date modifyDate;
	private String memberStatus;
	private String memberAuthority;
	private String memberLog;
}
