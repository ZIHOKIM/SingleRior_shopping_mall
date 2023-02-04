package com.E1I4.project.admin.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.E1I4.project.admin.dto.CancelProductReqDto;
import com.E1I4.project.admin.dto.CancelTotalProductReqDto;
import com.E1I4.project.admin.dto.ImportTokenDto;
import com.E1I4.project.admin.dto.ResponseDto;
import com.E1I4.project.admin.model.service.AdminService;
import com.E1I4.project.admin.model.vo.ChangeDeli;
import com.E1I4.project.admin.model.vo.MemberManage;
import com.E1I4.project.admin.model.vo.OrderPerson;
import com.E1I4.project.admin.model.vo.OrderProducts;
import com.E1I4.project.common.Pagination;
import com.E1I4.project.common.exception.AdminException;
import com.E1I4.project.common.exception.ProductException;
import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.common.model.vo.Board;
import com.E1I4.project.common.model.vo.InquiryAdmin;
import com.E1I4.project.common.model.vo.Notice;
import com.E1I4.project.common.model.vo.OrderProductDetail;
import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.common.model.vo.Product;
import com.E1I4.project.common.model.vo.ProductList;
import com.E1I4.project.common.model.vo.Qna;
import com.E1I4.project.common.model.vo.Report;
import com.E1I4.project.commuBoard.model.service.CommuBoardService;
import com.E1I4.project.marketBoard.model.service.MarketBoardService;
import com.E1I4.project.member.model.service.MemberService;
import com.E1I4.project.member.model.vo.Member;
@Controller
public class AdminController {
	
	@Autowired
	private MemberService mService;
	
	
	@Autowired
	private AdminService aService;
	
	@Autowired
	private MarketBoardService mkService;
	
	
	@Autowired
	private CommuBoardService cService;
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	
	
	@RequestMapping("index.adm")
	public String adminView(OrderProducts op,Model model) {
		ArrayList<HashMap<String,Object>> loginCount=aService.loginCount();
		ArrayList<OrderProducts> list = aService.selectOrderProducts();
		ArrayList<HashMap<String,Object>> bList = aService.dailySales();

		for(int i=0;i<list.size();i++) {
			String[] arr=list.get(i).getProducts().split(",");
			int arrLen=arr.length;
			
			if(arrLen==1) {
				list.get(i).setProducts(arr[0]);	
			}else {
				list.get(i).setProducts(arr[0]+" 외 "+(arrLen-1)+"개");
			}
		}
		model.addAttribute("list",list);
		model.addAttribute("bList",bList);
		model.addAttribute("logCount",loginCount);
		return"index";
	}
	@RequestMapping("insertProduct.adm")
	public String insertProduct() {
		return "insertProduct";
	}
	
	@RequestMapping("updateAdmin.adm")
	public String updateAdmin(@RequestParam("memberId") String memberId,Model model) {
		Member member=aService.selectMember(memberId);
		model.addAttribute("m",member);
		
		return "updateAdmin";
	}
	@RequestMapping("editAdmin.adm")
	public String editAdmin(@RequestParam("memberId") String memberId,Model model,@ModelAttribute Member m) {
		
		int result=0;
		
		if(!m.getMemberPwd().equals("")) {
			String encPwd = bcrypt.encode(m.getMemberPwd());
			m.setMemberPwd(encPwd);
			result=aService.editMember(m);
		}else {
			result=aService.editMember(m);
		}
		return"redirect:index.adm";
	}
	
	
	//회원정보관리
	@RequestMapping("manageUser.adm")
	public String manageUser(Model model, HttpSession session) {
		
		ArrayList<MemberManage> selectMember=aService.selectMemberList();
		
		System.out.println(selectMember);
		
		if(selectMember!=null) {
			model.addAttribute("mList",selectMember);
			return "manageUser";
		}else {
			throw new AdminException("유저정보 조회 실패");
		}
	}
	
