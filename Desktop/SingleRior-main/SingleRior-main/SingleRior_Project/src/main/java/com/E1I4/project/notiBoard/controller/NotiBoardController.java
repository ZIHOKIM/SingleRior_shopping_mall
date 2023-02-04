package com.E1I4.project.notiBoard.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.E1I4.project.common.Pagination;
import com.E1I4.project.common.exception.BoardException;
import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.member.model.vo.Member;
import com.E1I4.project.notiBoard.model.service.NotiBoardService;
import com.E1I4.project.notiBoard.model.vo.NotiBoard;

@Controller
public class NotiBoardController {
	
	@Autowired
	private NotiBoardService nService;
	
	@RequestMapping("notiAllList.no")
	public String selectNotiAllList(@RequestParam(value="page", required=false) Integer page, Model model,
			@RequestParam(value="noticeCategory", required=false) String notiCate) {
		// 공지사항 카테고리 -> 1: 전체, 2: 싱글벙글, 3: 씽씽마켓
		String noticeCategory = "";
		if(notiCate != null) {
			noticeCategory = notiCate;
		}
				
		int currentPage = 1;
		if(page != null && page > 1) {
			currentPage = page;
		}
		
		int listCount = nService.getNotiListCount(noticeCategory);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);
		
		ArrayList<NotiBoard> list = nService.selectNotiAllList(pi, noticeCategory);
		
		if(list != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			return "notiBoardList";
		} else {
			throw new BoardException("게시글 목록 조회에 실패하였습니다.");
		}
	}
	
	@RequestMapping("selectNotiBoard.no")
	public ModelAndView selectNotiBoard(@RequestParam("bNo") int bNo, @RequestParam("writer") String writer, HttpSession session, ModelAndView mv) {
		Member m = (Member)session.getAttribute("loginUser");
		
		String login = null;
		
		if(m != null) {
			login = m.getNickName();
		}
		
		boolean yn = false;
		if(!writer.equals(login)) {
			yn = true;
		}
		
		NotiBoard notiBoard = nService.selectNotiBoard(bNo, yn);
		
		if(notiBoard != null) {
			mv.addObject("notiBoard", notiBoard);
			mv.setViewName("notiBoardDetail");
			return mv;
		} else {
			throw new BoardException("게시글 상세보기에 실패하였습니다.");
		}
	}
}
