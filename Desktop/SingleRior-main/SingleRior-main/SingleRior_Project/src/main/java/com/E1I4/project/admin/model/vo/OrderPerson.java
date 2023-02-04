package com.E1I4.project.admin.model.vo;

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

public class OrderPerson {
	private String memberId;
	private String recipient;
	private String reciAddress;
	private String reciPhone;
	private String deliveryMsg;
	private String memberName;
	private String phone;
	private String email;
}
