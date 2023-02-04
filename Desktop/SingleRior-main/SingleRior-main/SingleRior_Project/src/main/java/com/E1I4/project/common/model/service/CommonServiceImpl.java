package com.E1I4.project.common.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.E1I4.project.common.model.dao.CommonDAO;
import com.E1I4.project.common.model.vo.Message;
import com.E1I4.project.common.model.vo.PageInfo;

@Service("coService")
public class CommonServiceImpl implements CommonService{
	
	@Autowired
	private CommonDAO coDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertMsg(Message msg) {
		return coDAO.insertMsg(sqlSession, msg);
	}

	@Override
	public ArrayList<Message> selectMsgList(Map<String, Object> map, PageInfo pi) {
		return coDAO.selectMsgList(sqlSession, map, pi);
	}

	@Override
	public int getMsgListCount(Map<String, Object> map) {
		return coDAO.getMsgListCount(sqlSession, map);
	}

	@Override
	public int deleteMsg(Map<String, Object> map) {
		return coDAO.deleteMsg(sqlSession, map);
	}

	@Override
	public Message selectMsg(int mNo) {
		return coDAO.selectMsg(sqlSession, mNo);
	}

	@Override
	public int updateCheck(Map<String, Object> map) {
		return coDAO.updateCheck(sqlSession, map);
		
	}

	@Override
	public int msgAlarm(String nickName) {
		return coDAO.msgAlarm(sqlSession, nickName);
	}

}
