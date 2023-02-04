package com.E1I4.project.common.model.vo;

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
public class Cart {
	private int cartNo;
	private int quantity;
	private String payStatus;
	private String memberId;
	private int productNo;
	private String productOption;
	private String productOptions;
	private double productPrice;
	private double productDiscount;
	private int lastPrice;
	private String brand;
	private String imgRename;
	private String boardTitle;
	private int boardNo;
}
