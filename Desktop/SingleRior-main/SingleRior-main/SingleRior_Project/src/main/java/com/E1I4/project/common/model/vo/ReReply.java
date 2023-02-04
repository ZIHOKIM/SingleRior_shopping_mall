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
public class ReReply {
	private int reReplyNo;
	private int replyNo;
	private String reReplyContent;
	private Date reReplyCreateDate;
	private Date reReplyModifyDate;
	private String memberId;
	private int boardNo;
	private String reReplyStatus;
	private String reReplySecret;
	private String nickName;
	private String reportStatus;
}
