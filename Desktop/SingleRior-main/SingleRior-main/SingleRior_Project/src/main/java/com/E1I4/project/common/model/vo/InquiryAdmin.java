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

public class InquiryAdmin {
	
	private int inquiryNo;
	private int boardNo;
	private String proTopCateName;
	private String proSubCateName;
	private String boardTitle;
	private int productNo;
	private String inquiryContent;
	private String memberId;
	private Date inquiryDate;
	private String inquiryStatus;
	private String adminStatus;
	private String inquiryAnswer;
	
}
