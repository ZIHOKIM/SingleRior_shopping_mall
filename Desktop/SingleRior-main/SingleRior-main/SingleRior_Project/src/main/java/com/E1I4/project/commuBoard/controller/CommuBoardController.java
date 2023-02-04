package com.E1I4.project.commuBoard.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.E1I4.project.common.Pagination;
import com.E1I4.project.common.exception.BoardException;
import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.common.model.vo.ReReply;
import com.E1I4.project.common.model.vo.Reply;
import com.E1I4.project.common.model.vo.Report;
import com.E1I4.project.common.model.vo.WishList;
import com.E1I4.project.commuBoard.model.service.CommuBoardService;
import com.E1I4.project.commuBoard.model.vo.CommuBoard;
import com.E1I4.project.member.model.service.MemberService;
import com.E1I4.project.member.model.vo.Member;
import com.E1I4.project.notiBoard.model.service.NotiBoardService;
import com.E1I4.project.notiBoard.model.vo.NotiBoard;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;

@Controller
public class CommuBoardController {
	
	@Autowired
	private CommuBoardService cService;
	
	@Autowired
	private NotiBoardService nService;
	
	@Autowired
	private MemberService mService;
	
	// 커뮤니티 전체 글 목록
	@RequestMapping("commuAllList.co")
	public String selectCommuAllList(@RequestParam(value="page", required=false) Integer page, Model model,
			@RequestParam(value="commuArray", required=false) Integer coArray, @RequestParam(value="commuType", required=false) Integer coType,
			@RequestParam(value="commuSearch", required=false) String search, @RequestParam(value="searchType", required=false) Integer sType) {
		// 싱글벙글 카테고리 -> 1: 생활팁, 2: 후기, 3: 자유
		int commuType = 0;
		if(coType != null) {
			commuType = coType;
		}
		
		// 정렬 -> 1: 최신순, 2: 공감순, 3: 댓글순
		int commuArray = 0;
		if(coArray != null) {
			commuArray = coArray;
		}
		
		// searchType -> 0: 전체, 1: 제목, 2: 내용, 3: 작성자
		String commuSearch = null;
		int searchType= 0;
		if(search != null && sType!=null) {
			commuSearch = search;
			searchType = sType;
		}
		
		int currentPage = 1;
		if(page != null && page > 1) {
			currentPage = page;
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("commuType", commuType);
		map.put("commuArray", commuArray);
		map.put("commuSearch", commuSearch);
		map.put("searchType", searchType);
		
		int listCount = cService.getCommuListCount(map);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);
		
		ArrayList<CommuBoard> list = cService.selectCommuAllList(pi, map);
		ArrayList<NotiBoard> notiList = nService.selectCommuNotiList();
		
		if(list != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			model.addAttribute("commuArray", commuArray);
			model.addAttribute("commuType", commuType);
			model.addAttribute("notiList", notiList);
			return "commuBoardList";
		} else {
			throw new BoardException("게시글 목록 조회에 실패하였습니다.");
		}
	}
	
	/* 게시글 등록 (insert) */
	// 글 작성 페이지 이동
	@RequestMapping("writeCommuBoard.co")
	public String writeCommuBoard() {
		return "commuBoardWrite";
	}
	
	// 커뮤니티 글 등록 (insert)
	@RequestMapping("insertCommuBoard.co")
	public String insertCommuBoard(@ModelAttribute CommuBoard coBoard, @RequestParam("file") ArrayList<MultipartFile> files, HttpServletRequest request) {
		String id = ((Member)request.getSession().getAttribute("loginUser")).getMemberId();
		coBoard.setWriter(id);
		coBoard.setCommuType(coBoard.getCommuType());
		
		int boardResult = cService.insertCommuBoard(coBoard);
		
		ArrayList<Attachment> list = new ArrayList<>();
		for(MultipartFile file : files) {
			String fileName = file.getOriginalFilename();
			if(!fileName.equals("")) {
				String fileType = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
				
				if(fileType.equals("png") || fileType.equals("jpg") || fileType.equals("gif") || fileType.equals("jpeg") || fileType.equals("jfif")) {
					String[] returnArr = saveFile(file, request);
					
					if(returnArr[1] != null) {
						Attachment attm = new Attachment();
						attm.setImgOriginalName(file.getOriginalFilename());
						attm.setImgRename(returnArr[1]);
						attm.setImgPath(returnArr[0]);
						
						list.add(attm);
					}
				}
			}
		}
		
		for(int i = 0; i < list.size(); i++) {
			Attachment a = list.get(i);
			if(i == 0) {
				a.setLevel(0);
			} else {
				a.setLevel(1);
			}
				a.setBoardType(2);
		}
		
		int attmResult = 0;
		
		if(!list.isEmpty()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			attmResult = cService.insertAttm(map);
		}
		
		if(boardResult + attmResult == list.size() + 2) {
				return "redirect:commuAllList.co";
		} else {
			for(Attachment a : list) {
				deleteFile(a.getImgRename(), request);
			}
			throw new BoardException("글이 정상적으로 등록되지 않았습니다.");
		}
	}
	
