package com.E1I4.project.notiBoard.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.commuBoard.model.vo.CommuBoard;
import com.E1I4.project.notiBoard.model.dao.NotiBoardDAO;
import com.E1I4.project.notiBoard.model.vo.NotiBoard;

@Service("nService")
public class NotiBoardServiceImpl implements NotiBoardService{
	@Autowired
	private NotiBoardDAO nDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int getNotiListCount(String noticeCategory) {
		return nDAO.getNotiListCount(sqlSession, noticeCategory);
	}

	@Override
	public ArrayList<NotiBoard> selectNotiAllList(PageInfo pi, String noticeCategory) {
		return nDAO.selectNotiAllList(sqlSession, pi, noticeCategory);
	}

	@Override
	public NotiBoard selectNotiBoard(int bNo, boolean yn) {
		int result = 0;
		if(yn) {
			result = nDAO.addCount(sqlSession, bNo);
		}
		
		NotiBoard notiBoard = nDAO.selectNotiBoard(sqlSession, bNo);
		return notiBoard;
	}

	@Override
	public ArrayList<NotiBoard> selectCommuNotiList() {
		return nDAO.selectCommuNotiList(sqlSession);
	}


}
