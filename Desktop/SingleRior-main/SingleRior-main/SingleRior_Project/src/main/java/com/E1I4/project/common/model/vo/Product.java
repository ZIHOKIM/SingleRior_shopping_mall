package com.E1I4.project.common.model.vo;

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

public class Product {

	private int boardNo;
	private int boardType;
	private String productName;
	private String productContent; //상품등록으로 일괄 입력
	private Date createDate;
	private Date modifyDate;
	private String noticeStatus;
	private String boardStatus;
	private String boardWriter;
	private int boardCount;
	private String reportStatus;
	private int productNo;
	private int productPrice;
	private int productDiscount;
	private String productOption;
	private String modelName;
	private String brand;
	private String deliveryPayment;
	private String productStatus;
	private int proSubCateCode;
	
	
}
