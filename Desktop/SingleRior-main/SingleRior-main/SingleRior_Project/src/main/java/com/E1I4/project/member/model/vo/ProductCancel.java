package com.E1I4.project.member.model.vo;

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
public class ProductCancel {
	private int cancelNo;
	private String cancelCate;
	private String cancelReason;
	private Date cancelDate;
	private int orderNo;
	private int orderDetailNo;
}
