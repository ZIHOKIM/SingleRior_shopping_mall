package com.E1I4.project.commuBoard.model.vo;

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
public class CommuBoard {
	private int boardNo;
	private int boardType;
	private String boardTitle;
	private String boardContent;
	private Date createDate;
	private Date modifyDate;
	private String noticeStatus;
	private String status;
	private String writer;
	private String nickName;
	private int count;
	private int symptCount;
	private int commuType;
	private int commuArray;
	private int replyCount;
	private String reportStatus;
	private String profileImg;
}
