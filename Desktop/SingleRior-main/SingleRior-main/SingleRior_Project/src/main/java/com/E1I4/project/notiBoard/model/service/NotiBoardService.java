package com.E1I4.project.notiBoard.model.service;

import java.util.ArrayList;

import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.notiBoard.model.vo.NotiBoard;

public interface NotiBoardService {

	int getNotiListCount(String noticeCategory);

	ArrayList<NotiBoard> selectNotiAllList(PageInfo pi, String noticeCategory);

	NotiBoard selectNotiBoard(int bNo, boolean yn);

	ArrayList<NotiBoard> selectCommuNotiList();


}
