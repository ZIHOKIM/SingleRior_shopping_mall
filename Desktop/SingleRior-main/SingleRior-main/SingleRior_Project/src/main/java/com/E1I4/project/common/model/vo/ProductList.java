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

public class ProductList {
	
	private int boardNo;
	private int  boardType;
	private String boardTitle;
	private Date createDate;
	private Date modifyDate;
	private String boardStatus;
	private String boardWriter;
	private int boardCount;
	private int productNo;
	private int productPrice;
	private String discount;
	private String option;
	private String modelName;
	private String brand;
	private String productStatus;
	private int subCateCode;
	private String subCateName;
	private int topCateCode;
	private String topCateName;
}
