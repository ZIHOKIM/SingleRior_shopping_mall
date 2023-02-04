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


public class ReportBoard {

	private int reportNo;
	private int contentNo;
	private String reportType;
	private String reportCate;
	private String boardType;
	private String memberId;
	private Date createDate;
	private String boardTitle;
	private String boardContent;
	private String reportStatus;
	
}
