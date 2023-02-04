package com.E1I4.project.marketBoard.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

@Repository("mkDAO")
public class MarketBoardDAO {

	public int getMkListCount(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.selectOne("marketMapper.getMkListCount",map);
	}

	public ArrayList<MarketBoard> marketBoardList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, Object> map) {
		int offset = (pi.getCurrentPage() - 1)*pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("marketMapper.marketBoardList", map, rowBounds);
	}

	public ArrayList<Attachment> attmListSelect(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("marketMapper.attmListSelect");
	}

	public int marketBoardInsert(SqlSessionTemplate sqlSession, MarketBoard mkBoard) {
		return sqlSession.insert("marketMapper.marketBoardInsert", mkBoard);
	}

	public int insertAttm(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.insert("marketMapper.insertAttm", map);
	}

	public WishList wishListSelect(SqlSessionTemplate sqlSession, WishList wl) {
		return sqlSession.selectOne("marketMapper.wishListSelect", wl);
	}

	public int marketBoardCount(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("marketMapper.marketBoardCount", bNo);
	}

	public MarketBoard marketBoardSelect(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.selectOne("marketMapper.marketBoardSelect", bNo);
	}

	
	public ArrayList<Attachment> selectAttm(SqlSessionTemplate sqlSession, String strBNo) {
		return (ArrayList)sqlSession.selectList("marketMapper.selectAttm", strBNo);
	}
	
	public ArrayList<Reply> replySelect(SqlSessionTemplate sqlSession, int bNo) {
		return (ArrayList)sqlSession.selectList("marketMapper.replySelect", bNo);
	}

	public ArrayList<ReReply> reReplySelect(SqlSessionTemplate sqlSession, int bNo) {
		return (ArrayList)sqlSession.selectList("marketMapper.reReplySelect", bNo);
	}

	public ArrayList<MarketBoard> marketTopList(SqlSessionTemplate sqlSession,HashMap<String, Object> map) {
		return (ArrayList)sqlSession.selectList("marketMapper.marketTopList", map);
	}

	public ArrayList<Attachment> topAttmListSelect(SqlSessionTemplate sqlSession, int matketType) {
		return (ArrayList)sqlSession.selectList("marketMapper.topAttmListSelect", matketType);
	}

	public int replyInsert(SqlSessionTemplate sqlSession, Reply reply) {
		return sqlSession.insert("marketMapper.replyInsert", reply);
	}

	public int marketLike(SqlSessionTemplate sqlSession, WishList wl) {
		return sqlSession.insert("marketMapper.marketLike", wl);
	}

	public int marketLikeCancle(SqlSessionTemplate sqlSession, WishList wl) {
		return sqlSession.delete("marketMapper.marketLikeCancle", wl);
	}

	public int reReplyInsert(SqlSessionTemplate sqlSession, ReReply reReply) {
		return sqlSession.insert("marketMapper.reReplyInsert", reReply);
	}

	public int marketBoardDelete(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("marketMapper.marketBoardDelete", bNo);
	}

	public int updateAttmStatus(SqlSessionTemplate sqlSession, String strBNo) {
		return sqlSession.update("marketMapper.updateAttmStatus", strBNo);
	}

	public int deleteAttm(SqlSessionTemplate sqlSession, ArrayList<String> delRename) {
		return sqlSession.update("marketMapper.deleteAttm", delRename);
	}

	public void AttmLevelUpdate(SqlSessionTemplate sqlSession, String strBNo) {
		sqlSession.update("marketMapper.AttmLevelUpdate", strBNo);
	}

	public int marketboardUpdate(SqlSessionTemplate sqlSession, MarketBoard mkBoard) {
		int result = sqlSession.update("marketMapper.marketUpdate", mkBoard);
		result += sqlSession.update("marketMapper.boardUpdate", mkBoard);
		System.out.println(result);
		return result;
	}

	public int replyDelete(SqlSessionTemplate sqlSession, int rNo) {
		return sqlSession.update("marketMapper.replyDelete", rNo);
	}

	public int replyUpdate(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.update("marketMapper.replyUpdate", map);
	}

	public int replyCount(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("marketMapper.replyCount", bNo);
	}

	public int replyCancelCount(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("marketMapper.replyCancleCount", bNo);
	}

	public int likeCount(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("marketMapper.likeCount", bNo);
	}

	public int likeCancleCount(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("marketMapper.likeCancleCount", bNo);
	}

	public int marketReport(SqlSessionTemplate sqlSession, Report report) {
		return sqlSession.insert("marketMapper.marketReport", report);
	}

	public Report reportSelect(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.selectOne("marketMapper.reportSelect", map);
	}

	public Member memberSelect(SqlSessionTemplate sqlSession, String boardWriter) {
		return sqlSession.selectOne("marketMapper.memberSelect", boardWriter);
	}

	public Attachment memImageSelect(SqlSessionTemplate sqlSession, String boardWriter) {
		return sqlSession.selectOne("marketMapper.memImageSelect", boardWriter);
	}


	public int updateReportStatus(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.update("marketMapper.updateReportStatus", map);
	}

	public StoreBoard selectProduct(SqlSessionTemplate sqlSession, Integer productNo) {
		return sqlSession.selectOne("marketMapper.selectProduct", productNo);
	}

	
	

	


	

}
