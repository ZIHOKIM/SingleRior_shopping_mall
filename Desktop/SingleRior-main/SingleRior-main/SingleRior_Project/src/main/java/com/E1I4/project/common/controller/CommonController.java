package com.E1I4.project.common.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.E1I4.project.common.Pagination;
import com.E1I4.project.common.exception.BoardException;
import com.E1I4.project.common.exception.MemberException;
import com.E1I4.project.common.model.service.CommonService;
import com.E1I4.project.common.model.vo.Message;
import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.member.model.vo.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;

@Controller
public class CommonController {

	@Autowired
	private CommonService coService;
	
	//메세지보내기
	@RequestMapping("insertMsg.cm")
	@ResponseBody
	public int inquiry(@ModelAttribute Message msg, HttpSession session) {
		msg.setSender(((Member)session.getAttribute("loginUser")).getNickName());	
		int result = 0;
		
		System.out.println(msg);
		
		if(msg.getMessageTitle().equals("") || msg.getMessageContent().equals("")) {
			result = 1;
		} else {
			result = coService.insertMsg(msg);
		}
	
		if(result > 0) {
			return result;
		} else {
			throw new BoardException("문의 실패");
		}
	}
	

	
	//메세지 리스트
	@RequestMapping("messageBox.cm")
	public String messageBox(HttpSession session, Model model, @RequestParam(value="msgType", required=false) Integer msgType, @RequestParam(value="page", required=false) Integer page) {
		Member m= (Member)session.getAttribute("loginUser");
		String nickName = m.getNickName();
		//받는편지함 0
		//보낸편지함 1
		int type = 0;
		if(msgType!=null) {
			type = msgType;
		}
		
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nickName", nickName);
		map.put("msgType", type);

		int currentPage = 1;
		if(page != null && page > 1) {
			currentPage = page;
		}
		
		int listCount = coService.getMsgListCount(map);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		
		ArrayList<Message> msgList = coService.selectMsgList(map,pi);
		if(msgList != null) {
			model.addAttribute("msgList", msgList);
			model.addAttribute("pi", pi);
			model.addAttribute("msgType", msgType);
			
			return "messageBox";
		}else {
			throw new MemberException("쪽지 불러오기 실패.");
		}
		
	}
	
	//메시지 상세보기
	@RequestMapping("selectMsg.cm")
	@ResponseBody
	public void selectMsg(@RequestParam("messageNo") int mNo, @RequestParam(value="msgType", required=false) Integer type,Model model, HttpServletResponse response,HttpSession session ) {
		String nickName = ((Member)session.getAttribute("loginUser")).getNickName();
		
		int msgType = 0;
		
		if(type!=null) {
			 msgType = type;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mNo", mNo);
		map.put("nickName", nickName);
		map.put("msgType", msgType);
		
		Message m =  coService.selectMsg(mNo);
		if(m!=null) {
			response.setContentType("application/json; charset=UTF-8");
			GsonBuilder gb = new GsonBuilder();
			Gson gson = gb.create();
			
			if(msgType!=1) {
				coService.updateCheck(map);
			}
			
			try {
				gson.toJson(m, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
		}else {
			throw new MemberException("쪽지 확인 실패. 다시 시도해주세요");
		}
	}
	
	// 메시지 삭제
	@RequestMapping("deleteMsg.cm")
	public String deleteMsg(@RequestParam("mNo") int mNo,@RequestParam(value="msgType", required=false) Integer type, HttpSession session) {
		String nickName=((Member)session.getAttribute("loginUser")).getNickName();
		int msgType=0;
		if(type!=null) {
			msgType = type;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mNo", mNo);
		map.put("nickName", nickName);
		map.put("msgType", msgType);
		
		
		int result = coService.deleteMsg(map);
		
		if(result > 0) {
			return "redirect:messageBox.cm";
		}else {
			throw new MemberException("쪽지 삭제 실패. 다시 시도해주세요");
		}
		
	}
	// 메시지 알람
	@RequestMapping("msgAlarm.cm")
	public void msgAlarm(HttpSession session, HttpServletResponse response) {
		
		Member m =((Member)session.getAttribute("loginUser"));
		int result = 0;
		if(m != null) {
			String nickName = m.getNickName();
			result = coService.msgAlarm(nickName);
		}
		
		
		response.setContentType("application/json; charset=UTF-8");
		GsonBuilder gb = new GsonBuilder();
		Gson gson = gb.create();
		
		try {
			gson.toJson(result, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
}

