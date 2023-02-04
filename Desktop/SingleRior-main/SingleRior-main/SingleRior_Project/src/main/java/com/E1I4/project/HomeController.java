package com.E1I4.project;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.commuBoard.model.vo.CommuBoard;
import com.E1I4.project.mainPage.model.service.MainPageService;
import com.E1I4.project.marketBoard.model.vo.MarketBoard;
import com.E1I4.project.notiBoard.model.vo.NotiBoard;
import com.E1I4.project.storeBoard.model.vo.StoreBoard;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private MainPageService mainService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		ArrayList<Attachment> bnAttmList = mainService.selectBnAttmList();
		
		ArrayList<StoreBoard> pdList = mainService.selectPdList();
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		
		for(int i = 0; i<pdList.size(); i++) {
			int boardNo = pdList.get(i).getBoardNo();
			int productNo = pdList.get(i).getProductNo();
			
			map.put("boardNo", boardNo);
			map.put("productNo", productNo);
			
			int reviewCount = mainService.getReviewCount(map);
			pdList.get(i).setReviewCount(reviewCount);
			
			double reviewRating = 0.0;
			
			if(pdList.get(i).getReviewCount() != 0) {
				double fullReviewRating = mainService.getReviewRating(map);
				reviewRating = Math.floor(fullReviewRating * 10) / 10.0;
				pdList.get(i).setReviewRating(reviewRating);
			} else {
				pdList.get(i).setReviewRating(reviewRating);
			}
			
		}
		ArrayList<Attachment> pdAttmList = mainService.selectPdAttmList();
		
		ArrayList<MarketBoard> marketList = mainService.selectMarketList();
		ArrayList<Attachment> marketAttmList = mainService.selectMarketAttmList();
		
		ArrayList<CommuBoard> commuList = mainService.selectCommuList();
		ArrayList<Attachment> commuAttmList = mainService.selectCommuAttmList();
		
		model.addAttribute("bnAttmList", bnAttmList);
		model.addAttribute("pdList", pdList);
		model.addAttribute("pdAttmList", pdAttmList);
		model.addAttribute("marketList", marketList);
		model.addAttribute("marketAttmList", marketAttmList);
		model.addAttribute("commuList", commuList);
		model.addAttribute("commuAttmList", commuAttmList);
		return "home";
		
	}
	
	@RequestMapping("mainSearch.main")
	public String mainSearch(@RequestParam(value="findKeyword", required=false) String keyword, Model model) {
		String findKeyword = null;
		
		if(keyword != null) {
			findKeyword = keyword;
		}
		
		ArrayList<StoreBoard> pdList = mainService.searchPdList(findKeyword);
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		
		for(int i = 0; i<pdList.size(); i++) {
			int boardNo = pdList.get(i).getBoardNo();
			int productNo = pdList.get(i).getProductNo();
			
			map.put("boardNo", boardNo);
			map.put("productNo", productNo);
			
			int reviewCount = mainService.getReviewCount(map);
			pdList.get(i).setReviewCount(reviewCount);
			
			double reviewRating = 0.0;
			
			if(pdList.get(i).getReviewCount() != 0) {
				double fullReviewRating = mainService.getReviewRating(map);
				reviewRating = Math.floor(fullReviewRating * 10) / 10.0;
				pdList.get(i).setReviewRating(reviewRating);
			} else {
				pdList.get(i).setReviewRating(reviewRating);
			}
			
		}
		ArrayList<Attachment> pdAttmList = mainService.selectPdAttmList();
		
		ArrayList<MarketBoard> marketList = mainService.searchMarketList(findKeyword);
		ArrayList<Attachment> marketAttmList = mainService.selectMarketAttmList();
		
		ArrayList<CommuBoard> commuList = mainService.searchCommuList(findKeyword);
		ArrayList<Attachment> commuAttmList = mainService.selectCommuAttmList();
		
		ArrayList<NotiBoard> notiList = mainService.searchNotiList(findKeyword);
		
		model.addAttribute("findKeyword", findKeyword);
		model.addAttribute("pdList", pdList);
		model.addAttribute("pdAttmList", pdAttmList);
		model.addAttribute("marketList", marketList);
		model.addAttribute("marketAttmList", marketAttmList);
		model.addAttribute("commuList", commuList);
		model.addAttribute("commuAttmList", commuAttmList);
		model.addAttribute("notiList", notiList);
		return "common/searchView";
	}
	
	@RequestMapping("mainBanner.main")
	public String mainBanner(@RequestParam("imgKey") String imgKey, Model model) {
		ArrayList<Attachment> bannerList = mainService.selectBannerList(imgKey);
		
		model.addAttribute("bannerList", bannerList);
		return "common/mainBanner";
	}
	
}
