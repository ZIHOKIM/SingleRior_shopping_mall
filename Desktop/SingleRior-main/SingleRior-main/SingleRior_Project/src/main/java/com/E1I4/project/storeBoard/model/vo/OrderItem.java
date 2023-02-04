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
public class OrderItem {
	// view에서 전달 받을 값 , 장바구니NO 받아서 DB에서 가져올 값 맞추기
 private int productNo;
 private String productQty;
 private int productPrice; // 단가
 private int discount;     // 할인율 = 할인가격 다시 구하기 
 private String productOption;
 private String boardTitle;
 private String imgRename;
 private int cartNo;       // 카트번호
 private int boardNo;

 
 
}
  

