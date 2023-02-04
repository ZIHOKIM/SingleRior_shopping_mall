package com.E1I4.project.marketBoard.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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

import com.E1I4.project.common.Pagination;
import com.E1I4.project.common.exception.BoardException;
import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.common.model.vo.Reply;
import com.E1I4.project.common.model.vo.Report;
import com.E1I4.project.common.model.vo.WishList;
import com.E1I4.project.marketBoard.model.service.MarketBoardService;
import com.E1I4.project.marketBoard.model.vo.MarketBoard;
import com.E1I4.project.member.model.service.MemberService;
import com.E1I4.project.member.model.vo.Member;
import com.E1I4.project.notiBoard.model.service.NotiBoardService;
import com.E1I4.project.notiBoard.model.vo.NotiBoard;
import com.E1I4.project.storeBoard.model.service.StoreBoardService;
import com.E1I4.project.storeBoard.model.vo.StoreBoard;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;

@Controller
public class MarketBoardController {

	Gson gson = new Gson();
	
	@Autowired
	private MarketBoardService mkService;
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private NotiBoardService nService;
	
	@Autowired
	private StoreBoardService sService;
	//글리스트
	@RequestMapping("marketBoardList.ma")
	public String marketBoardList(@RequestParam(value="page", required=false) Integer page, @RequestParam(value="productNo", required=false) Integer productNo,Model model, @RequestParam(value="marketType", required=false) Integer mkType,
			   @RequestParam(value="marketSearch", required=false) String search, @RequestParam(value="searchType", required=false) Integer sType, @RequestParam(value="marketArray", required=false) Integer mkArray) {
		
		//boardType 3 market
		//marketType 같이사요 1, 팝니다2, 삽니다3
		//marketArray 조회수1, 댓글2 
		//searchType 1제목, 2내용, 3글쓴이
		
		int marketType = 0;
		if(mkType != null ) {
			marketType = mkType;
		}
		
		int marketArray = 0;
		if(mkArray != null) {
			marketArray = mkArray;
		}
		
		String marketSearch = null;
		int searchType= 0;
		if(search != null && sType!=null) {
			marketSearch = search;
			searchType = sType;
		}
		
		
		int currentPage = 1;
		if(page != null && page > 1) {
			currentPage = page;
		}
		
		
		
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("marketType", marketType);
		map.put("marketArray", marketArray);
		map.put("marketSearch", marketSearch);
		map.put("searchType", searchType);
		
		int listCount = mkService.getMkListCount(map);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 12);
		ArrayList<MarketBoard> mkBList = mkService.marketBoardList(pi, map);
		ArrayList<Attachment> mkAList = mkService.attmListSelect();
		ArrayList<MarketBoard> topBList = mkService.marketTopList(map);
		