	// 파일 저장
	public String[] saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\uploadFiles";
		
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		int ranNum = (int)(Math.random()*100000);
		String originFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + ranNum + originFileName.substring(originFileName.lastIndexOf("."));
		
		String renamePath = folder + "\\" + renameFileName;
		
		try {
			file.transferTo(new File(renamePath));
		} catch (Exception e) {
			System.out.println("파일 전송 에러 : " + e.getMessage());
		}
		
		String[] returnArr = new String[2];
		returnArr[0] = savePath;
		returnArr[1] = renameFileName;
		
		return returnArr;
	}
	
	// 파일 삭제
	public void deleteFile(String fileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\uploadFiles";
		
		File f = new File(savePath + "\\" + fileName);
		if(f.exists()) {
			f.delete();
		}
	}
	
	/* 게시글 상세보기 */
	// 커뮤니티 글 조회
	@RequestMapping("selectCommuBoard.co")
	public ModelAndView selectCommuBoard(@RequestParam("bNo") int bNo, @RequestParam(value="writer", required=false) String writer, ModelAndView mv, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		WishList wl = new WishList();
		WishList wishList = null;
		
		String login = null;
		
		if(loginUser != null) {
			login = loginUser.getMemberId();
			wl.setBoardNo(bNo);
			wl.setMemberId(loginUser.getMemberId());
			wishList = cService.selectSymptOn(wl);
		}
		
		boolean yn = false;
		if(!writer.equals(login)) {
			yn = true;
		}
		
		String strBNo = Integer.toString(bNo);
		
		CommuBoard coBoard = cService.selectCommuBoard(bNo, yn);
		ArrayList<Attachment> list = cService.selectAttmBoard(strBNo);
		
		ArrayList<Reply> coRList = cService.selectReply(bNo);
		
		String memberId = writer;
		Attachment profileAttm = mService.selectProfile(memberId);
		
		if(coBoard != null) {
			mv.addObject("coBoard", coBoard);
			mv.addObject("coRList", coRList);
			mv.addObject("wishList", wishList);
			mv.addObject("list", list);
			mv.addObject("profileAttm", profileAttm);
			mv.setViewName("commuBoardDetail");
		} else {
			throw new BoardException("게시글 상세보기에 실패하였습니다.");
		}
		
		return mv;
	}
	
	// 좋아요 버튼 on (사용자가 좋아요 버튼을 눌렀을 때)
	@RequestMapping("symptOn.co")
	public void symptOn(@RequestParam("boardNo") int bNo, HttpSession session, Model model, HttpServletResponse response) {
		String id = ((Member)session.getAttribute("loginUser")).getMemberId();
		
		WishList wl = new WishList();
		wl.setBoardNo(bNo);
		wl.setMemberId(id);
		
		int result = cService.symptOn(wl, bNo);
		
		response.setContentType("application/json; charset=UTF-8");
		
		GsonBuilder gb = new GsonBuilder();
		Gson gson = gb.create();
		
		try {
			gson.toJson(result, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
		
	// 좋아요 버튼 off (사용자가 좋아요 버튼을 취소했을 때)
	@RequestMapping("symptOff.co")
	public void symptOff(@RequestParam("boardNo") int bNo, HttpSession session, Model model, HttpServletResponse response) {
		String id = ((Member)session.getAttribute("loginUser")).getMemberId();
			
		WishList wl = new WishList();
		wl.setBoardNo(bNo);
		wl.setMemberId(id);
		
		int result =  cService.symptOff(wl, bNo);
		
		response.setContentType("application/json; charset=UTF-8");
		
		GsonBuilder gb = new GsonBuilder();
		Gson gson = gb.create();
		
		try {
			gson.toJson(result, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	
	/* 댓글 */
	// 커뮤니티 댓글 등록 (insert)
	@RequestMapping("insertReply.co")
	public void insertReply(@ModelAttribute Reply r, HttpServletResponse response) {
		
		int result = cService.insertReply(r);
		int bNo = r.getBoardNo();
		int result1 = cService.replyCountUp(bNo);
		
		ArrayList<Reply> list = cService.selectReply(r.getBoardNo());
		
		response.setContentType("application/json; charset=UTF-8");
		GsonBuilder gb = new GsonBuilder();
		GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd");
		Gson gson = gb2.create();
		try {
			gson.toJson(list, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	// 커뮤니티 댓글 수정 (update)
	@RequestMapping("updateReply.co")
	public void updateReply(@ModelAttribute Reply r, HttpServletResponse response) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("content", r.getReplyContent());
		map.put("rNo",r.getReplyNo());
		map.put("secret", r.getReplySecret());
		
		int result = cService.updateReply(map);
		
		ArrayList<Reply> rList = cService.selectReply(r.getBoardNo());
		
		response.setContentType("application/json; charset=UTF-8");
		GsonBuilder gb = new GsonBuilder();
		GsonBuilder gb2 =  gb.setDateFormat("yyyy-MM-dd");
		Gson gson = gb2.create();
		try {
			gson.toJson(rList, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	// 커뮤니티 댓글 삭제 (delete)
	@RequestMapping("deleteReply.co")
	public void deleteReply(@RequestParam("replyNo") int rNo, @RequestParam("boardNo") int bNo, @ModelAttribute Reply r, Model model, HttpServletResponse response) {
		int result = cService.deleteReply(rNo);
		int result1 = cService.replyCountDown(bNo);
		
		ArrayList<Reply> list = cService.selectReply(r.getBoardNo());
		
		response.setContentType("application/json; charset=UTF-8");
		GsonBuilder gb = new GsonBuilder();
		GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd");
		Gson gson = gb2.create();
		try {
			gson.toJson(list, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	// 커뮤니티 대댓글 등록 (insert)
		@RequestMapping("insertReReply.co")
		public void insertReReply(@ModelAttribute Reply r, @RequestParam("groupNo") int gNo, HttpServletResponse response) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("r", r);
			map.put("gNo", gNo);
			
			int result = cService.insertReReply(map);
			int bNo = r.getBoardNo();
			int result1 = cService.replyCountUp(bNo);
			
			ArrayList<Reply> list = cService.selectReply(r.getBoardNo());
			
			response.setContentType("application/json; charset=UTF-8");
			GsonBuilder gb = new GsonBuilder();
			GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd");
			Gson gson = gb2.create();
			try {
				gson.toJson(list, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
		}
	
	
	/* 게시글 수정 (update) */
	// 글 수정 페이지 이동
	@RequestMapping("updateForm.co")
	public String updateForm(@RequestParam("boardNo") int bNo, Model model) {
		CommuBoard coBoard = cService.selectCommuBoard(bNo, false);
		
		String strBNo = Integer.toString(bNo);
		ArrayList<Attachment> list = cService.selectAttmBoard(strBNo);
		
		model.addAttribute("coBoard", coBoard);
		model.addAttribute("list", list);
		return "commuBoardEdit";
	}
	
	// 커뮤니티 글 수정 (update)
	@RequestMapping("updateCommuBoard.co")
	public String updateCommuBoard(@ModelAttribute CommuBoard coBoard, @RequestParam(value="deleteAttm", required=false) String[] deleteAttm, @RequestParam("file") ArrayList<MultipartFile> files, HttpServletRequest request, Model model) {
		int updateBoardResult = cService.updateCommuBoard(coBoard);
		
		// 새 파일 저장
		ArrayList<Attachment> list = new ArrayList<>();
		for(MultipartFile file : files) {
			String fileName = file.getOriginalFilename();
			if(!fileName.equals("")) {
				String fileType = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
				if(fileType.equals("png") || fileType.equals("jpg") || fileType.equals("gif") || fileType.equals("jpeg") || fileType.equals("jfif")) {
					String[] returnArr = saveFile(file, request);
					
					if(returnArr[1] != null) {
						Attachment attm = new Attachment();
						attm.setImgOriginalName(file.getOriginalFilename());
						attm.setImgRename(returnArr[1]);
						attm.setImgPath(returnArr[0]);
						
						list.add(attm);
					}
				}
			}
		}
		
		// 선택한 파일들 삭제
		ArrayList<String> delRename = new ArrayList<>();
		ArrayList<Integer> delLevel = new ArrayList<>();
		
		if(deleteAttm != null) {
			for (String rename : deleteAttm) {
				if (!rename.equals("")) {
					String[] split = rename.split("/");
					delRename.add(split[0]);
					delLevel.add(Integer.parseInt(split[1]));
				}
			}
		}
		
		int deleteAttmResult = 0;
		boolean existBeforeAttm = true; // 기존 파일이 남아 있는지 확인
		
		if(!delRename.isEmpty()) { // 저장했던 첨부파일 중 하나라도 삭제하겠다고 한 경우
			deleteAttmResult = cService.deleteAttm(delRename);
			if(deleteAttmResult > 0) {
				for(String rename : delRename) {
					deleteFile(rename, request);
				}
			}
			
			if(delRename.size() == deleteAttm.length) { // 기존 파일을 전부 삭제하겠다고 한 경우
				existBeforeAttm = false;
			} else {
				for(int level : delLevel) {
					if(level == 0) {
						String strBNo = Integer.toString(coBoard.getBoardNo());
						cService.updateAttmLevel(strBNo);
						break;
					}
				}
			}
		}
		
		if(deleteAttm == null) {
			existBeforeAttm = false;
		}
		
		for(int i = 0; i < list.size(); i++) {
			Attachment a = list.get(i);
			
			if(existBeforeAttm) {
				a.setLevel(1);
			} else {
				if(i == 0) {
					a.setLevel(0);
				} else {
					a.setLevel(1);
				}
			}
			a.setBoardType(2);
		}
		
		int updateAttmResult = 0;
		String strBNo = Integer.toString(coBoard.getBoardNo());
		
		if(!list.isEmpty()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("bNo",strBNo);
			updateAttmResult = cService.insertAttm(map);
		}
		
		if(updateBoardResult + updateAttmResult == 2 + list.size()) {
			model.addAttribute("bNo", coBoard.getBoardNo());
			model.addAttribute("writer", ((Member)request.getSession().getAttribute("loginUser")).getNickName());
			return "redirect:selectCommuBoard.co";
		} else {
			for(Attachment a : list) {
				deleteFile(a.getImgRename(), request);
			}
			throw new BoardException("게시글 수정에 실패하였습니다.");
		}
	}
	
	/* 게시글 삭제 (delete) */
	@RequestMapping("deleteCommuBoard.co")
	public String deleteCommuBoard(@RequestParam("boardNo") int bNo) {
		String strBNo = Integer.toString(bNo);
		
		int result = cService.deleteCommuBoard(bNo);
		result += cService.updateAttmStatus(strBNo);
		
		if(result > 0) {
			return "redirect:commuAllList.co";
		} else {
			throw new BoardException("게시글 삭제에 실패하였습니다.");
		}
	}
	
	
	/* 신고 (report) */
	@RequestMapping("commuReport.co")
	public String commuReport(@RequestParam("boardNo") int bNo, @RequestParam("contentNo") int cNo, @ModelAttribute Report report, HttpSession session, Model model) {
		String id = ((Member)session.getAttribute("loginUser")).getMemberId();
		String writer = ((Member)session.getAttribute("loginUser")).getNickName();
		
		report.setMemberId(id);
	
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cNo", cNo);
		map.put("cate", report.getReportCate());
		
		int result = cService.commuReport(report, map);
		
		if(result > 0) {
			model.addAttribute("id", id);
			model.addAttribute("bNo", bNo);
			model.addAttribute("writer", writer);
			return "redirect:selectCommuBoard.co";
		} else {
			throw new BoardException("게시글 신고에 실패하였습니다.");
		}
	}

}
