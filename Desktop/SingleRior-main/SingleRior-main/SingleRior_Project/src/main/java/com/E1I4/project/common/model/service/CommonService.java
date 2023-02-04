package com.E1I4.project.common.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.E1I4.project.common.model.vo.Message;
import com.E1I4.project.common.model.vo.PageInfo;

@Service 
public interface CommonService {
	
	int insertMsg(Message msg);

	ArrayList<Message> selectMsgList(Map<String, Object> map, PageInfo pi);

	int getMsgListCount(Map<String, Object> map);

	int deleteMsg(Map<String, Object> map);

	Message selectMsg(int mNo);

	int updateCheck(Map<String, Object> map);

	int msgAlarm(String nickName);
	
}
