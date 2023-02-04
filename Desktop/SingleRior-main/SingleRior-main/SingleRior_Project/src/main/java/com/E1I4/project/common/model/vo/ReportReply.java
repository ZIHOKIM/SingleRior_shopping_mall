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


public class ReportReply {
	
	private int reportNo;
	private String reportType;
	private int contentNo;
	private String reportCate;
	private String boardNo;
	private String boardType;
	private String memberId;
	private Date createDate;
	private String boardTitle;
	private String replyContent ;
	private String reportStatus;
	
}
