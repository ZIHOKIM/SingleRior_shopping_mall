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
public class Review {
	private int reviewNo;
	private String reviewContent;
	private Date reviewDate;
	private int productNo;
	private String memberId;
	private int boardNo;
	private int orderNo;
	private int orderDetailNo;
	private String imgRename;
	private String productName;
	private int productQuantity;
	private String productOption;
	private double reviewRating;
}
