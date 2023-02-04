package com.E1I4.project.mainPage.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.commuBoard.model.vo.CommuBoard;
import com.E1I4.project.marketBoard.model.vo.MarketBoard;
import com.E1I4.project.notiBoard.model.vo.NotiBoard;
import com.E1I4.project.storeBoard.model.vo.StoreBoard;

public interface MainPageService {
	
	// 배너 리스트
	ArrayList<Attachment> selectBnAttmList();
	
	// 스토어 리스트
	ArrayList<StoreBoard> selectPdList();
	
	double getReviewRating(HashMap<String, Integer> map);

	int getReviewCount(HashMap<String, Integer> map);

	ArrayList<Attachment> selectPdAttmList();
	
	// 씽씽마켓 리스트
	ArrayList<MarketBoard> selectMarketList();

	ArrayList<Attachment> selectMarketAttmList();
	
	// 싱글벙글 리스트
	ArrayList<CommuBoard> selectCommuList();

	ArrayList<Attachment> selectCommuAttmList();
	
	
	/* 검색 (search) */
	// 스토어
	ArrayList<StoreBoard> searchPdList(String findKeyword);
	
	// 씽씽마켓
	ArrayList<MarketBoard> searchMarketList(String findKeyword);
	
	// 싱글벙글
	ArrayList<CommuBoard> searchCommuList(String findKeyword);
	
	// 공지사항
	ArrayList<NotiBoard> searchNotiList(String findKeyword);
	
	
	/* 배너 */
	ArrayList<Attachment> selectBannerList(String imgKey);

}
