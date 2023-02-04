package com.E1I4.project.mainPage.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.commuBoard.model.vo.CommuBoard;
import com.E1I4.project.marketBoard.model.vo.MarketBoard;
import com.E1I4.project.notiBoard.model.vo.NotiBoard;
import com.E1I4.project.storeBoard.model.vo.StoreBoard;

@Repository("mainDAO")
public class MainPageDAO {
	
	// 배너 리스트
	public ArrayList<Attachment> selectBnAttmList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("mainMapper.selectBnAttmList");
	}
	
	// 스토어 리스트
	public ArrayList<StoreBoard> selectPdList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("mainMapper.selectPdList");
	}
	
	public double getReviewRating(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		return sqlSession.selectOne("mainMapper.getReviewRating", map);
	}

	public int getReviewCount(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		return sqlSession.selectOne("mainMapper.getReviewCount", map);
	}

	public ArrayList<Attachment> selectPdAttmList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("mainMapper.selectPdAttmList");
	}
	
	// 씽씽마켓 리스트
	public ArrayList<MarketBoard> selectMarketList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("mainMapper.selectMarketList");
	}

	public ArrayList<Attachment> selectMarketAttmList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("mainMapper.selectMarketAttmList");
	}
	
	// 싱글벙글 리스트
	public ArrayList<CommuBoard> selectCommuList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("mainMapper.selectCommuList");
	}

	public ArrayList<Attachment> selectCommuAttmList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("mainMapper.selectCommuAttmList");
	}
	
	
	/* 검색 (search) */
	// 스토어
	public ArrayList<StoreBoard> searchPdList(SqlSessionTemplate sqlSession, String findKeyword) {
		return (ArrayList)sqlSession.selectList("mainMapper.searchPdList", findKeyword);
	}
	
	// 씽씽마켓
	public ArrayList<MarketBoard> searchMarketList(SqlSessionTemplate sqlSession, String findKeyword) {
		return (ArrayList)sqlSession.selectList("mainMapper.searchMarketList", findKeyword);
	}
	
	// 싱글벙글
	public ArrayList<CommuBoard> searchCommuList(SqlSessionTemplate sqlSession, String findKeyword) {
		return (ArrayList)sqlSession.selectList("mainMapper.searchCommuList", findKeyword);
	}

	// 공지사항
	public ArrayList<NotiBoard> searchNotiList(SqlSessionTemplate sqlSession, String findKeyword) {
		return (ArrayList)sqlSession.selectList("mainMapper.searchNotiList", findKeyword);
	}

	
	/* 배너 */
	public ArrayList<Attachment> selectBannerList(SqlSessionTemplate sqlSession, String imgKey) {
		return (ArrayList)sqlSession.selectList("mainMapper.selectBannerList", imgKey);
	}

}
