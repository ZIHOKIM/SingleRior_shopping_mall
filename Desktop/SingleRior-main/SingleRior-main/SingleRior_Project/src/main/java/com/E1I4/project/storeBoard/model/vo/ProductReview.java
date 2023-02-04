package com.E1I4.project.storeBoard.model.vo;

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

public class ProductReview {

	private int reviewNo;
	private String reviewContent;
	private Date reviewDate;
	private int productNo;
	private double reviewRating;
	private int orderDetailNo;
	private String imgServerName;
	private String productOption;
	private String nickName;

	

}




