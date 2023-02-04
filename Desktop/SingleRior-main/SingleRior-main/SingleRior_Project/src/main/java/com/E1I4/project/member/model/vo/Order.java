package com.E1I4.project.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Order {
	private int orderNo;
	private int boardNo;
	private int productNo;
	private String memberId;
	private String boardTitle;
	private int salePrice;
	private String recipient;
	private Date orderDate;
	private int productQuantity;
	private String status;
	private String productOption;
	private String imgRename;
	 private String reciAddress;
	 private String reciPhone;
	 private int orderTotalPrice;
	 private int orderDetailNo;
	 private String deliveryMsg;
}
