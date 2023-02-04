package com.E1I4.project.commuBoard.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.common.model.vo.ReReply;
import com.E1I4.project.common.model.vo.Reply;
import com.E1I4.project.common.model.vo.Report;
import com.E1I4.project.common.model.vo.WishList;
import com.E1I4.project.commuBoard.model.vo.CommuBoard;

@Repository("cDAO")
public class CommuBoardDAO {
	
	public int getCommuListCount(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.selectOne("commuMapper.getCommuListCount", map);
	}
	
	// 싱글벙글 커뮤니티 list select
	public ArrayList<CommuBoard> selectCommuAllList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, Object> map) {
		int offset = (pi.getCurrentPage() - 1)*pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("commuMapper.selectCommuAllList", map, rowBounds);
	}
	
	
	/* 게시글 등록 (insert) */
	public int insertCommuBoard(SqlSessionTemplate sqlSession, CommuBoard coBoard) {
		return sqlSession.insert("commuMapper.insertCommuBoard", coBoard);
	}

	public int insertAttm(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.insert("commuMapper.insertAttm", map);
	}
	
	
	/* 게시글 상세보기 */
	// 게시글 select
	public int addCount(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("commuMapper.addCount", bNo);
	}

	public CommuBoard selectCommuBoard(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.selectOne("commuMapper.selectCommuBoard", bNo);
	}
	
	// 첨부파일 불러오기
	public ArrayList<Attachment> selectAttmBoard(SqlSessionTemplate sqlSession, String bNo) {
		return (ArrayList)sqlSession.selectList("commuMapper.selectAttmBoard", bNo);
	}
	
	/* 공감 (sympt) */
	// 공감하기 (on)
	public int symptOn(SqlSessionTemplate sqlSession, WishList wl) {
		return sqlSession.insert("commuMapper.symptOn", wl);
	}
	
	public int addSymptCount(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("commuMapper.addSymptCount", bNo);
	}
	
	// 공감 count 불러오기
	public WishList selectSymptOn(SqlSessionTemplate sqlSession, WishList wl) {
		return sqlSession.selectOne("commuMapper.selectSymptOn", wl);
	}
	
	// 공감하기 (off)
	public int symptOff(SqlSessionTemplate sqlSession, WishList wl) {
		return sqlSession.delete("commuMapper.symptOff", wl);
	}

	public int deleteSymptCount(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("commuMapper.deleteSymptCount", bNo);
	}
	
	
	/* 댓글 */
	// 댓글 list select
	public ArrayList<Reply> selectReply(SqlSessionTemplate sqlSession, int bNo) {
		return (ArrayList)sqlSession.selectList("commuMapper.selectReply", bNo);
	}
	
	// 댓글 등록 (insert)
	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.insert("commuMapper.insertReply", r);
	}
	
	// 댓글 count up
	public int replyCountUp(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("commuMapper.replyCountUp", bNo);
	}
	
	// 댓글 수정 (update)
	public int updateReply(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.update("commuMapper.updateReply", map);
	}
	
	public Reply replyOneSelect(SqlSessionTemplate sqlSession, int replyNo) {
		return sqlSession.selectOne("commuMapper.replyOneSelect", replyNo);
	}
	
	// 댓글 삭제 (delete)
	public int deleteReply(SqlSessionTemplate sqlSession, int rNo) {
		return sqlSession.update("commuMapper.deleteReply", rNo);
	}
	
	// 댓글 count down
	public int replyCountDown(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("commuMapper.replyCountDown", bNo);
	}
	
	
	/* 게시글 수정 (update) */
	// 첨부파일 삭제
	public int deleteAttm(SqlSessionTemplate sqlSession, ArrayList<String> delRename) {
		return sqlSession.delete("commuMapper.deleteAttm", delRename);
	}
	
	// 내용 수정
	public int updateCommuBoard(SqlSessionTemplate sqlSession, CommuBoard coBoard) {
		int result = sqlSession.update("commuMapper.commuUpdate", coBoard);
		result += sqlSession.update("commuMapper.updateCommuBoard", coBoard);
		return result;
	}
	
	// 첨부파일 level 변경
	public void updateAttmLevel(SqlSessionTemplate sqlSession, String strBNo) {
		sqlSession.update("commuMapper.updateAttmLevel", strBNo);
	}
	
	
	/* 게시글 삭제 (delete) */
	public int deleteCommuBoard(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("commuMapper.deleteCommuBoard", bNo);
	}

	public int updateAttmStatus(SqlSessionTemplate sqlSession, String strBNo) {
		return sqlSession.update("commuMapper.updateAttmStatus", strBNo);
	}
	
	
	/* 게시글 신고 (report) */
	public int commuReport(SqlSessionTemplate sqlSession, Report report) {
		return sqlSession.insert("commuMapper.commuReport", report);
	}
	
	// reportStatus 변경
	public void updateReportStatus(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		sqlSession.update("commuMapper.updateReportStatus", map);
	}
	
	// 신고여부 확인
	public Report selectReport(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.selectOne("commuMapper.selectReport", map);
	}

	public int insertReReply(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.insert("commuMapper.insertReReply", map);
	}

}
