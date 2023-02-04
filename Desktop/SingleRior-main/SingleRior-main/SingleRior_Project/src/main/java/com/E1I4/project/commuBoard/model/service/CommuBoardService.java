package com.E1I4.project.commuBoard.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.common.model.vo.ReReply;
import com.E1I4.project.common.model.vo.Reply;
import com.E1I4.project.common.model.vo.Report;
import com.E1I4.project.common.model.vo.WishList;
import com.E1I4.project.commuBoard.model.vo.CommuBoard;

public interface CommuBoardService {
	
	int getCommuListCount(HashMap<String, Object> map);
	
	// 싱글벙글 커뮤니티 list select
	ArrayList<CommuBoard> selectCommuAllList(PageInfo pi, HashMap<String, Object> map);
	
	/* 게시글 등록 (insert) */
	int insertCommuBoard(CommuBoard coBoard);

	int insertAttm(HashMap<String, Object> map);
	
	
	/* 게시글 상세보기 */
	// 게시글 select
	CommuBoard selectCommuBoard(int bNo, boolean yn);
	
	// 첨부파일 불러오기
	ArrayList<Attachment> selectAttmBoard(String bNo);
	
	
	/* 공감 (sympt) */
	// 공감하기 (on)
	int symptOn(WishList wl, int bNo);
	
	// 공감 count 불러오기
	WishList selectSymptOn(WishList wl);
	
	// 공감하기 (off)
	int symptOff(WishList wl, int bNo);
	
	
	/* 댓글 */
	// 댓글 list select
	ArrayList<Reply> selectReply(int bNo);
	
	// 댓글 등록 (insert)
	int insertReply(Reply r);
	
	// 댓글 count up
	int replyCountUp(int bNo);
	
	// 댓글 수정 (update)
	int updateReply(HashMap<String, Object> map);
	
	Reply replyOneSelect(int replyNo);
	
	// 댓글 삭제 (delete)
	int deleteReply(int rNo);
	
	// 댓글 count down
	int replyCountDown(int bNo);
	
	
	/* 게시글 수정 (update) */
	// 첨부파일 삭제
	int deleteAttm(ArrayList<String> delRename);
	
	// 내용 수정
	int updateCommuBoard(CommuBoard coBoard);
	
	// 첨부파일 level 변경
	void updateAttmLevel(String strBNo);
	
	
	/* 게시글 삭제 (delete) */
	int deleteCommuBoard(int bNo);

	int updateAttmStatus(String strBNo);
	
	
	/* 게시글 신고 (report) */
	int commuReport(Report report, HashMap<String, Object> map);
	
	// 신고여부 확인
	Report selectReport(HashMap<String, Object> map);

	int insertReReply(HashMap<String, Object> map);

}
