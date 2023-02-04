package com.E1I4.project.notiBoard.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.notiBoard.model.vo.NotiBoard;

@Repository("nDAO")
public class NotiBoardDAO {

	public int getNotiListCount(SqlSessionTemplate sqlSession, String noticeCategory) {
		return sqlSession.selectOne("notiMapper.getNotiListCount", noticeCategory);
	}

	public ArrayList<NotiBoard> selectNotiAllList(SqlSessionTemplate sqlSession, PageInfo pi, String noticeCategory) {
		int offset = (pi.getCurrentPage() - 1)*pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("notiMapper.selectNotiAllList", noticeCategory, rowBounds);
	}

	public int addCount(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("notiMapper.addCount", bNo);
	}

	public NotiBoard selectNotiBoard(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.selectOne("notiMapper.selectNotiBoard", bNo);
	}

	public ArrayList<NotiBoard> selectCommuNotiList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("notiMapper.selectCommuNotiList");
	}


}
