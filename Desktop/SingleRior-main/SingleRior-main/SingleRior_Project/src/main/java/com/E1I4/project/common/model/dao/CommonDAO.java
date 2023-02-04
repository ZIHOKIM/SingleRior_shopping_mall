package com.E1I4.project.common.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.E1I4.project.common.model.vo.Message;
import com.E1I4.project.common.model.vo.PageInfo;
@Repository("coDAO")
public class CommonDAO {

	public int insertMsg(SqlSessionTemplate sqlSession, Message msg) {
		return sqlSession.insert("commonMapper.insertMsg", msg);
	}

	public ArrayList<Message> selectMsgList(SqlSessionTemplate sqlSession, Map<String, Object> map, PageInfo pi) {
int offset = (pi.getCurrentPage() - 1)*pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("commonMapper.selectMsgList", map, rowBounds);
	}

	public int getMsgListCount(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("commonMapper.getMsgListCount", map);
	}

	public int deleteMsg(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("commonMapper.deleteMsg", map);
	}

	public Message selectMsg(SqlSessionTemplate sqlSession, int mNo) {
		return sqlSession.selectOne("commonMapper.selectMsg", mNo);
	}

	public int updateCheck(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("commonMapper.updateCheck", map);
	}

	public int msgAlarm(SqlSessionTemplate sqlSession, String nickName) {
		return sqlSession.selectOne("commonMapper.msgAlarm", nickName);
	}

}
