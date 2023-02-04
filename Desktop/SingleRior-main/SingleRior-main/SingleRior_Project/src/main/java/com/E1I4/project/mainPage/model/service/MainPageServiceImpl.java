package com.E1I4.project.mainPage.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.commuBoard.model.vo.CommuBoard;
import com.E1I4.project.mainPage.model.dao.MainPageDAO;
import com.E1I4.project.marketBoard.model.vo.MarketBoard;
import com.E1I4.project.notiBoard.model.vo.NotiBoard;
import com.E1I4.project.storeBoard.model.vo.StoreBoard;

@Service("mainService")
public class MainPageServiceImpl implements MainPageService {
	
	@Autowired
	private MainPageDAO mainDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 배너 리스트
	@Override
	public ArrayList<Attachment> selectBnAttmList() {
		return mainDAO.selectBnAttmList(sqlSession);
	}
	
	// 스토어 리스트
	@Override
	public ArrayList<StoreBoard> selectPdList() {
		return mainDAO.selectPdList(sqlSession);
	}
	
	@Override
	public double getReviewRating(HashMap<String, Integer> map) {
		return mainDAO.getReviewRating(sqlSession, map);
	}

	@Override
	public int getReviewCount(HashMap<String, Integer> map) {
		return mainDAO.getReviewCount(sqlSession, map);
	}

	@Override
	public ArrayList<Attachment> selectPdAttmList() {
		return mainDAO.selectPdAttmList(sqlSession);
	}
	
	// 씽씽마켓 리스트
	@Override
	public ArrayList<MarketBoard> selectMarketList() {
		return mainDAO.selectMarketList(sqlSession);
	}

	@Override
	public ArrayList<Attachment> selectMarketAttmList() {
		return mainDAO.selectMarketAttmList(sqlSession);
	}
	
	// 싱글벙글 리스트
	@Override
	public ArrayList<CommuBoard> selectCommuList() {
		return mainDAO.selectCommuList(sqlSession);
	}
	
	@Override
	public ArrayList<Attachment> selectCommuAttmList() {
		return mainDAO.selectCommuAttmList(sqlSession);
	}
	
	
	/* 검색 (search) */
	// 스토어
	@Override
	public ArrayList<StoreBoard> searchPdList(String findKeyword) {
		return mainDAO.searchPdList(sqlSession, findKeyword);
	}
	
	// 씽씽마켓
	@Override
	public ArrayList<MarketBoard> searchMarketList(String findKeyword) {
		return mainDAO.searchMarketList(sqlSession, findKeyword);
	}

	// 싱글벙글
	@Override
	public ArrayList<CommuBoard> searchCommuList(String findKeyword) {
		return mainDAO.searchCommuList(sqlSession, findKeyword);
	}
	
	// 공지사항
	@Override
	public ArrayList<NotiBoard> searchNotiList(String findKeyword) {
		return mainDAO.searchNotiList(sqlSession, findKeyword);
	}

	
	/* 배너 */
	@Override
	public ArrayList<Attachment> selectBannerList(String imgKey) {
		return mainDAO.selectBannerList(sqlSession, imgKey);
	}

}
