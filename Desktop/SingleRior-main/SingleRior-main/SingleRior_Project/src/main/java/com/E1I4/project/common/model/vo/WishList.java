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
public class WishList {
	private int boardNo;
	private String memberId;
	private int boardType;
	private String boardTitle;
	private String imgRename;
	private int productNo;
	private int productPrice;
	private int tProductNo;
}
