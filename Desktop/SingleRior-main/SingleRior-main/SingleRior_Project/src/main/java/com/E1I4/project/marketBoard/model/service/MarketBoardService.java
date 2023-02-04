package com.E1I4.project.marketBoard.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.common.model.vo.ReReply;
import com.E1I4.project.common.model.vo.Reply;
import com.E1I4.project.common.model.vo.Report;
import com.E1I4.project.common.model.vo.WishList;
import com.E1I4.project.marketBoard.model.vo.MarketBoard;
import com.E1I4.project.member.model.vo.Member;
import com.E1I4.project.notiBoard.model.vo.NotiBoard;
import com.E1I4.project.storeBoard.model.vo.StoreBoard;

public interface MarketBoardService {

	int marketBoardInsert(MarketBoard mkBoard);

	int insertAttm(HashMap<String, Object> map);

	int getMkListCount(HashMap<String, Object> map);

	ArrayList<MarketBoard> marketBoardList(PageInfo pi, HashMap<String, Object> map);

	ArrayList<Attachment> attmListSelect();

	WishList wishListSelect(WishList wl);

	MarketBoard marketBoardSelect(int bNo, boolean yn);

	ArrayList<Attachment> selectAttm(String strBNo);

	ArrayList<Reply> replySelect(int bNo);

	ArrayList<ReReply> reReplySelect(int bNo);

	ArrayList<MarketBoard> marketTopList(HashMap<String, Object> map);

	ArrayList<Attachment> topAttmListSelect(int marketType);

	int replyInsert(Reply reply);

	int marketLike(WishList wl);

	int marketLikeCancle(WishList wl);

	int reReplyInsert(ReReply reReply);
	
	int marketBoardDelete(int bNo);
	
	int updateAttmStatus(String bNo);

	int marketboardUpdate(MarketBoard mkBoard);
	
	int deleteAttm(ArrayList<String> delRename);

	void AttmLevelUpdate(String strBNo);

	int replyDelete(int rNo);

	int replyUpdate(HashMap<String, Object> map);

	int replyCount(int bNo);

	int replyCancelCount(int bNo);

	int likeCount(int bNo);

	int likeCancleCount(int bNo);

	int marketReport(Report report);

	Report reportSelect(HashMap<String, Object> map);

	Member memberSelect(String boardWriter);

	Attachment memImageSelect(String boardWriter);

	int updateReportStatus(HashMap<String, Object> map);

	StoreBoard selectProduct(Integer productNo);


	

	

	



	






	

}
