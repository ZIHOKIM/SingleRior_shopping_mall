package com.E1I4.project.mainPage.model.vo;

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
public class MainPage {
	private int boardNo;            // BOARD
	private int boardType;
	private String boardTitle;
	private String boardContent;
	private Date createDate;
	private Date modifyDate;
	private String status;
	private String writer;
	private String nickName;
	private int symptCount;
	private int likeCount;
	private String marketPrice;
	private int commuType;
	private int marketType;
	private int replyCount;
	
	private int productNo;            // PRODUCT
	private int price;
	private int discount;
	private String brand;
	private String productStatus;
	private int subCateCode;            // CATEGORY
	private String subCateName;
	private String topCateName;
}
