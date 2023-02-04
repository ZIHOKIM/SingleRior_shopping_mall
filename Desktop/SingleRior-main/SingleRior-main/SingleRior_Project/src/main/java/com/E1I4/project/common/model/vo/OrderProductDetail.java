package com.E1I4.project.common.model.vo;

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

public class OrderProductDetail {
	
	private int orderNo;
	private Date orderDate;
	private int orderTotalPrice;
	private int orderDetailNo;
	private String productName;
	private int productQuantity;
	private int productPrice;
	private String productOption;
	private String status;
	private String imgServerName;
	private String merId;
	private String impUid;
	
}



