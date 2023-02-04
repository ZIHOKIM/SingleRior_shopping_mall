package com.E1I4.project.member.controller;

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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.E1I4.project.common.Pagination;
import com.E1I4.project.common.exception.BoardException;
import com.E1I4.project.common.exception.MemberException;
import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.common.model.vo.Board;
import com.E1I4.project.common.model.vo.Cart;
import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.common.model.vo.Pay;
import com.E1I4.project.common.model.vo.Product;
import com.E1I4.project.common.model.vo.ProductInquiry;
import com.E1I4.project.common.model.vo.Reply;
import com.E1I4.project.common.model.vo.Review;
import com.E1I4.project.common.model.vo.WishList;
import com.E1I4.project.member.model.service.KakaoLogin;
import com.E1I4.project.member.model.service.MailSendService;
import com.E1I4.project.member.model.service.MemberService;
import com.E1I4.project.member.model.service.NaverLogin;
import com.E1I4.project.member.model.vo.LoginLog;
import com.E1I4.project.member.model.vo.Member;
import com.E1I4.project.member.model.vo.Order;
import com.E1I4.project.member.model.vo.ProductCancel;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService mService;
	@Autowired
	private MailSendService mss;
	@Autowired
	private KakaoLogin kl;
	@Autowired
	private NaverLogin nl;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	@RequestMapping("loginView.me")
	public String loginView() {
		return "login";
	}
	
	// 로그인
	@RequestMapping(value="login.me", method=RequestMethod.POST )
	public String login(@ModelAttribute Member m, HttpSession session, Model model) {
//		System.out.println(m);
		Member loginUser = mService.login(m);
//		System.out.println("뭔가 잘못됨:" +loginUser);
		System.out.println(bcrypt.encode(m.getMemberPwd()));  // 암호화 비밀번호
		if(bcrypt.matches(m.getMemberPwd(), loginUser.getMemberPwd())) {
			session.setAttribute("loginUser", loginUser);
//			model.addAttribute("loginUser",loginUser);
//			 System.out.println("로그인성공");
			
			LoginLog lg=mService.searchLog(loginUser.getMemberId());
			
			if(lg==null) {//이 사람 로그인이 처음로그인이면 log 테이블에 넣어줘
				int insertTime=mService.insertTime(loginUser.getMemberId());
			}else {//한번이라도 접속을 하였고 오늘날짜에 로그인이 되었는지 확인해줘
				LoginLog loginCheck=mService.loginCheck(loginUser.getMemberId());
				
				if(loginCheck!=null) {//오늘날짜에 로그인을 했으면 시간을 바꿔준다
					mService.updateTime(loginUser.getMemberId());
				}else {//마지막로그인이 어제이면 login_check값을 N으로 바꿔주고 오늘날짜 로그인 받기 
					mService.updateCheck(loginUser.getMemberId());
					mService.insertTime(loginUser.getMemberId());
				}
			}
			
			
			 return "redirect:/";
		} else {
			model.addAttribute("msg", "로그인실패");
			return "login";
		}
	}
	
	//카카오 로그인
	@RequestMapping(value="kakaoLogin.me", method=RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code,@ModelAttribute Member m, HttpSession session) {
//		System.out.println(code);
//		System.out.println(code);
		
		String accessToken = kl.getAccessToken(code);
//		System.out.println(access_Token);
		
		HashMap<String, Object> userInfo = kl.getUserInfo(accessToken);
//		System.out.println("access_Token : " + access_Token);
//		System.out.println("nickname : " + userInfo.get("nickname"));
//		System.out.println("email : " + userInfo.get("email"));
//		System.out.println("id : " + userInfo.get("kakaoId"));
		
		String memberId = (String) userInfo.get("kakaoId");
		String email = (String) userInfo.get("email");
		String memberName = (String)userInfo.get("nickname");
		
		int count = mService.checkId("kakao*"+memberId);
//		System.out.println("회원가입이 되어있는가..:"+ count);
		
		// count 1이면 로그인
		Member loginUser = null;
		if(count == 1) {
			m.setMemberId("kakao*"+memberId);
			loginUser = mService.login(m);
		
		}else if(count == 0) {
			m.setMemberId("kakao*"+memberId);
			String encPwd = bcrypt.encode(memberId);
			m.setMemberPwd(encPwd);
			m.setMemberName(memberName);
			m.setEmail(email);
			m.setNickName(memberName);
//			System.out.println(m);
			int result = mService.insertMember(m);
			
			if(result > 0) {
				m.setMemberId("kakao*"+memberId);
				loginUser = mService.login(m);
				session.setAttribute("loginUser", loginUser);
				LoginLog lg=mService.searchLog(loginUser.getMemberId());
				
				if(lg==null) {//이 사람 로그인이 처음로그인이면 log 테이블에 넣어줘
					int insertTime=mService.insertTime(loginUser.getMemberId());
				}else {//한번이라도 접속을 하였고 오늘날짜에 로그인이 되었는지 확인해줘
					LoginLog loginCheck=mService.loginCheck(loginUser.getMemberId());
					
					if(loginCheck!=null) {//오늘날짜에 로그인을 했으면 시간을 바꿔준다
						mService.updateTime(loginUser.getMemberId());
					}else {//마지막로그인이 어제이면 login_check값을 N으로 바꿔주고 오늘날짜 로그인 받기 
						mService.updateCheck(loginUser.getMemberId());
						mService.insertTime(loginUser.getMemberId());
					}
				}
				
				return "redirect:/";
			}
		}
		session.setAttribute("loginUser", loginUser);
		LoginLog lg=mService.searchLog(loginUser.getMemberId());
		
		if(lg==null) {//이 사람 로그인이 처음로그인이면 log 테이블에 넣어줘
			int insertTime=mService.insertTime(loginUser.getMemberId());
		}else {//한번이라도 접속을 하였고 오늘날짜에 로그인이 되었는지 확인해줘
			LoginLog loginCheck=mService.loginCheck(loginUser.getMemberId());
			
			if(loginCheck!=null) {//오늘날짜에 로그인을 했으면 시간을 바꿔준다
				mService.updateTime(loginUser.getMemberId());
			}else {//마지막로그인이 어제이면 login_check값을 N으로 바꿔주고 오늘날짜 로그인 받기 
				mService.updateCheck(loginUser.getMemberId());
				mService.insertTime(loginUser.getMemberId());
			}
		}
		
		return "redirect:/";
		
	}
	
	// 네이버 로그인
	@RequestMapping("naverLogin.me")
	public String naverLogin(@RequestParam(value = "code", required = false) String code,@ModelAttribute Member m, HttpSession session) {
//		System.out.println(code);
		
		String accessToken = nl.getAccessToken(code);
		
		HashMap<String, Object> userInfo = nl.getUserInfo(accessToken);
		
		String memberId = (String)userInfo.get("memberId");
		String nickname = (String)userInfo.get("nickname");
		String email = (String)userInfo.get("email");
		String phone = (String)userInfo.get("phone");
		String memberName = (String)userInfo.get("memberName");
		
		int count = mService.checkId("naver*" + memberId);
		
		Member loginUser = null;
		
		if(count == 1) {
			m.setMemberId("naver*" +memberId);
			loginUser = mService.login(m);
		}else {
			m.setMemberId("naver*" +memberId);
			String encPwd = bcrypt.encode(memberId);
			m.setMemberPwd(encPwd);
			m.setNickName(nickname);
			m.setEmail(email);
			m.setMemberName(memberName);
			m.setPhone(phone);
			
			int result = mService.insertMember(m);
			if(result>0) {
				m.setMemberId("naver*"+memberId);
				loginUser = mService.login(m);
				session.setAttribute("loginUser", loginUser);
				LoginLog lg=mService.searchLog(loginUser.getMemberId());
				
				if(lg==null) {//이 사람 로그인이 처음로그인이면 log 테이블에 넣어줘
					int insertTime=mService.insertTime(loginUser.getMemberId());
				}else {//한번이라도 접속을 하였고 오늘날짜에 로그인이 되었는지 확인해줘
					LoginLog loginCheck=mService.loginCheck(loginUser.getMemberId());
					
					if(loginCheck!=null) {//오늘날짜에 로그인을 했으면 시간을 바꿔준다
						mService.updateTime(loginUser.getMemberId());
					}else {//마지막로그인이 어제이면 login_check값을 N으로 바꿔주고 오늘날짜 로그인 받기 
						mService.updateCheck(loginUser.getMemberId());
						mService.insertTime(loginUser.getMemberId());
					}
				}
				
				return "redirect:/";
			}
		}
		
		session.setAttribute("loginUser", loginUser);
		LoginLog lg=mService.searchLog(loginUser.getMemberId());
		
		if(lg==null) {//이 사람 로그인이 처음로그인이면 log 테이블에 넣어줘
			int insertTime=mService.insertTime(loginUser.getMemberId());
		}else {//한번이라도 접속을 하였고 오늘날짜에 로그인이 되었는지 확인해줘
			LoginLog loginCheck=mService.loginCheck(loginUser.getMemberId());
			
			if(loginCheck!=null) {//오늘날짜에 로그인을 했으면 시간을 바꿔준다
				mService.updateTime(loginUser.getMemberId());
			}else {//마지막로그인이 어제이면 login_check값을 N으로 바꿔주고 오늘날짜 로그인 받기 
				mService.updateCheck(loginUser.getMemberId());
				mService.insertTime(loginUser.getMemberId());
			}
		}
		
		return "redirect:/";
	}
	// 로그아웃
	@RequestMapping("logout.me")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:home.do";
	}
	
	// 회원가입 아이디 중복체크
	@RequestMapping("checkId.me")
	@ResponseBody
	public int checkId(@RequestParam("memberId") String memberId) {
		int count = mService.checkId(memberId);
		return count;
	}
	// 회원가입 닉네임 중복체크
	@RequestMapping("checkNickName.me")
	@ResponseBody
	public int checkNickName(@RequestParam("nickName") String nickName) {
		
		int count = mService.checkNickName(nickName);
//		System.out.println(count);
		
		return count;
	}
	
	// 회원가입 이메일 중복확인
	@RequestMapping(value="checkEmailConfirm.me", method=RequestMethod.POST)
	@ResponseBody
	public String checkEmailConfirm(@RequestParam("email") String email) {
		
		int count = mService.checkEmailConfirm(email);
		
		String check = "possible";
		if(count > 0) {
			
			String knId = mService.checkKNLogin(email);
			String subStrId = knId.substring(0, 6);
			if(subStrId.equals("kakao*")) {
				check = "kakao";
			}else if(subStrId.equals("naver*")) {
				check="naver";
			}else {
				check = "impossible";
			}
		}
		return check;
	}
	
	
	// 회원가입 이메일 인증
	@RequestMapping("checkMail.me")
	@ResponseBody
	public String checkMail(@RequestParam("email") String email) {
		
//		System.out.println(email);
		return mss.sendEmail(email);
	}
	
	// 회원가입 
	@RequestMapping("insertMember.me")
	public String insertMember(@ModelAttribute Member m,Model model) {
//		System.out.println(m);
		
		String encPwd = bcrypt.encode(m.getMemberPwd());
		m.setMemberPwd(encPwd);
		
		int result = mService.insertMember(m);
		if(result > 0) {
			model.addAttribute("msg", "회원가입 성공에 성공하셨습니다.");
			return "enrollDone";
		}else {
			throw new MemberException("회원가입 실패");
		}
	}
	
	@RequestMapping("enrollView.me")
	public String enrollView(){
		return "enrollView";
	}
	
	@RequestMapping("findIdView.me")
	public String findIdView() {
		return "findIdView";
	}
	
	// 아이디 찾기
	@RequestMapping("findId.me")
	@ResponseBody
	public String findLoginId(@ModelAttribute Member m) {
		
		String id = mService.findId(m);
		if(id != null) {
			mss.findId(m.getEmail(), id);
	//		System.out.println(id);
		}else {
			throw new MemberException("아이디 찾기 실패");
		}
		return "성공";
		
		
	}
	@RequestMapping("findPwdView.me")
	public String findPwdView() {
		return "findPwdView";
	}
	
	// 비밀번호 찾기
	@RequestMapping("findPwd.me")
	@ResponseBody
	public int findPwd(@ModelAttribute Member m) {
		// 일치하는 회원 정보 
		int result = mService.findPwd(m);
		int changePwd = 0;
		//회원 정보가 있다면 메일에 임시 비밀번호 발급
		if(result >= 1) {
			String newPwd = mss.findPwd(m.getEmail());
			String encPwd = bcrypt.encode(newPwd);
			m.setMemberPwd(encPwd);
			
			changePwd = mService.changePwd(m);
		}
		
		if(changePwd >= 1) {
			return changePwd;
		}else {
			throw new MemberException("비밀번호 발급 실패");
		}
	}
	
	@RequestMapping("myPage.me")
	public String myPage(HttpSession session, Model model) {
		
		Member m = (Member)session.getAttribute("loginUser");
		// 프로필 사진 가져오기
		
		Attachment a = mService.selectProfile(m.getMemberId());
//		System.out.println(a);
			model.addAttribute("a", a);
			return "myPage";
	}
	
	@RequestMapping("checkPwd.me")
	@ResponseBody
	public String checkPwd(@RequestParam("memberPwd") String memberPwd, HttpSession session) {
		
		Member m = (Member)session.getAttribute("loginUser");
//		System.out.println(m);
		
		if(bcrypt.matches(memberPwd, m.getMemberPwd())) {
			return "true";
		} else {
			return "false";
		}
	}
	
	
	@RequestMapping("editMyInfo.me")
	public String editMyInfo(HttpSession session, Model model) {
		
		Member m = (Member)session.getAttribute("loginUser");
		// 프로필 사진 가져오기
		
		Attachment a = mService.selectProfile(m.getMemberId());
//		System.out.println(a);
		
		model.addAttribute("a", a);
		return "editMyInfo";
	}
	
	// 회원 정보 수정
	@RequestMapping("updateMember.me")
	public String updateMember(HttpServletRequest reqeust, @ModelAttribute Member m, @RequestParam(value="newPwd", required=false) String newPwd,
								HttpSession session, Model model , @RequestParam(value="file", required=false) MultipartFile file,
								HttpServletRequest request) {
		
		int count = mService.getProfilePhotoCount(m.getMemberId());
		System.out.println("new:"+newPwd);
		Attachment a = null;
		boolean check = false;
			MultipartFile upload = file;
//			System.out.println("null인가..:" + upload);
			
			if(!upload.getOriginalFilename().equals("")) {
				
				String[] returnArr = saveFile(upload, request);
//				System.out.println(returnArr);
					
				if(returnArr[1] != null) {
					a = new Attachment();
					a.setImgOriginalName(upload.getOriginalFilename());
					a.setImgRename(returnArr[1]);
					a.setImgPath(returnArr[0]);
					a.setImgKey(m.getMemberId());
					a.setBoardType(4);  // 프로필은 4로
				}
				if(count != 1) {
					int result = mService.insertProfile(a);
				}else {
					int result = mService.updateProfile(a);
				}
			}
//			System.out.println("들어왔나 : " + a);

		//회원 정보 수정
			
		if(!newPwd.trim().equals("")) {
			String encPwd = bcrypt.encode(newPwd);
			m.setMemberPwd(encPwd);
//			System.out.println("새비번있음: ");
		}else {
			m.setMemberPwd(null);
			System.out.println("새비번ㄴㄴ음: " + m);
		}
		

		int result = mService.updateMember(m);
		
		if(result > 0) {
//			System.out.println("최종 : " +a);
			model.addAttribute("profile", a);
			session.setAttribute("loginUser", mService.login(m));
			return "redirect:myPage.me";
		}else {
			throw new MemberException("비밀번호 발급 실패");
		}
	}
	
	private String[] saveFile(MultipartFile upload, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\uploadFiles";
		
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		int ranNum = (int)(Math.random()*10000);
		String originFileName = upload.getOriginalFilename();
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + ranNum
									+ originFileName.substring(originFileName.lastIndexOf("."));
		
		String renamePath = folder + "\\" + renameFileName;
		
		try {
			upload.transferTo(new File(renamePath));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		String[] returnArr = new String[2];
		returnArr[0] = savePath;
		returnArr[1] = renameFileName;
		
		return returnArr;
	}

	// 프로필 사진 기본 사진으로 변경
	@RequestMapping("deleteProfile.me")
	@ResponseBody
	public String deleteProfile(@RequestParam("memberId") String memberId) {
//		System.out.println(memberId);
		
		int result = mService.deleteProfile(memberId);
//		System.out.println(result);
		if(result>0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	// 회원탈퇴
	@RequestMapping("deleteMember.me")
	public String deleteMember(@RequestParam("memberId") String memberId) {
		if(!memberId.contains("kakao*") && !memberId.contains("naver*")) {
			int result = mService.deleteMember(memberId);
			if(result>0) {
				return "redirect:logout.me";
			} else {
				throw new MemberException("회원탈퇴를 실패하였습니다.");
			}
		}else{
			int result = mService.deleteKakaoMember(memberId);
			if(result>0) {
				return "redirect:logout.me";
			} else {
				throw new MemberException("회원탈퇴를 실패하였습니다.");
			}
		}
	}
	
	@RequestMapping("myCart.me")
	public String myCart(HttpSession session,@RequestParam(value="page", required=false) Integer page,Model model) {
		Member m = (Member)session.getAttribute("loginUser");
		
		String memberId = m.getMemberId();
		
//		System.out.println(category);
		int currentPage =1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = mService.getCartListCount(memberId);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		ArrayList<Cart> cartList = mService.selectCartList(pi,memberId);
		for(int i = 0; i<cartList.size(); i++) {
			int productNo = cartList.get(i).getProductNo();
			String imgRename = mService.selectCartImg(productNo);
			
			cartList.get(i).setImgRename(imgRename);
			double oriPrice = cartList.get(i).getProductPrice(); // 250,000
			double discount = cartList.get(i).getProductDiscount(); //20 / 100 -> 0.2 -> 1-0.2 = 0.8 			
			
			double dc = (discount/100);
			double price = oriPrice * (1-dc);
			int q = cartList.get(i).getQuantity();
//			System.out.println(q);
			int p = (int)price*q;
			cartList.get(i).setLastPrice(p);
			
		}
//		System.out.println(cartList);
		
		if(cartList != null) {
			model.addAttribute("cartList", cartList);
			model.addAttribute("pi", pi);
		}
		return "myCart";
		
	}
	
	@RequestMapping("deleteCart.me")
	public String deleteCart(@RequestParam(value="cartNo", required=false) String cartNo) {
//		System.out.println(cartNo);
		
		int result = mService.deleteCart(cartNo);
			return "redirect:myCart.me";
	}
	
	@RequestMapping("serviceCenter.me")
	public String serviceCenter(@RequestParam(value="category", required=false) String category,Model model) {
		
		HashMap<String,String> map = new HashMap<String,String>();
		if(category == null) {
			category = "전체";
		}
		
		map.put("category", category);
		ArrayList<Board> bList = mService.selectQna(category);
//		System.out.println(bList);
		
		if(bList != null) {
			model.addAttribute("bList", bList);
			model.addAttribute("category", category);
		}
		return "serviceCenter";
	}
	
	@RequestMapping("wishList.me")
	public String wishList(@RequestParam(value="page", required=false) Integer page,@RequestParam(value="category", required=false) String category,
										HttpSession session, Model model) {
		
		Member m = (Member)session.getAttribute("loginUser");
		String memberId = m.getMemberId();
		
		if(category==null) {
			category = "스토어";
		}
		
//		System.out.println(category);
		int currentPage =1;
		if(page != null) {
			currentPage = page;
		}
		
//		System.out.println(category);
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("memberId", memberId);
		map.put("category", category);
		
		int listCount = mService.getWishListCount(map);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 8);
		ArrayList<WishList> wlList = mService.selectWishList(pi,map);


		for(int i =0; i<wlList.size(); i++) {
			if(wlList.get(i).getBoardType() != 2) {
				int boardNum = wlList.get(i).getBoardNo();
				String imgKey = Integer.toString(boardNum);
				
				map.put("imgKey", imgKey);
				String imgRename = mService.getImgWishList(map);
				wlList.get(i).setImgRename(imgRename);
				
				if(wlList.get(i).getTProductNo() != 0) {
					int tProductNo = wlList.get(i).getTProductNo();
					wlList.get(i).setProductNo(tProductNo);
				}
			}
		}
		
//		System.out.println("wishList : "+wlList);
		if(wlList != null) {
			model.addAttribute("wlList", wlList);
			model.addAttribute("pi",pi);
			model.addAttribute("category", category);
		}
		
		
		return "wishList";
	}
	
	@RequestMapping("deleteWishList.me")
	public String deleteWishList(@RequestParam(value="boardNo", required=false) int boardNo,HttpSession session,@RequestParam(value="category", required=false) String category,Model model) {
		Member m = (Member)session.getAttribute("loginUser");
		String memberId = m.getMemberId();
		
//		System.out.println(boardNo);
		WishList wl = new WishList();
		wl.setMemberId(memberId);
		wl.setBoardNo(boardNo);
		
		int result = mService.deleteWishList(wl);
		
		if(result > 0) {
			model.addAttribute("category", category);
			return "redirect:wishList.me";
		}else {
			return null;
		}
		
	}
	@RequestMapping("orderList.me")
	public String orderList(HttpSession session,@RequestParam(value="status", required=false) String status,
							@RequestParam(value="page", required=false) Integer page,Model model,@RequestParam(value="date", required=false) String date) {
		Member m = (Member)session.getAttribute("loginUser");
		String memberId = m.getMemberId();
		
		int currentPage =1;
		if(page != null) {
			currentPage = page;
		}
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("memberId", memberId);
		if(status == null) {
			status = "전체";
		}
		map.put("status", status);
		
		if(date == null) {
			date = "전체";
		}
		String status2 = "noReview";
		map.put("date", date);
		map.put("status2", status2);
		int listCount = mService.getOrderListCount(map);
//		System.out.println("구매확정" + listCount);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		
		ArrayList<Order> oiList = mService.selectCommonList(pi,map);
		
		
//		System.out.println(map);
		for(int i = 0; i<oiList.size(); i++) {
			String boardNo = Integer.toString(oiList.get(i).getBoardNo());
			map.put("boardNo", boardNo);
			String img = mService.getImgOrder(map);
			oiList.get(i).setImgRename(img);
		}
		
		

		
		// 배송상태 카운트
		String[] orderStatus = {"입금대기","결제완료","배송준비","배송중","배송완료","구매확정"};
		int[] result = new int[6];
		
		for(int i = 0; i<orderStatus.length; i++) {
			
			String orStatus = orderStatus[i];
			map.put("orStatus", orStatus);
			int osResult = mService.orderStatusCount(map);
			result[i] = osResult;
//			System.out.println("result: "+result[i]);
		}
			String countStatus = Arrays.toString(result);
		
			System.out.println(oiList);
			model.addAttribute("oiList", oiList);
			model.addAttribute("countStatus", countStatus);
			model.addAttribute("pi", pi);
			model.addAttribute("status", status);
			model.addAttribute("date", date);
			
		return "orderList";
//		return null;
	}
	
	@RequestMapping("orderCommit.me")
	public String orderCommit(@RequestParam("orderDetailNo") int orderDetailNo) {
		System.out.println(orderDetailNo);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("orderDetailNo", orderDetailNo);
		int status = 1;  // 구매확정 : 1
		map.put("change", status);
		int result = mService.orderStatusChange(map);
		return "redirect:orderList.me";
	}
	
	@RequestMapping("orderCancel.me")
	public String orderCancel(@ModelAttribute ProductCancel pc) {
		
//		System.out.println(pc);
		int result = 0;
		if(pc != null) {
			result = mService.orderCancel(pc);
		}
		if(result > 0 ) {
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("orderDetailNo", pc.getOrderDetailNo());
			int status = 2;  // 주문취소 : 2
			map.put("change", status);
			int result2 = mService.orderStatusChange(map);
			if(result2 > 0 ) {
				int result3 = mService.orderProductStatusChange(pc.getOrderNo());
			}
		}
		
		return "redirect:orderList.me";
	}
	@RequestMapping("orderProductDetail.me")
	public String orderProductDetail(@RequestParam("orderNo") int orderNo,Model model) {
//		System.out.println(orderNo);
		
		ArrayList<Order> oList = mService.orderDetailList(orderNo);
		
		HashMap<String,String> map = new HashMap<String,String>();
		
		for(int i = 0; i<oList.size(); i++) {
			String boardNo = Integer.toString(oList.get(i).getBoardNo());
			map.put("boardNo", boardNo);
			String img = mService.getImgOrder(map);
			oList.get(i).setImgRename(img);
		}
		
		Pay pay = mService.getPayInfo(orderNo);
		
		
//		System.out.println(oList);
		
		model.addAttribute("oList", oList);
		model.addAttribute("pay", pay);
		return "orderProductDetail";
	}
	
	@RequestMapping("changeDeliveryAddress.me")
	public void changeDeliveryAddress(@ModelAttribute Order order,HttpServletResponse response) {
		
//		System.out.println("oder" +order);
		int result = mService.changeDeliveryAddress(order);
		response.setContentType("application/json; charset=UTF-8");
		GsonBuilder gb = new GsonBuilder();
		Gson gson = gb.create();
		
		if(result>0) {
			try {
				gson.toJson(order, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
		}
	}
	@RequestMapping("orderCancelList.me")
	public String orderCancelList(HttpSession session,@RequestParam(value="page", required=false) Integer page,Model model) {
		Member m = (Member)session.getAttribute("loginUser");
		String memberId = m.getMemberId();
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("memberId", memberId);
		
		int currentPage =1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = mService.getOrderCancelCount(map);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		ArrayList<Order> ocList = mService.orderCancelList(map,pi);
		
//		ProductCancel pc = new ProductCancel();
		ArrayList<ProductCancel> pcList = new ArrayList<ProductCancel>();
		
		for(int i = 0; i<ocList.size(); i++) {
			int orderDetailNo = ocList.get(i).getOrderDetailNo();
			String boardNo = Integer.toString(ocList.get(i).getBoardNo());
			map.put("boardNo", boardNo);
			String img = mService.getImgOrder(map);
			ocList.get(i).setImgRename(img);
			
			ProductCancel pc = mService.getProductCancel(orderDetailNo);
			pcList.add(pc);
		}
		
		
//		System.out.println(ocList);
		model.addAttribute("pcList", pcList);
		model.addAttribute("ocList", ocList);
		model.addAttribute("pi", pi);
		return "orderCancelList";
		
	}
	@RequestMapping("myReviewDoneList.me")
	public String myReviewList(HttpSession session,@RequestParam(value="page", required=false) Integer page,Model model) {
		Member m = (Member)session.getAttribute("loginUser");
		
		String memberId = m.getMemberId();
		
		int currentPage =1;
		if(page != null) {
			currentPage = page;
		}
		
		HashMap<String,String> map = new HashMap<String,String>();
		String status = "리뷰작성";
		String status2 = "review";
		map.put("memberId", memberId);
		map.put("status", status);
		map.put("status2", status2);
		
		int listCount = mService.getOrderListCount(map);
//		System.out.println("review" +listCount);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		
		ArrayList<Order> orList = mService.selectCommonList(pi,map);

		
		ArrayList<Review> rList = new ArrayList<Review>();
		
		ArrayList<Attachment> attmList = mService.selectReviewAttmList();
		
//		System.out.println(attmList);
		
		
		for (int i = 0; i<orList.size(); i++) {
			String boardNo = Integer.toString(orList.get(i).getBoardNo());
			
			map.put("boardNo", boardNo);
			String img = mService.getImgOrder(map);
			orList.get(i).setImgRename(img);

			int orderDetailNo = orList.get(i).getOrderDetailNo();
			Review r = mService.getMyReviewList(orderDetailNo);
			
			int reviewNo = r.getReviewNo();
			
			String reviewNoStr = Integer.toString(reviewNo);
			String rImg = mService.getImgReview(reviewNoStr);
			
			System.out.println("dssdd"+rImg);
			r.setImgRename(rImg);

//			System.out.println("뭐지..?"+r);
			rList.add(r);
			
		}
		
//		System.out.println("rList : "+rList);
		
//		System.out.println("dd" +orList);
//		if(orList != null) {
			model.addAttribute("orList", orList);
			model.addAttribute("rList", rList);
			model.addAttribute("pi", pi);
			model.addAttribute("attmList", attmList);
//		}
		return "myReviewDoneList";
//		return null;
	}
	@RequestMapping("myReviewNDoneList.me")
	public String myReviewNDoneList(HttpSession session,@RequestParam(value="page", required=false) Integer page,Model model) {
		Member m = (Member)session.getAttribute("loginUser");
		
		String memberId = m.getMemberId();
		
		int currentPage =1;
		if(page != null) {
			currentPage = page;
		}
		
		HashMap<String,String> map = new HashMap<String,String>();
		String status = "구매확정";
		String status2 = "review";
		
		map.put("memberId", memberId);
		map.put("status", status);
		map.put("status2", status2);
		
		int listCount = mService.getOrderListCount(map);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		
		ArrayList<Order> orList = mService.selectCommonList(pi,map);
		
		for (int i = 0; i<orList.size(); i++) {
			String boardNo = Integer.toString(orList.get(i).getBoardNo());
			map.put("boardNo", boardNo);
			String img = mService.getImgOrder(map);
			
			orList.get(i).setImgRename(img);
		}
//		System.out.println("dd" +orList);
		if(orList != null) {
			model.addAttribute("orList", orList);
			model.addAttribute("pi", pi);
		}
		
		return "myReviewNDoneList";
	}
	@RequestMapping("insertReview.me")
	public String insertReview(@RequestParam("orderDetailNo") int orderDetailNo, @ModelAttribute Review review, @RequestParam(value="file", required=false) MultipartFile file, HttpServletRequest request) {
		String id = ((Member)request.getSession().getAttribute("loginUser")).getMemberId();
		
		review.setMemberId(id);
		review.setOrderDetailNo(orderDetailNo);
		
		int reviewResult = mService.insertReview(review);
		
		System.out.println(review.getReviewNo());
		
		if(file != null) {
			String fileName = file.getOriginalFilename();
			
			if(fileName != "") {
				Attachment attm = new Attachment();
				
				System.out.println("새로 들어온 파일 이름" + fileName);
				
				String fileType = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
				
				if(fileType.equals("png") || fileType.equals("jpg") || fileType.equals("gif") || fileType.equals("jpeg") || fileType.equals("jfif")) {
					String[] returnArr = saveFile(file, request);
					
					if(returnArr[1] != null) {
						attm.setImgOriginalName(file.getOriginalFilename());
						attm.setImgRename(returnArr[1]);
						attm.setImgPath(returnArr[0]);
						attm.setBoardType(7);
					}
				}
				
				String strBNo = Integer.toString(review.getReviewNo());
				
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("attm", attm);
				map.put("reviewNo", strBNo);
				
				int attmResult = mService.insertReviewAttm(map);
			}
		}
		
		String status = "리뷰작성";
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("status", status);
		map1.put("orderDetailNo", orderDetailNo);
		
		int updateReviewStatus = mService.updateReviewStatus(map1);
		
		if(reviewResult + updateReviewStatus == 2) {
			return "redirect:myReviewDoneList.me";
		} else {
			throw new BoardException("글이 정상적으로 등록되지 않았습니다.");
		}
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
	
	@RequestMapping("updateReview.me")
	public String updateReview(@ModelAttribute Review review, @RequestParam(value="deleteAttm", required=false) String deleteAttm, @RequestParam(value="file", required=false) MultipartFile file, HttpServletRequest request, Model model) {
		String id = ((Member)request.getSession().getAttribute("loginUser")).getMemberId();
		
		review.setMemberId(id);
		
		System.out.println("리뷰넘버 : " + review.getReviewNo());
		System.out.println("보드넘버 : " + review.getBoardNo());
		System.out.println("리뷰내용 : " + review.getReviewContent());
		System.out.println("user : " + review.getMemberId());
		System.out.println("주문디테일넘버 : " + review.getOrderDetailNo());
		System.out.println("별점 : " + review.getReviewRating());
		System.out.println("이미지 이름 : " + review.getImgRename());
		System.out.println("deleteAttm : " + deleteAttm);
		
		// 기존에 첨부된 사진을 삭제한다고 한 경우
		if(deleteAttm.equals("0")) {
			int deleteAttmResult = mService.deleteReviewAttm(review.getReviewNo());
			deleteFile(review.getImgRename(), request);
		}
		
		// 새로운 리뷰 사진 등록
		if(file != null) {
			String fileName = file.getOriginalFilename();
			
			if(fileName != "") {
				Attachment attm = new Attachment();
				
				System.out.println("새로 들어온 파일 이름" + fileName);
				
				String fileType = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
				
				if(fileType.equals("png") || fileType.equals("jpg") || fileType.equals("gif") || fileType.equals("jpeg") || fileType.equals("jfif")) {
					String[] returnArr = saveFile(file, request);
					
					if(returnArr[1] != null) {
						attm.setImgOriginalName(file.getOriginalFilename());
						attm.setImgRename(returnArr[1]);
						attm.setImgPath(returnArr[0]);
						attm.setBoardType(7);
					}
				}
				
				String strBNo = Integer.toString(review.getReviewNo());
				
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("attm", attm);
				map.put("reviewNo", strBNo);
				
				int attmResult = mService.insertReviewAttm(map);
			}
		}
		
		int updateReviewResult = mService.updateReview(review);
		
		if(updateReviewResult > 0) {
			return "redirect:myReviewDoneList.me";
		}else {
			deleteFile(review.getImgRename(), request);
			throw new BoardException("리뷰가 정상적으로 수정되지 않았습니다.");
		}
	}
	
	@RequestMapping("deleteReview.me")
	public String deleteReview(@RequestParam("reviewNo") int reviewNo, @RequestParam("orderDetailNo") int orderDetailNo) {
		String strRNo = Integer.toString(reviewNo);
		
		System.out.println(reviewNo);
		System.out.println(orderDetailNo);
		
		int selectAttmCount = mService.selectAttmCount(strRNo);
		
		if(selectAttmCount == 1) {
			System.out.println("이미지 1개 존재");
			int deleteAttmResult = mService.deleteReviewAttm(reviewNo);
		} else {
			System.out.println("이미지 없음");
		}
		
		int result = mService.deleteReview(reviewNo);
		
		String status = "구매확정";
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("status", status);
		map.put("orderDetailNo", orderDetailNo);
		
		int updateReviewStatus = mService.updateReviewStatus(map);
		
		if(result + updateReviewStatus == 2) {
			return "redirect:myReviewDoneList.me";
		} else {
			throw new BoardException("리뷰 삭제에 실패하였습니다.");
		}
	}
	
	@RequestMapping("myAskList.me")
	public String myAskList(HttpSession session,@RequestParam(value="page", required=false) Integer page,Model model) {
		Member m = (Member)session.getAttribute("loginUser");
		String memberId = m.getMemberId();
		
		int currentPage =1;
		if(page != null) {
			currentPage = page;
		}
		
		String status = "yet";
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("memberId", memberId);
		map.put("status", status);
		int listCount = mService.getMyAskListCount(map);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		
		ArrayList<ProductInquiry> piList = mService.selectMyAskList(pi, map);
		ArrayList<Attachment> aList = new ArrayList<Attachment>();
		ArrayList<Product> pList = new ArrayList<Product>();
//		System.out.println("listCount" +listCount);
//		System.out.println(piList);
		
		for(int i = 0; i<piList.size(); i++) {
			int productNo = piList.get(i).getProductNo();
			Attachment a = mService.getImageProduct(productNo);
			System.out.println(a);
			if(a != null ) {
				String boardNo = a.getImgKey();
				Product p = mService.getDetailProduct(boardNo);
				aList.add(a);
				pList.add(p);
			}
			
		}
		
//		System.out.println("aList :" +aList);
//		System.out.println("pList :" +pList);
		
		if(piList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("piList", piList);
			model.addAttribute("aList", aList);
			model.addAttribute("pList", pList);
			
		}
		
		return "myAskList";
	}
	@RequestMapping("myAskDoneList.me")
	public String myAskDoneList(HttpSession session,@RequestParam(value="page", required=false) Integer page,Model model) {
		Member m = (Member)session.getAttribute("loginUser");
		String memberId = m.getMemberId();
		
		int currentPage =1;
		if(page != null) {
			currentPage = page;
		}
		
		String status = "done";
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("memberId", memberId);
		map.put("status", status);
		int listCount = mService.getMyAskListCount(map);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		
		ArrayList<ProductInquiry> piList = mService.selectMyAskList(pi, map);
//		System.out.println(piList);
		ArrayList<Attachment> aList = new ArrayList<Attachment>();
		ArrayList<Product> pList = new ArrayList<Product>();
		
		for(int i = 0; i<piList.size(); i++) {
			int productNo = piList.get(i).getProductNo();
			Attachment a = mService.getImageProduct(productNo);
			String boardNo = a.getImgKey();
//			System.out.println("QDDF" +boardNo);
			Product p = mService.getDetailProduct(boardNo);
			
			aList.add(a);
			pList.add(p);
		}
		
		if(piList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("piList", piList);
			model.addAttribute("aList", aList);
			model.addAttribute("pList", pList);
			
		}
		
		return "myAskDoneList";
	}
	
	@RequestMapping("deleteInquiry.me")
	public String deleteInquiry(@RequestParam("inquiryNo") int inquiryNo, @RequestParam("cate") String cate,Model model) {
		
		System.out.println(inquiryNo);
		int result = mService.deleteInquiry(inquiryNo);
		
		if(cate.equals("done")) {
			return "redirect:myAskDoneList.me";
		}else {
			return "redirect:myAskList.me";
		}
		
	}
	@RequestMapping("myContentList.me")
	public String myContentList(@RequestParam(value="page", required=false) Integer page, HttpSession session, Model model) {
		Member m = (Member)session.getAttribute("loginUser");
		String memberId = m.getMemberId();
		
		int currentPage =1;
		if(page != null) {
			currentPage = page;
		}
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
//		map.put("category", category);
		int listCount = mService.getMyContentListCount(map);
//		System.out.println(listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		
		ArrayList<Board> bList = mService.selectBoardList(pi, map);
		
		for(int i=0; i< bList.size(); i++) {
			int boardNo = bList.get(i).getBoardNo();
			int likeCount = mService.getLikeCount(boardNo);
			int replyCount = mService.getReplyCount(boardNo);
			bList.get(i).setLikeCount(likeCount);
			bList.get(i).setReplyCount(replyCount);
		}
		
//		System.out.println(bList);
		
		if(bList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("bList", bList);
//			model.addAttribute("category",category);
		}
		return "myContentList";
	}
	
	@RequestMapping("selectContentCategory.me")
	public String selectCategory(@RequestParam(value="page", required=false) Integer page, @RequestParam("category") String category,HttpSession session,
									Model model) {
//		System.out.println(category);
		Member m = (Member)session.getAttribute("loginUser");
		String memberId = m.getMemberId();
		
		int currentPage =1;
		if(page != null) {
			currentPage = page;
		}
//		System.out.println(currentPage);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("category", category);
		int listCount = mService.getMyContentListCount(map);
//		System.out.println(listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		
		ArrayList<Board> bList = mService.selectBoardList(pi, map);
		
		for(int i=0; i< bList.size(); i++) {
			int boardNo = bList.get(i).getBoardNo();
			int likeCount = mService.getLikeCount(boardNo);
			int replyCount = mService.getReplyCount(boardNo);
			bList.get(i).setLikeCount(likeCount);
			bList.get(i).setReplyCount(replyCount);
		}
		
		if(bList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("bList", bList);
			model.addAttribute("category",category);
		}
		return "myContentList";
	}
	
	@RequestMapping("myReplyList.me")
	public String myReplyList(@RequestParam(value="page", required=false) Integer page,HttpSession session, Model model) {
		Member m = (Member)session.getAttribute("loginUser");
		
		String memberId = m.getMemberId();
		int currentPage =1;
		if(page != null) {
			currentPage = page;
		}
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		
		int listCount = mService.getMyReplyListCount(map);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
//		System.out.println(listCount);
		ArrayList<Reply> rList = mService.selectReplyList(pi, map);
		
		
//		System.out.println(rList);
		ArrayList<Board> bList = new ArrayList<Board>();
		Board b = new Board();
		HashMap<String, Integer> replyMap = new HashMap<String, Integer>();
		for(int i = 0; i<rList.size(); i++) {
			int boardNo = rList.get(i).getBoardNo();
			
			replyMap.put("boardNo", boardNo);
			b = mService.selectReplyBoardList(replyMap);
//			System.out.println(b);
			
			bList.add(b);
		}
//		System.out.println(bList);
		
		if(rList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("rList", rList);
			model.addAttribute("bList", bList);
		}
		return "myReplyList";
	}
	
	@RequestMapping("selectReplyCategory.me")
	public String selectReplyCategory(@RequestParam(value="page", required=false) Integer page,@RequestParam("category") String category,HttpSession session,
										Model model) {
//		System.out.println(category);
		Member m = (Member)session.getAttribute("loginUser");
		
		String memberId = m.getMemberId();
		
		int currentPage =1;
		if(page != null) {
			currentPage = page;
		}
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("category", category);
		
		int listCount = mService.getMyReplyListCount(map);
//		System.out.println("ddd : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		
		ArrayList<Reply> rList = mService.selectReplyList(pi, map);
		
		
//		System.out.println(rList);
		ArrayList<Board> bList = new ArrayList<Board>();
		Board b = new Board();
		HashMap<String, Integer> replyMap = new HashMap<String, Integer>();
		for(int i = 0; i<rList.size(); i++) {
			int boardNo = rList.get(i).getBoardNo();
			
			replyMap.put("boardNo", boardNo);
			b = mService.selectReplyBoardList(replyMap);
//			System.out.println(b);
			
			bList.add(b);
		}
//		System.out.println(bList);
		
		if(rList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("rList", rList);
			model.addAttribute("bList", bList);
			model.addAttribute("category", category);
		}
		return "myReplyList";
	}
}