	@RequestMapping("updateManageUser.adm")
	public String updateManageMember(@RequestParam("memberId") String memberId,Model model) {
		Member member=aService.selectMember(memberId);
		System.out.println(member);
		model.addAttribute("m", member);
		
		
		return "updateManageUser";
	}
	@RequestMapping("editMember.adm")
	public String editMember(Model model, @RequestParam("memberId") String memberId,@ModelAttribute Member m) {
		
		int result=0;
		
		if(!m.getMemberPwd().equals("")) {
			String encPwd = bcrypt.encode(m.getMemberPwd());
			m.setMemberPwd(encPwd);
			result=aService.editMember(m);
		}else {
			result=aService.editMember(m);
		}
		System.out.println(result);
		return"redirect:manageUser.adm";
	}
	@RequestMapping("deleteMember.adm")
	public String deleteMemberAdm(@RequestParam("memberId") String memberId) {
		if(!memberId.contains("kakao*")) {
			int result = mService.deleteMember(memberId);
			if(result>0) {
				return "redirect:manageUser.adm";
			} else {
				throw new AdminException("회원탈퇴를 실패하였습니다.");
			}
		}else{
			int result = mService.deleteKakaoMember(memberId);
			if(result>0) {
				return "redirect:manageUser.adm";
			} else {
				throw new AdminException("회원탈퇴를 실패하였습니다.");
			}
		}
	}
	//카테고리 코드 변환
	
	public int subTop(String subCategory) {
		
		
		switch(subCategory) {
		case "침대" : 
			return 101;
		case "테이블" : 
			return 102;
		case "서랍장" : 
			return 103;
		case "의자" : 
			return 104;
		case "옷장" : 
			return 105;
		case "화장대" : 
			return 106;
		case "이불" : 
			return 201;
		case "배개" : 
			return 202;
		case "커튼/블라인드" : 
			return 203;
		case "러그" : 
			return 204;
		case "식물" : 
			return 301;
		case "시계" : 
			return 302;
		case "캔들/디퓨저" : 
			return 303;
		case "윌데코/장식" : 
			return 304;
		case "냄비/프라이팬" : 
			return 401;
		case "그릇" : 
			return 402;
		case "보관용기" : 
			return 403;
		case "수저/커트러리" : 
			return 404;
		case "컵/텀블러" : 
			return 405;
		case "칼/도마" : 
			return 406;
		case "냉장고" : 
			return 501;
		case "TV/모니터" : 
			return 502;
		case "세탁기/건조기" : 
			return 503;
		case "컴퓨터/노트북/태블릿" : 
			return 504;
		case "청소기" : 
			return 505;
		case "계절가전" : 
			return 506;
		case "이어폰/헤드셋" : 
			return 601;
		case "스피커" : 
			return 602;
		case "마이크" : 
			return 603;
		case "빔프로젝터" : 
			return 604;
		case "미용가전" : 
			return 605;
		default:
			return 0;
		}
	}
	
