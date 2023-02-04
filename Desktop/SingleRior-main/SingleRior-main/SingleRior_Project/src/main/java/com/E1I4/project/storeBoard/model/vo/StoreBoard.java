package com.E1I4.project.storeBoard.model.vo;

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
public class StoreBoard {
	// boardType:1
	// board에서 content(=상품등록), writer(=관리자) 제외, 
	// product model_name, brand 
	private int boardNo;             // BOARD
	private int boardType;
	private String boardTitle;
	private Date createDate;
	private String boardStatus;
	private String boardWriter;
	private int boardCount;
	private int productNo;            // PRODUCT
	private int price;
	private int discount;
	private String option;
	private String modelName; 
	private String brand;
	private String dPayment;
	private String productStatus;
	private int wishListCount;
	private int subCateCode;            // CATEGORY
	private String subCateName;
	private int topCateCode;
	private String topCateName;
	private int imgNO;                    // IMG_REPOSITORY
	private String imgName;
	private String imgServerName;
	private Date imgCreateDate;
	private String imgStatus;
	private String imgKey;
	private String imgPath;
	private int imgBoardtype;
	private int lmgLevel;
	private double reviewRating;
	private int reviewCount;

}
