package com.E1I4.project.admin.model.vo;

import java.sql.Date;

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

public class OrderProducts {

	private int orderNo;
	private String products;
	private String orderTotalPrice;
	private String recipient;
	private String reciAddress;
	private String memberId;
	private String reciPhone;
	private Date orderDate;
	private String orderTotalStatus;
	
	
	
}