		if(mkBList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("mkBList", mkBList);
			model.addAttribute("mkAList", mkAList);
			model.addAttribute("topBList", topBList);
			model.addAttribute("marketArray", marketArray);
			model.addAttribute("marketType", marketType);
			
			return "marketBoardList";
		} else {
			throw new BoardException("게시글 조회 실패");
		}
	}
	
	//공지사항 리스트
	@RequestMapping("marketNotiBoardList.ma")
	public String selectNotiAllList(@RequestParam(value="page", required=false) Integer page, Model model) {
	
		String noticeCategory = "씽씽마켓";
		
		int currentPage = 1;
		if(page != null && page > 1) {
			currentPage = page;
		}
		
		int listCount = nService.getNotiListCount(noticeCategory);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);
		
		ArrayList<NotiBoard> notiList = nService.selectNotiAllList(pi, noticeCategory);
		
		if(notiList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("notiList", notiList);
			return "marketNotiBoardList";
		} else {
			throw new BoardException("게시글 목록 조회에 실패하였습니다.");
		}
	}
	
	
	//글작성페이지
	@RequestMapping("marketBoardWrite.ma")
	public String marketBoardWrite(Model model,@ModelAttribute StoreBoard sBoard) {
		System.out.println(sBoard);
		model.addAttribute("sBoard", sBoard);
		return "marketBoardWrite";
	}
	
	//글insert
	@RequestMapping("marketBoardInsert.ma")
	public String marketBoardInsert(HttpServletRequest request,@ModelAttribute MarketBoard mkBoard,@RequestParam(value="productNo", required=false) Integer pn,@RequestParam(value="file", required=false) ArrayList<MultipartFile> files ) {
		String id = ((Member)request.getSession().getAttribute("loginUser")).getMemberId();
		mkBoard.setWriter(id);
		mkBoard.setMarketType(mkBoard.getMarketType());
		int productNo = 0;
		if(pn != 0) {
			productNo = pn;
		}
		mkBoard.setProductNo(productNo);
		
		System.out.println(mkBoard);
		
		int boardResult = mkService.marketBoardInsert(mkBoard);
		
		ArrayList<Attachment> list = new ArrayList<>();
		
		if(files!=null) {
			for(MultipartFile file : files) {
				String fileName = file.getOriginalFilename();
				if(!fileName.equals("")) {
					String fileType = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
					
					if(fileType.equals("png")||fileType.equals("webp")|| fileType.equals("jpg") || fileType.equals("gif") || fileType.equals("jpeg") || fileType.equals("jfif")) {
						
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
		}
		for(int i = 0; i < list.size(); i++) {
			Attachment a = list.get(i);
			if(i == 0) {
				a.setLevel(0);
			} else {
				a.setLevel(1);
			}
				a.setBoardType(3);
		}
		
		int attmResult = 0;
		
		if(!list.isEmpty()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			attmResult = mkService.insertAttm(map);
		}
		
		if(boardResult + attmResult == list.size()+2) {
				return "redirect:marketBoardList.ma";
		} else {
			for(Attachment a : list) {
				deleteFile(a.getImgRename(), request);
			}
			throw new BoardException("게시글 작성 실패");
		}
	}
	
	//파일 삭제
	public void deleteFile(String fileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\uploadFiles";
		
		File folder = new File(savePath + "\\" + fileName);
		if(folder.exists()) {
			folder.delete();
		}
	}
	
	//파일저장
	private String[] saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\uploadFiles";
		
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		int ranNum = (int)(Math.random()*10000);
		String originFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + ranNum
											+ originFileName.substring(originFileName.lastIndexOf("."));
		
		String renamePath = folder + "\\" + renameFileName;
		
		try {
			file.transferTo(new File(renamePath));
		} catch (Exception e) {
			System.out.println("파일 전송 에러" + e.getMessage());
		}
		
		String[] returnArr = new String[2];
		returnArr[0] = savePath;
		returnArr[1] = renameFileName;
		
		return returnArr;
	}
	
		//상세페이지
		@RequestMapping("marketBoardDetail.ma")
		public String marketBoardDetail(@RequestParam("bNo") int bNo, @RequestParam(value="boardWriter", required=false) String boardWriter, @RequestParam(value="productNo", required=false) Integer productNo ,HttpSession session, Model model) {
			Member loginUser = (Member)session.getAttribute("loginUser");
			boolean yn = true;
			String strBNo = Integer.toString(bNo);
			if(loginUser != null && boardWriter != null) {
				String id = loginUser.getMemberId();
				if(id.equals(boardWriter)) {
					yn = false;
				}
			}
			
			WishList wl = new WishList();
			WishList wishList = null;
			
			if(loginUser != null) {
				wl.setBoardNo(bNo);
				wl.setMemberId (loginUser.getMemberId());
				wishList = mkService.wishListSelect(wl);
			}
			String id = " ";
			if(loginUser !=null) {
				 id = loginUser.getMemberId();
			}
			
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("bNo",bNo);
			
			Report reportSelect =  mkService.reportSelect(map);
			
			MarketBoard mkBoard = mkService.marketBoardSelect(bNo, yn);
			ArrayList<Attachment> mkAList = mkService.selectAttm(strBNo);
			ArrayList<Reply> mkRList = mkService.replySelect(bNo);
			
			StoreBoard sBoard = null;
			if(productNo !=null) {
				 sBoard = mkService.selectProduct(productNo);
				 System.out.println(sBoard);
				 model.addAttribute("sBoard", sBoard);
				 
			}
			
			
			Member m = new Member();
			m.setMemberId(boardWriter);
			m = mService.login(m);
			
			String memberId = boardWriter;
			Attachment profileAttm = mService.selectProfile(memberId);
			
			if(mkBoard != null) {
				
				model.addAttribute("mkBoard", mkBoard);
				model.addAttribute("mkAList", mkAList);
				model.addAttribute("wishList", wishList);
				model.addAttribute("mkRList", mkRList);
				model.addAttribute("reportSelect", reportSelect);
				model.addAttribute("sBoard", sBoard);
				
				return "marketBoardDetail";
			
			} else {
				throw new BoardException("게시글 조회 실패.");
			}
		}


		//댓글 insert
		@RequestMapping("replyInsert.ma")
		public void replyInsert(@ModelAttribute Reply reply, HttpSession session,HttpServletResponse response ) {
			String id = ((Member)session.getAttribute("loginUser")).getMemberId();
			reply.setMemberId(id);
			int result = mkService.replyInsert(reply);
			int bNo = reply.getBoardNo();
			int result1 = mkService.replyCount(bNo);
			ArrayList<Reply> mkRList= mkService.replySelect(bNo);
			
			response.setContentType("application/json; charset=UTF-8");
			GsonBuilder gb = new GsonBuilder();
			GsonBuilder gb2 =  gb.setDateFormat("yyyy-MM-dd");
			Gson gson = gb2.create();
			
			try {
				gson.toJson(mkRList, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}

		
		}
		
		// 댓글 삭제
		@RequestMapping("replyDelete.ma")
		public void replyDelete(@RequestParam("rNo") int rNo, @RequestParam("bNo") int bNo, Model model,HttpServletResponse response) {
			int result = mkService.replyDelete(rNo);
			int result1 = mkService.replyCancelCount(bNo);
			ArrayList<Reply> r= mkService.replySelect(bNo);
			response.setContentType("application/json; charset=UTF-8");
			
			GsonBuilder gb = new GsonBuilder();
			Gson gson = gb.create();
			
			try {
				gson.toJson(r, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
		}
		
		//댓글 수정
		@RequestMapping("replyUpdate.ma")
		public void replyUpdate(@ModelAttribute Reply reply, HttpServletResponse response ) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("content", reply.getReplyContent());
			map.put("rNo",reply.getReplyNo());
			map.put("secret", reply.getReplySecret());
			
			int result = mkService.replyUpdate(map);
			ArrayList<Reply> r = mkService.replySelect(reply.getBoardNo());
			
			int replyNo = reply.getReplyNo();
			
			response.setContentType("application/json; charset=UTF-8");
			
			GsonBuilder gb = new GsonBuilder();
			GsonBuilder gb2 =  gb.setDateFormat("yyyy-MM-dd");
			Gson gson = gb2.create();

			try {
				gson.toJson(r, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}

		
		}
		
		
	

		//좋아요 Insert
		@RequestMapping("marketLike.ma")
		public void marketBoardLike(@RequestParam("boardNo") int bNo, HttpSession session, Model model, HttpServletResponse response) {
			String id = ((Member)session.getAttribute("loginUser")).getMemberId();
			WishList wl = new WishList();
			
			wl.setBoardNo(bNo);
			wl.setMemberId (id);
			
			int result = mkService.marketLike(wl);
			int result1 = mkService.likeCount(bNo);
			response.setContentType("application/json; charset=UTF-8");
			
			GsonBuilder gb = new GsonBuilder();
			Gson gson = gb.create();

			try {
				gson.toJson(result, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}

			
		}
		
		// 좋아요취소
		@RequestMapping("marketLikeCancle.ma")
		public  void marketBoardLikeCancle(@RequestParam("boardNo") int bNo, HttpSession session, Model model, HttpServletResponse response) {
			String id = ((Member)session.getAttribute("loginUser")).getMemberId();
			WishList wl = new WishList();
			
			wl.setBoardNo(bNo);
			wl.setMemberId (id);
				
			int result =  mkService.marketLikeCancle(wl);
			int result1 = mkService.likeCancleCount(bNo);
			response.setContentType("application/json; charset=UTF-8");
				
			GsonBuilder gb = new GsonBuilder();
			Gson gson = gb.create();

			try {
				gson.toJson(result, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
		}

		//게시글 수정페이지
		@RequestMapping("mkBoardUpdateView.ma")
		public String mkBoardUpdateView(@RequestParam("bNo") int bNo, Model model,@RequestParam(value="productNo", required=false) Integer pn) {
			String strBNo = Integer.toString(bNo);
			MarketBoard mkBoard= mkService.marketBoardSelect(bNo, false);
			ArrayList<Attachment> mkAList = mkService.selectAttm(strBNo);
			int productNo = 0;
			StoreBoard sBoard = null;
			if(pn != 0) {
				productNo = pn;
				
				sBoard = mkService.selectProduct(productNo);
			}
			if(mkBoard != null) {
				model.addAttribute("mkBoard", mkBoard);
				model.addAttribute("mkAList", mkAList);
				model.addAttribute("sBoard", sBoard);
				return "marketBoardEdit";
			} else {
				throw new BoardException("게시글 조회 실패.");
			}
		}
			
			
		// 게시글 수정
		@RequestMapping("marketBoardUpdate.ma")
		public String updateVolBoard(@ModelAttribute MarketBoard mkBoard, @RequestParam(value="deleteAttm", required = false) String[] deleteAttm, 
									 @RequestParam(value="file", required = false) ArrayList<MultipartFile> files, HttpServletRequest request, Model model) {
			int boardResult = mkService.marketboardUpdate(mkBoard);
			// 새파일 저장
			ArrayList<Attachment> list = new ArrayList<>();
			for(MultipartFile file : files) {
				String fileName = file.getOriginalFilename();
				if(!fileName.equals("")) {
					String fileType = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
					if(fileType.equals("png")||fileType.equals("webp")|| fileType.equals("jpg") || fileType.equals("gif") || fileType.equals("jpeg") || fileType.equals("jfif")) {
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
			boolean existBeforeAttm = true;  // 기존 파일이 남아 있는지 확인
				
			if(!delRename.isEmpty()) {
				deleteAttmResult = mkService.deleteAttm(delRename);
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
							String strBNo = Integer.toString(mkBoard.getBoardNo());
							mkService.AttmLevelUpdate(strBNo);
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
					a.setBoardType(3);
				}
				
			int attmResult = 0;
			String strBNo = Integer.toString( mkBoard.getBoardNo());
				
			if(!list.isEmpty()) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("list", list);
				map.put("bNo",strBNo);
				
				attmResult = mkService.insertAttm(map);
			}
			
			if(boardResult + attmResult == 2+list.size()) {
				model.addAttribute("bNo", mkBoard.getBoardNo());
				model.addAttribute("boardWriter", mkBoard.getWriter());
				return "redirect:marketBoardDetail.ma";
			} else {
				for(Attachment a : list) {
					deleteFile(a.getImgRename(), request);
				}
				throw new BoardException("게시글 수정 실패");
			}
		}
			
			
			
		//게시글 삭제
		@RequestMapping("marketBoardDelete.ma")
		public String marketBoardDelete(@RequestParam("bNo") int bNo) {
			String strBNo = Integer.toString(bNo);
			int result = mkService.marketBoardDelete(bNo);
			result += mkService.updateAttmStatus(strBNo);
				
				
			if(result > 0) {
					return "redirect:marketBoardList.ma";
			} else {
				throw new BoardException("게시글 삭제 실패");
			}
		}
		
		//신고하기
		@RequestMapping("marketReport.ma")
		public String marketReport(HttpSession session, @ModelAttribute Report report, Model model,@RequestParam(value="productNo", required=false) Integer pn) {
			String id = ((Member)session.getAttribute("loginUser")).getMemberId();
			report.setMemberId(id);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("cNo",report.getContentNo());
			map.put("cate", report.getReportCate());
			
			Report reportSelect =  mkService.reportSelect(map);
			int result = mkService.updateReportStatus(map);
			int result1 = mkService.marketReport(report);
			StoreBoard sBoard = mkService.selectProduct(pn);
			if(result>0) {
				model.addAttribute("bNo", report.getBoardNo());
				model.addAttribute("reportSelect", reportSelect);
				model.addAttribute("sBoard", sBoard);
				return "redirect:marketBoardDetail.ma";
			}else {
				throw new BoardException("신고 실패");
			}
			

		}
	
}
