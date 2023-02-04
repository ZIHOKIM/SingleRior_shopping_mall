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
public class ProductInquiry {
	private int inquiryNo;
	private String inquiryTitle;
	private String inquiryContent;
	private Date inquiryDate;
	private int productNo;
	private String memberId;
	private String inquiryStatus;
	private String adminStatus;
	private String inquiryAnswer;
}