	// 상품등록
	@RequestMapping("enrollProduct.adm")
	public String enrollProduct(@ModelAttribute Product p,@RequestParam("file") ArrayList<MultipartFile> files, HttpServletRequest request,@RequestParam("subCategory") String subCategory) {
		
		String id=((Member)request.getSession().getAttribute("loginUser")).getMemberId();
		p.setBoardWriter(id);
		p.setProductContent("상품등록");
		
		int subCate=subTop(subCategory);
		p.setProSubCateCode(subCate);
		
		
		ArrayList<Attachment> list = new ArrayList<Attachment>();
		//ArrayList안에 파일들을 넣는다.!! 
		
		for(int i=0;i<files.size();i++) {
			MultipartFile upload=files.get(i);
			
			if(!upload.getOriginalFilename().equals("")) {
			
				String[] returnArr =saveFile(upload,request);
				
				if(returnArr[1]!=null) {
					Attachment a = new Attachment();
					
					a.setImgOriginalName(upload.getOriginalFilename());
					a.setImgRename(returnArr[1]);
					a.setImgPath(returnArr[0]);
					list.add(a);
				}
			}
		}
		
		for(int i=0;i<list.size();i++) {
			Attachment a =list.get(i);
			if(i==0) {
				a.setLevel(0);
			}else {
				a.setLevel(1);
			}
				a.setBoardType(1);
		}
		
		
		int result1=aService.insertProduct(p);
		int result2=aService.insertAttm(list);
		
		if(result1>0&&result2>0) {
			return "redirect:manageProduct.adm";
		}else {
			for(Attachment a:list) {
				deleteFile(a.getImgRename(),request);
			}
			throw new ProductException("상품 등록 실패");
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
	
	//로컬에 파일 저장 
	public String[] saveFile(MultipartFile file,HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		
		//윈도우 경로
		String savePath=root+"\\uploadFiles";
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdirs();
			//폴더가 없으면 폴더를 만들어줘!!
		}
		//날짜를 이용하여 파일이름 리네임할거임 !!
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		
		int ranNum=(int)(Math.random()*100000);
		String originFileName=file.getOriginalFilename();
		String renameFileName=sdf.format(new Date(System.currentTimeMillis()))+ranNum+originFileName.substring(originFileName.lastIndexOf("."));
		// 이름을 다시 짓는다             ㄴ데이터 업로드된 날짜 및 시간          ㄴ랜덤값           뒤에 추출
		
		
		// 변경된 이름을 파일안에 저장한다.
		String renamePath=folder+"\\"+renameFileName;
		
		
			try {
				file.transferTo(new File(renamePath));
			} catch (Exception e) {
				System.out.println("파일 전송 에러"+e.getMessage());
			}
		
			String[] returnArr=new String [2];
			returnArr[0]=savePath;
			returnArr[1]=renameFileName;
		
		return returnArr;
	}
	//등록된 상품 리스트 출력
	@RequestMapping("manageProduct.adm")
	public String manageProduct(Model model) {

		ArrayList<ProductList> sList=aService.selectProductList(1);
		
		if(sList!=null) {
			model.addAttribute("sList",sList);
			return "manageProduct";
		}else {
			throw new AdminException("상품정보 조회 실패");
		}
	}
	@RequestMapping("updateProduct.adm")
	public String updateProduct(@RequestParam("productNo") int productNo,Model model) {
		ProductList p=aService.selectProductDetail(productNo);
		ArrayList<String> list= new ArrayList<>();
		int bId=p.getBoardNo();
		
		ArrayList<Attachment> aList= aService.selectAttmListDetail(bId);
		//String  옵션1, 옵션2, 옵션3,옵션4
		//String[]
		String[] option =p.getOption().split(",");
		for(int i =0;i<option.length;i++) {
			list.add(option[i]);
		}
//		System.out.println(bId);
//		System.out.println(aList);
		
		model.addAttribute("p", p);
		model.addAttribute("list",list);
		model.addAttribute("aList",aList);
		return "updateProduct";
	}
	@RequestMapping("editProduct.adm")
	public String editProduct(@ModelAttribute Product p, @RequestParam(value="deleteAttm",required=false) String[] deleteAttm,
			@RequestParam("file") ArrayList<MultipartFile> files,@RequestParam("subCategory") String subCategory,HttpServletRequest request,Model model) {
		
		int subCate=subTop(subCategory);
		p.setProSubCateCode(subCate);
		
		String id=((Member)request.getSession().getAttribute("loginUser")).getMemberId();
		p.setBoardWriter(id);
		p.setBoardType(1);
		
//		1. 새파일이 있다!!! 
		
		ArrayList<Attachment> list = new ArrayList<>();//update시 user가 기존 파일 말고 새로운 파일을 업로드 하려 할때 위 list에 담는다.
		
		for(int i=0;i<files.size();i++) { //file이 존재하면 upload에 담을 것이다.
			MultipartFile upload=files.get(i);
			
			if(!upload.getOriginalFilename().equals("")) {//업로드 파일의 오리지날 이름이 공란이 아니라면
				String[] returnArr=saveFile(upload,request);//String배열 안에 저장 save메소드는 우리가 정의 했을 때 만들었다
				//우리가 만든 메소드인 savefile의 반환값은 retuenArr[0]은 저장경로를 저장해두었고 returnArr[1]에는 리네임한 파일 이름을 집어 넣었다.
			
			if(returnArr[1]!=null) {
				Attachment a = new Attachment();
				
				a.setImgOriginalName(upload.getOriginalFilename());
				a.setImgRename(returnArr[1]);
				a.setImgPath(returnArr[0]);
				a.setBoardType(1);
				list.add(a);
				}
			}
		}
//		2.선택한 파일 삭제 
		ArrayList<String> delRename = new ArrayList<>();//내가 삭제하겠다라고 체크한 첨부파일들 리네임 리스트에 담는다.
		ArrayList<Integer> delLevel = new ArrayList<>();//내가 삭제하겠다라고 체크한 첨부파일들의 레벨(섬네일인지 아닌지)정보를 담는다.
		for(String rename: deleteAttm) {//현재 deleteAttm은 view에서 가져온 String[]의 객체 배열이다. String 객체배열 안에 있는 String 값들을 rename 넣어준다.
			if(!rename.equals("")) {
				String[] split = rename.split("/");// 슬래시 앞에 있는 것은 renameName이고 뒤에 있는 것은 섬네일 유무이다.
				delRename.add(split[0]);
				delLevel.add(Integer.parseInt(split[1]));
				
			}
		}
		
		int deleteAttmResult=0;
		boolean existBeforeAttm=true;
		
		if(!delRename.isEmpty()) {//저장 하였던 첨부파일 중 하나라도 삭제하겠다라고 한 경우
			deleteAttmResult=aService.deleteAttm(delRename);// 현재 DB에서는 Rename을 삭제 했지만 컴퓨터ㅔ 저장된 upload파일은 삭제하지 않았다.
			System.out.println(deleteAttmResult);
			if(deleteAttmResult>0) {//DB에 delete문을 실헹 하고 나온 값이 존재한다면
				for(String rename:delRename){//delRename안에 있는 스트링 값을 rename에 담고
					deleteFile(rename,request);//우리가 만든 delelteFile메소드에 접근하여 upload파일 안에 있는 파일들을 지원준다.
				}
			}
			
			if(delRename.size()==deleteAttm.length) {//숫자가 같지 않을 경우 부분삭제하거나 삭제파일이 없는경우이고 현재는 전체를 삭제하는 경우이다.
				existBeforeAttm=false;//
				
				
			}else {
				for(int level:delLevel) {
					if(level==0) {
						
						String bId=Integer.toString(p.getBoardNo());
						
						aService.updateAttmLevel(bId);
						break;
					}
				}
			}	
		}
//		새로 들어온 파일을 파일에는 저장하였지만 DB에는 저장하지 않았다.
		for(int i=0;i<list.size();i++) {
			Attachment a =list.get(i);
			
			String bId=Integer.toString(p.getBoardNo());
			a.setImgKey(bId);
		
			if(existBeforeAttm) {//이전에 넣었던 첨부파일이 존재한다
				a.setLevel(1);//새로 집어 넣은 파일은 레벨을 1로 넣는다.
			}else {
				if(i==0) {
					a.setLevel(0);
				}else {
					a.setLevel(1);
				}
			}
		}
		int updateProductResult=aService.updateProduct(p);
		int updateAttmResult=0;
		
		if(!list.isEmpty()) {
			updateAttmResult=aService.insertAttm(list);
		}
		
		if(updateProductResult+updateAttmResult>1) {
			return "redirect:manageProduct.adm";
		}else {
			throw new AdminException("상품 정보 수정 실패");
		}
	}
	@RequestMapping("deleteProduct.adm")
	public String deleteProduct(@RequestParam("productNo") int productNo) {
		 
		int result=aService.deleteProduct(productNo);
		
		if(result>0) {
			return "redirect:manageProduct.adm";
		}else {
			throw new AdminException("상품정보 수정실패");
		}
	}
	@RequestMapping("successProduct.adm")
	public String successProduct(@RequestParam("productNo") int productNo) {
		int result=aService.successProduct(productNo);

		if(result>0) {
			return "redirect:manageProduct.adm";
		}else {
			throw new AdminException("상품정보 수정 실패");
		}
		
	}
	@RequestMapping("manageOrder.adm")
	public String orderList(OrderProducts op,Model model) {
		ArrayList<OrderProducts> list = aService.selectOrderProducts();
		
		for(int i=0;i<list.size();i++) {
			String[] arr=list.get(i).getProducts().split(",");
			int arrLen=arr.length;
			
			if(arrLen==1) {
				list.get(i).setProducts(arr[0]);	
			}else {
				list.get(i).setProducts(arr[0]+" 외 "+(arrLen-1)+"개");
			}
		}
		model.addAttribute("list",list);
		return "manageOrder";
	}
	
	@RequestMapping("detailNotice.adm")
	public ModelAndView detailNotice(@RequestParam("bNo") int bNo,@RequestParam("page") int page,@RequestParam("boardWriter") String boardWriter,HttpSession session,ModelAndView mv) {
		Member m =((Member)session.getAttribute("loginUser"));
		String login=null;
		
		if(m!=null) {
			login=m.getMemberId();
		}
		
		boolean yn=false;
		if(!boardWriter.equals(login)) {
			yn=true;
		}
		Notice n= aService.detailNotice(bNo,yn);
		
		if(n!=null){
			mv.addObject("n",n);
			mv.addObject("page",page);
			mv.setViewName("detailNotice");
			return mv;
		}else {
			throw new AdminException("공지사항 상세보기 실패");
		}
	}
	
	@RequestMapping("manageNotice.adm")
	public String managerNotice(@RequestParam(value="page", required=false)Integer page,Model model) {
		
		int currentPage=1; if(page!=null) { currentPage=page; }
		 
		int listCount=aService.getListCount(4);
		 
		PageInfo pi=Pagination.getPageInfo(currentPage, listCount, 10);
		ArrayList<Notice> list =aService.selectNoticeList(pi,4);
		
		model.addAttribute("list",list);
		model.addAttribute("pi",pi);
		return "manageNotice";
	}
	@RequestMapping("insertNotice.adm")
	public String insertNotice(){
		return "insertNotice";
	}
	
	@RequestMapping("enrollNotice.adm")
	public String enrollNotice(HttpSession session, @ModelAttribute Notice n,Model model){
		String id=((Member)session.getAttribute("loginUser")).getMemberId();		
		n.setBoardWriter(id);
		n.setBoardType(4);
		
		int result=aService.enrollNotice(n);
		
		if(result>0) {
			model.addAttribute("n",n);
			
			return "redirect:manageNotice.adm";
		}else {
			throw new AdminException("공지사항 입력 실패");
		}
	}
	@RequestMapping("updateNotice.adm")
	public String updateNotice(@RequestParam("boardNo") int boardNo,@RequestParam("page") int page,Model model) {
		Notice n = aService.detailNotice(boardNo, false);
		
		model.addAttribute("n",n);
		model.addAttribute("page",page);

		return "updateNotice";
	}
	@RequestMapping("editNotice.adm")
	public String editNotice(@ModelAttribute Notice n, @RequestParam("page") int page, Model model,HttpSession session ) {
		
		n.setBoardType(4);
		int result=aService.editeNotice(n);
		
		if(result>1) {
	
			model.addAttribute("bNo",n.getBoardNo());
			model.addAttribute("writer",((Member)session.getAttribute("loginUser")).getMemberId());
			model.addAttribute("page",page);
			return "redirect:manageNotice.adm";
		}else {
			throw new AdminException("공지사항 수정실패");
			
		}
		
	}
	@RequestMapping("deleteNotice.adm")
	public String deleteNotice(@RequestParam("boardNo") int bNo) {
		int result=aService.deleteNotice(bNo);
		if(result>0) {
			return "redirect:manageNotice.adm";
		}else {
			throw new AdminException("공지사항 삭제 실패");
		}
	}
	@RequestMapping("manageQNA.adm")
	public String managerQNA(@RequestParam(value="page", required=false)Integer page,Model model) {

		int currentPage=1; if(page!=null) { currentPage=page; }
		 
		int listCount=aService.getListCount(5);
		 
		PageInfo pi=Pagination.getPageInfo(currentPage, listCount, 10);
		ArrayList<Qna> list =aService.selectQNAList(pi,5);
		
		
		model.addAttribute("list",list);
		model.addAttribute("pi",pi);
		return "manageQNA";
		
	}
	
	@RequestMapping("insertQNA.adm")
	public String insertQNA() {
		return "insertQNA";
	}
	@RequestMapping("enrollQNA.adm")
	public String enrollQNA(@ModelAttribute Qna q,HttpSession session, Model model ) {
		
		String id=((Member)session.getAttribute("loginUser")).getMemberId();
		q.setBoardWriter(id);
		q.setBoardType(5);
		
		int result=aService.enrollQNA(q);
		if(result>0) {
			model.addAttribute("q",q);
			
			return "redirect:manageQNA.adm";
		}else {
			throw new AdminException("QNA 입력 실패");
		}
	}
	@RequestMapping("detailQNA.adm")
	public ModelAndView detailQNA(@RequestParam("bNo") int bNo,@RequestParam("page") int page,@RequestParam("boardWriter") String boardWriter,HttpSession session,ModelAndView mv ) {
		
			Qna q=aService.selectQNADetail(bNo);
			
			if(q!=null) {
				mv.addObject("q",q);
				mv.addObject("page",page);
				mv.setViewName("detailQNA");
				return mv;
			}else {
				throw new AdminException("QnA 상세보기 실패");
			}
		}
	
	@RequestMapping("updateQNA.adm")
	public String updateQNA(@RequestParam("boardNo") int boardNo,@RequestParam("page") int page,Model model) {
			
		Qna q = aService.selectQNADetail(boardNo);
		
		model.addAttribute("q",q);
		model.addAttribute("page",page);

		return "updateQNA";
	}
	@RequestMapping("editQNA.adm")
	public String editQNA(@ModelAttribute Qna q,@RequestParam("page") int page, Model model) {
		
		q.setBoardType(5);
		int result = aService.editQNA(q);
		
		if(result>1) {
			model.addAttribute("bNo",q.getBoardNo());
			model.addAttribute("page",page);
			return "redirect:manageQNA.adm";
		}else {
			throw new AdminException("Q&A 게시글 수정 오류");
		}
	}
	@RequestMapping("deleteQNA.adm")
	public String deleteQNA(@RequestParam("boardNo") int bNo) {
		int result=aService.deleteQNA(bNo);
		if(result>0) {
			return "redirect:manageQNA.adm";
		}else {
			throw new AdminException("Q&A 삭제 실패");
		}
	}
	@RequestMapping("insertBanner.adm")
	public String insertBanner() {
		return "insertBanner";
	}
	
	@RequestMapping("enrollBanner.adm")
	public String enrollBanner(@ModelAttribute Board b,@RequestParam("file") ArrayList<MultipartFile> files, HttpServletRequest request){

		String id =((Member)request.getSession().getAttribute("loginUser")).getMemberId();
		b.setWriter(id);
		b.setBoardType(6);
		
		ArrayList<Attachment> list = new ArrayList<>();
		
		
		  for(int i=0;i<files.size();i++) { MultipartFile upload =files.get(i);
		  
		  if(!upload.getOriginalFilename().equals("")) { 
			  String[] returnArr=saveFile(upload,request);
		  
		  if(returnArr[1]!=null) { Attachment a = new Attachment();
		  
		  a.setImgOriginalName(upload.getOriginalFilename());
		  a.setImgRename(returnArr[1]); 
		  a.setImgPath(returnArr[0]);
		  a.setBoardType(6);
		  list.add(a); 
		  } }
		  
		  }
	
		
		 for(int i=0;i<list.size();i++) { Attachment a =list.get(i);
		  
		 if(i==0) { a.setLevel(0); }else { a.setLevel(1); } }
		 b.setBoardType(6);
		 
		 
		int result1=aService.insertBannerBoard(b);
		int result2=aService.insertAttm(list);
		
		/*
		 * System.out.println(b); // boardType=6 이것만 담김.... System.out.println(list);
		 */	
		
		if(result1+result2>1) {
			return"redirect:manageBanner.adm"; 
		}else {
			throw new AdminException("배너 이미지 추가 오류");
		}
	}
	@RequestMapping("manageBanner.adm")
	public String managerBanner(Model model) {
		ArrayList<Board> bList=aService.selectBanner(6);
		ArrayList<Attachment> aList=aService.selectBannerAttm(6);	
		
		model.addAttribute("bList",bList);
		model.addAttribute("aList",aList);

		return "manageBanner";
	}
	@RequestMapping("detailBanner.adm")
	public String detailBanner(@RequestParam("boardNo") int boardNo,Model model) {
		Board b = aService.selectBannerDetail(boardNo);
		String bId=Integer.toString(b.getBoardNo());
		
		ArrayList<Attachment> list=aService.selectBannerAttmList(bId);
		
		model.addAttribute("b",b);
		model.addAttribute("list",list);
		
		return "detailBanner";
	}
	@RequestMapping("deleteBanner.adm")
	public String delete(@ModelAttribute Board b) {
		int boardNo=b.getBoardNo();
		String imgKey=Integer.toString(b.getBoardNo());
			
		int result1=aService.deleteBannerBoard(boardNo);
		int result2=aService.deleteBannerAttm(imgKey);
		int result=result1+result2;
		
		if(result>1) {
			return "redirect:manageBanner.adm";
		}else {
			throw new AdminException("배너 삭제 실패");
		}
	}

	@RequestMapping("manageReport.adm")
	public String manageReport(Model model) {
		ArrayList<Report> rList = aService.selectReportList();
		model.addAttribute("rList",rList);
		return "manageReport";
	}
	//신고 대상 글 처리
	@RequestMapping("reportBoard.adm")
	public String reportBoard(@RequestParam("reportNo") int rNo) {
		
		int statusBoard=aService.statusBoard(rNo);//신고 대상 글은 b_status를 N으로 놓는다.
		int reportBoard=aService.reportBoard(rNo);//신고 처리 이후 report테이블 내용 삭제
		int result = statusBoard+reportBoard;
		
		if(result>1) {
			return "redirect:manageReport.adm";
		}else {
			throw new AdminException("신고 처리 요청 실패");
		}
	}
	//신고글 확인 후 신고 취소 처리
	@RequestMapping("cancelReport.adm")
	public String cancelReport(@RequestParam("reportNo") int rNo) {
		
		int cancelStatusBoard=aService.cancelStatusBoard(rNo);// 신고대상 글이 아니니까 신고 상태 바꿔준다.
		int reportBoard=aService.reportBoard(rNo);//신고 처리 이후 report테이블 내용 삭제
		int result = cancelStatusBoard+reportBoard;
		
		if(result>1) {
			return "redirect:manageReport.adm";
		}else {
			throw new AdminException("신고 취소 요청 실패");
		}
	}
	
	@RequestMapping("manageReportReply.adm")
	public String manageReportReply(Model model) {
		ArrayList<Report> rList = aService.selectReporReplytList();
		model.addAttribute("rList",rList);
		return "manageReportReply";
	}
	
	//신고 대상 글 처리
	@RequestMapping("reportReply.adm")
	public String reportReply(@RequestParam("reportNo") int rNo,@RequestParam("boardType") String boardType,@RequestParam("boardNo") int bNo) {
		
		
		
		if(boardType.equals("씽씽마켓")) {
			int count=mkService.replyCancelCount(bNo);
		}else if(boardType.equals("싱글벙글")) {
			int count=cService.replyCountDown(bNo);
		}
		
		
		int statusReply=aService.statusReply(rNo);//신고 대상 글은 b_status를 N으로 놓는다.
		int reportReply=aService.reportTableReply(rNo);//신고 처리 이후 report테이블 내용 삭제
		int result = statusReply+reportReply;
		
		if(result>1) {
			return "redirect:manageReportReply.adm";
		}else {
			throw new AdminException("신고 처리 요청 실패");
		}
	}

	@RequestMapping("cancelReportReply.adm")
	public String cancelReportReply(@RequestParam("reportNo") int rNo) {
		
		int cancelStatusReply=aService.cancelStatusReply(rNo);// 신고대상 글이 아니니까 신고 상태 바꿔준다.
		int reportReply=aService.reportTableReply(rNo);//신고 처리 이후 report테이블 내용 삭제
		int result = cancelStatusReply+reportReply;
		System.out.println(result);
		System.out.println(cancelStatusReply);
		System.out.println(reportReply);
		
		if(result>1) {
			return "redirect:manageReportReply.adm";
		}else {
			throw new AdminException("신고 취소 요청 실패");
		}
	}
	@RequestMapping("manageInquiry.adm")
	public String manageInquiry(Model model) {
		ArrayList<InquiryAdmin> list=aService.manageInquiry(); 
		
		
		model.addAttribute("list",list);
		
		
		return "manageInquiry";
	}
	@RequestMapping("inquiryAnswer.adm")
	public String inquiryAnswer(@ModelAttribute InquiryAdmin i) {
		int result=aService.inquiryAnswer(i);
		if(result>0) {
			return"redirect:manageInquiry.adm";
		}else {
			throw new AdminException("문의 답변 글 작성 실패");
		}
	}
	@RequestMapping("manageInquiryQue.adm")
	public String inquiryQue(Model model) {
		ArrayList<InquiryAdmin> list=aService.inquiryQue();
		model.addAttribute("list",list);
		
		return "manageInquiryQue";
	}
	@RequestMapping("manageInquiryAns.adm")
	public String manageInquiryAns(Model model) {
		ArrayList<InquiryAdmin> list=aService.inquiryAns();
	
		model.addAttribute("list",list);
		return "manageInquiryAns";
	}
	
	@RequestMapping("statUser.adm")
	public String statUser(Model model) {

		ArrayList<HashMap<String,Object>> list = aService.enrollUserSum();
		ArrayList<HashMap<String,Object>> viewContent = aService.viewContentSum();
		ArrayList<HashMap<String,Object>> loginCount=aService.loginCount();
		model.addAttribute("list",list);
		model.addAttribute("viewContent",viewContent);
		model.addAttribute("logCount",loginCount);
		return "statUser";
	}
	@RequestMapping("statProduct.adm")
	public String statProduct(Model model) {
		//일일 매출량 
		ArrayList<HashMap<String,Object>> aList = aService.dailyOrderList();
		//일일 판매 매출액
		ArrayList<HashMap<String,Object>> bList = aService.dailySales();
		//큰카테고리별 주문수 
		ArrayList<HashMap<String,Object>> cList = aService.dailyTopCate();
		
		model.addAttribute("aList",aList);
		model.addAttribute("bList",bList);
		model.addAttribute("cList",cList);
		
		return "statProduct";
	}
	@RequestMapping("detailOrderProduct.adm")
	public String detailOrder(@RequestParam("orderNo") int orNo,Model model) {
		ArrayList<OrderProductDetail> list = aService.orderProductDetail(orNo);
		OrderPerson op = aService.selectOrderPerson(orNo);
		
		model.addAttribute("list",list);
		model.addAttribute("op",op);
		
		System.out.println(list);
		return "detailOrderProduct";
	}
	
	

	@RequestMapping("changeDeli.adm")
	public String changeDeli(@RequestParam("orderDetailNo") int odNo,@RequestParam("changeDeli") String cDeli) {
		ChangeDeli cd = new ChangeDeli(); 
		cd.setOrderDetailNo(odNo);
		cd.setChangeDeli(cDeli);
		int orderNo=aService.selectOrderNo(odNo);
		
		int result=aService.changeDeli(cd); 
		if(result>0) {
			return"redirect:detailOrderProduct.adm?orderNo="+orderNo;
		}else {
			throw new AdminException("변경 실패");
		}
	}
	
	@ResponseBody
	@RequestMapping(value="cancelProduct.adm",method = RequestMethod.POST,produces="application/json;")
	public String paymentCancle(@RequestBody CancelProductReqDto cancelProductReqDto) throws IOException  {
		
		String token = getToken(); //토큰 ㅜ.ㅜ
		
		RestTemplate rt = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("content-type","application/json; charset=UTF-8");
		headers.add("Authorization",token);
		
		
		JSONObject json = new JSONObject();
		json.put("imp_uid", cancelProductReqDto.getImpUid());
		json.put("merchant_uid", cancelProductReqDto.getMerId());
		json.put("amount", 100);
		HttpEntity<String> cancelProduct = new HttpEntity<>(json.toString(),headers);
		
		ResponseDto rDto =rt.postForObject(
				"https://api.iamport.kr/payments/cancel",
				cancelProduct, 
				ResponseDto.class);
		Integer code=rDto.getCode();
			System.out.println(code);
			
			if(code==0) {
				
				int odNo=cancelProductReqDto.getOrderDetailNo();
				int orNo=cancelProductReqDto.getOrderNo();
				
				int detailNoResult=aService.statusDetailNo(odNo);
				int orderNoResult=aService.statusOrderNo(orNo);
				
				return "0";
			}else {
				return "1";
			}
	
	}
	@ResponseBody
	@RequestMapping(value="cancelTotalProduct.adm",method = RequestMethod.POST,produces="application/json;")
	public String paymentTotalCancle(@RequestBody CancelTotalProductReqDto cancelTotalProductReqDto) throws IOException  {
		

		String token = getToken(); //토큰 ㅜ.ㅜ
		
		RestTemplate rt = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("content-type","application/json; charset=UTF-8");
		headers.add("Authorization",token);
		
		
		JSONObject json = new JSONObject();
		json.put("imp_uid", cancelTotalProductReqDto.getImpUid());
		json.put("merchant_uid", cancelTotalProductReqDto.getMerId());
		HttpEntity<String> cancelProduct = new HttpEntity<>(json.toString(),headers);
		
		ResponseDto rDto =rt.postForObject(
				"https://api.iamport.kr/payments/cancel",
				cancelProduct, 
				ResponseDto.class);
		Integer code=rDto.getCode();
			System.out.println(code);
			
			
			
			
			

			if(code==0) {
				
				int orNo=cancelTotalProductReqDto.getOrderNo();
				int orderNoResult=aService.statusOrderNo(orNo);
				ArrayList<HashMap<String,String>> odList=aService.selectProductDetailNo(orNo);
				
				for(int i=0;i<odList.size();i++) {
					int odNo=Integer.parseInt(odList.get(i).toString().split("=")[1].substring(0,3));
					int result=aService.statusDetailNo(odNo);
				}
				
				return "0";
			}else {
				return "1";
			}	}
	

	public String getToken() {
		
		
		
		
		String apiKey="iamport키";
		String apiSecret="secret키";
		
		RestTemplate rt =new RestTemplate();
		HttpHeaders headers=new HttpHeaders();
		headers.add("content-type","application/json; charset=UTF-8");

		JSONObject json = new JSONObject();
		json.put("imp_key",apiKey);
		json.put("imp_secret",apiSecret);
		
		HttpEntity<String> impTokenRequest= new HttpEntity<>(json.toString(),headers);
		
		ImportTokenDto tokenDto =rt.postForObject(
				"https://api.iamport.kr/users/getToken",
				impTokenRequest,
				ImportTokenDto.class
				);
				
		
		String token=tokenDto.getResponse().get("access_token");
		
		return token;
	}
	
	
	
	
}
