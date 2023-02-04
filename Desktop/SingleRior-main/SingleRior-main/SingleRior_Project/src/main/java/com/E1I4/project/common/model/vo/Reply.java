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
public class Reply {
	private int replyNo;
	private String replyContent;
	private Date replyCreateDate;
	private Date replyModifyDate;
	private String replySecret;
	private String replyStatus;
	private String memberId;
	private int boardNo;
	private String nickName;
	private String reportStatus;
	private String profileImg;
	private int	groupNo;
//	private String boardTitle;
//	private int boardType;
}
