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
public class Message {
	private int messageNo;
	private Date msgCreateDate;
	private String messageTitle;
	private String messageContent;
	private String messageCheck;
	private String receiveStatus;
	private String sendStatus;
	private String sender;
	private String receiver;
	
}
