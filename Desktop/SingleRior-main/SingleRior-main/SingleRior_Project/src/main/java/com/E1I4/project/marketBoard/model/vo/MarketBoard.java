package com.E1I4.project.marketBoard.model.vo;

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
public class MarketBoard {
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
	private int likeCount;
	private String marketPrice;
	private int marketType;
	private int marketArray;
	private int	replyCount;
	private String reportStatus;
	private String location;
	private String profileImg;
	private String address;
	private int productNo;
	//boardType 3 market
	//marketType 같이사요 1, 팝니다2, 삽니다3
	//marketArray 최신순1, 좋아요수2, 댓글수3
	
}
