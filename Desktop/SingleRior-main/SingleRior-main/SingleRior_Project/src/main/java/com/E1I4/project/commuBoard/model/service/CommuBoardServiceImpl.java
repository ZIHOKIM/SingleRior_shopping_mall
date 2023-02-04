package com.E1I4.project.commuBoard.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.common.model.vo.ReReply;
import com.E1I4.project.common.model.vo.Reply;
import com.E1I4.project.common.model.vo.Report;
import com.E1I4.project.common.model.vo.WishList;
import com.E1I4.project.commuBoard.model.dao.CommuBoardDAO;
import com.E1I4.project.commuBoard.model.vo.CommuBoard;


@Service("cService")
public class CommuBoardServiceImpl implements CommuBoardService{
	
	@Autowired
	private CommuBoardDAO cDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int getCommuListCount(HashMap<String, Object> map) {
		return cDAO.getCommuListCount(sqlSession, map);
	}
	
	// 싱글벙글 커뮤니티 list select
	@Override
	public ArrayList<CommuBoard> selectCommuAllList(PageInfo pi, HashMap<String, Object> map) {
		return cDAO.selectCommuAllList(sqlSession, pi, map);
	}
	
	
	/* 게시글 등록 (insert) */
	@Override
	public int insertCommuBoard(CommuBoard coBoard) {
		return cDAO.insertCommuBoard(sqlSession, coBoard);
	}

	@Override
	public int insertAttm(HashMap<String, Object> map) {
		return cDAO.insertAttm(sqlSession, map);
	}
	
	
	/* 게시글 상세보기 */
	// 게시글 select
	@Override
	public CommuBoard selectCommuBoard(int bNo, boolean yn) {
		int result = 0;
		if(yn) {
			result = cDAO.addCount(sqlSession, bNo);
		}
		
		CommuBoard coBoard = cDAO.selectCommuBoard(sqlSession, bNo);
		return coBoard;
	}
	
	// 첨부파일 불러오기
	@Override
	public ArrayList<Attachment> selectAttmBoard(String bNo) {
		return cDAO.selectAttmBoard(sqlSession, bNo);
	}
	
	
	/* 공감 (sympt) */
	// 공감하기 (on)
	@Override
	public int symptOn(WishList wl, int bNo) {
		cDAO.addSymptCount(sqlSession, bNo);
		return cDAO.symptOn(sqlSession, wl);
	}
	
	// 공감 count 불러오기
	@Override
	public WishList selectSymptOn(WishList wl) {
		return cDAO.selectSymptOn(sqlSession, wl);
	}
	
	// 공감하기 (off)
	@Override
	public int symptOff(WishList wl, int bNo) {
		cDAO.deleteSymptCount(sqlSession, bNo);
		return cDAO.symptOff(sqlSession, wl);
	}
	
	
	/* 댓글 */
	// 댓글 list select
	@Override
	public ArrayList<Reply> selectReply(int bNo) {
		return cDAO.selectReply(sqlSession, bNo);
	}
	
	// 댓글 등록 (insert)
	@Override
	public int insertReply(Reply r) {
		return cDAO.insertReply(sqlSession, r);
	}
	
	// 댓글 count up
	@Override
	public int replyCountUp(int bNo) {
		return cDAO.replyCountUp(sqlSession, bNo);
	}
	
	// 댓글 수정 (update)
	@Override
	public int updateReply(HashMap<String, Object> map) {
		return cDAO.updateReply(sqlSession, map);
	}
	
	@Override
	public Reply replyOneSelect(int replyNo) {
		return cDAO.replyOneSelect(sqlSession, replyNo);
	}
	
	// 댓글 삭제 (delete)
	@Override
	public int deleteReply(int rNo) {
		return cDAO.deleteReply(sqlSession, rNo);
	}
	
	// 댓글 count down
	@Override
	public int replyCountDown(int bNo) {
		return cDAO.replyCountDown(sqlSession, bNo);
	}
	
	
	/* 게시글 수정 (update) */
	// 첨부파일 삭제
	@Override
	public int deleteAttm(ArrayList<String> delRename) {
		return cDAO.deleteAttm(sqlSession, delRename);
	}
	
	// 내용 수정
	@Override
	public int updateCommuBoard(CommuBoard coBoard) {
		return cDAO.updateCommuBoard(sqlSession, coBoard);
	}
	
	// 첨부파일 level 변경
	@Override
	public void updateAttmLevel(String strBNo) {
		cDAO.updateAttmLevel(sqlSession, strBNo);
	}
	
	
	/* 게시글 삭제 (delete) */
	@Override
	public int deleteCommuBoard(int bNo) {
		return cDAO.deleteCommuBoard(sqlSession, bNo);
	}

	@Override
	public int updateAttmStatus(String strBNo) {
		return cDAO.updateAttmStatus(sqlSession, strBNo);
	}
	
	
	/* 게시글 신고 (report) */
	@Override
	public int commuReport(Report report, HashMap<String, Object> map) {
		// reportStatus 변경
		cDAO.updateReportStatus(sqlSession, map);
		return cDAO.commuReport(sqlSession, report);
	}
	
	// 신고여부 확인
	@Override
	public Report selectReport(HashMap<String, Object> map) {
		return cDAO.selectReport(sqlSession, map);
	}

	@Override
	public int insertReReply(HashMap<String, Object> map) {
		return cDAO.insertReReply(sqlSession, map);
	}

}
