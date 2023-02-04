package com.E1I4.project.storeBoard.model.vo;

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
public class OrderDetail {
	private int productNo;
	private int quantity;
	private int productPrice;
	private int lastPrice;
	private int discount;
	private String productOption;

}
