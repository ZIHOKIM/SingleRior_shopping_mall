package com.E1I4.project.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.E1I4.project.admin.model.dao.AdminDAO;
import com.E1I4.project.admin.model.vo.ChangeDeli;
import com.E1I4.project.admin.model.vo.MemberManage;
import com.E1I4.project.admin.model.vo.OrderPerson;
import com.E1I4.project.admin.model.vo.OrderProducts;
import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.common.model.vo.Board;
import com.E1I4.project.common.model.vo.InquiryAdmin;
import com.E1I4.project.common.model.vo.Notice;
import com.E1I4.project.common.model.vo.OrderProductDetail;
//import com.E1I4.project.common.model.vo.OrderProductDetail;
import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.common.model.vo.Product;
import com.E1I4.project.common.model.vo.ProductList;
import com.E1I4.project.common.model.vo.Qna;
import com.E1I4.project.common.model.vo.Report;
import com.E1I4.project.member.model.vo.Member;

@Service("aService")
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDAO aDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertProduct(Product p) {
		return aDAO.insertPrduct(sqlSession,p);
	}

	@Override
	public int insertAttm(ArrayList<Attachment> list) {
		return aDAO.insertAttm(sqlSession,list);
	}

	@Override
	public ArrayList<MemberManage> selectMemberList() {
		return aDAO.selectMemberList(sqlSession);
	}

	@Override
	public Member selectMember(String memberId) {
		return aDAO.selectMemberList(sqlSession,memberId);
	}

	@Override
	public int editMember(Member m) {
		return aDAO.editMember(sqlSession,m);
	}

	@Override
	public ArrayList<ProductList> selectProductList(int i) {
		return aDAO.selectProductList(sqlSession,i);
	}

	@Override
	public ArrayList<Attachment> selectAttmList(int i) {
		return aDAO.selectAttmList(sqlSession,i);
	}

	@Override
	public ProductList selectProductDetail(int productNo) {
		return aDAO.selectProductDetail(sqlSession,productNo);
	}

	@Override
	public ArrayList<Attachment> selectAttmListDetail(int bId) {
		return aDAO.selectAttmListDetail(sqlSession,bId);
	}

	@Override
	public int deleteAttm(ArrayList<String> delRename) {
		return aDAO.deleteAttm(sqlSession,delRename);
	}

	@Override
	public void updateAttmLevel(String bId) {
		aDAO.updateAttmLevel(sqlSession,bId);
	}

	@Override
	public int updateProduct(Product p) {
		return aDAO.updateProduct(sqlSession,p);
	}

	@Override
	public int deleteProduct(int productNo) {
		return aDAO.deleteProduct(sqlSession,productNo);
	}
	@Override
	public int successProduct(int productNo) {
		return aDAO.successProduct(sqlSession,productNo);
	}
	
	@Override
	public int getListCount(int i) {
		return aDAO.getListCount(sqlSession,i);
	}

	@Override
	public int enrollNotice(Notice n) {
		return aDAO.enrollNotice(sqlSession,n);
	}

	@Override
	public ArrayList<Notice> selectNoticeList(PageInfo pi, int i) {
		return aDAO.selectNoticeList(sqlSession,pi,i);
	}
	@Transactional
	@Override
	public Notice detailNotice(int bNo, boolean yn) {
		int result=0;
		if(yn) {
			result=aDAO.addCount(sqlSession,bNo);
		}
		Notice n = aDAO.selectNotice(sqlSession,bNo);
		return n;
	}

	@Override
	public int editeNotice(Notice n) {
		return aDAO.editNotice(sqlSession,n);
	}

	@Override
	public int deleteNotice(int bNo) {
		return aDAO.deleteNotice(sqlSession,bNo);
	}

	@Override
	public int enrollQNA(Qna q) {
		return aDAO.enrollQNA(sqlSession,q);
	}

	@Override
	public ArrayList<Qna> selectQNAList(PageInfo pi, int i) {
		return aDAO.selectQNAList(sqlSession,pi,i);
	}

	@Override
	public Qna selectQNADetail(int bNo) {
		return aDAO.selectQNADetail(sqlSession,bNo);
	}

	@Override
	public int editQNA(Qna q) {
		return aDAO.editQNA(sqlSession,q);
	}

	@Override
	public int deleteQNA(int bNo) {
		return aDAO.deleteQNA(sqlSession,bNo);
	}

	@Override
	public int insertBannerBoard(Board b) {
		return aDAO.insertBannerBoard(sqlSession,b);
	}

	@Override
	public ArrayList<Board> selectBanner(int i) {
		return aDAO.selectBannerBoard(sqlSession,i);
	}

	@Override
	public ArrayList<Attachment> selectBannerAttm(int i) {
		return aDAO.selectBannerAttm(sqlSession, i);
	}

	@Override
	public Board selectBannerDetail(int boardNo) {
		return aDAO.selectBannerDetail(sqlSession,boardNo);
	}

	@Override
	public ArrayList<Attachment> selectBannerAttmList(String bId) {
		return aDAO.selectBannerAttmList(sqlSession,bId);
	}

	@Override
	public int deleteBannerBoard(int boardNo) {
		return aDAO.deleteBannerBoard(sqlSession,boardNo);
	}

	@Override
	public int deleteBannerAttm(String imgKey) {
		return aDAO.deleteBannerAttm(sqlSession,imgKey);
	}

	@Override
	public ArrayList<Report> selectReportList() {
		return aDAO.selectReportList(sqlSession);
	}

	@Override
	public int reportBoard(int rNo) {
		return aDAO.reportBoard(sqlSession,rNo);
	}

	@Override
	public int statusBoard(int rNo) {
		return aDAO.statusBoard(sqlSession,rNo);
	}

	@Override
	public int cancelStatusBoard(int rNo) {
		return aDAO.cancelStatusBoard(sqlSession,rNo);
	}

	@Override
	public ArrayList<Report> selectReporReplytList() {
		return aDAO.selectReportReplyList(sqlSession);
	}

	@Override
	public int statusReply(int rNo) {
		return aDAO.statusReply(sqlSession,rNo);
	}

	@Override
	public int reportTableReply(int rNo) {
		return aDAO.reportTabledReply(sqlSession,rNo);
	}

	@Override
	public int cancelStatusReply(int rNo) {
		return aDAO.cancelStatusReply(sqlSession,rNo);
	}

	@Override
	public ArrayList<InquiryAdmin> manageInquiry() {
		return aDAO.manageInquiry(sqlSession);
	}

	@Override
	public int inquiryAnswer(InquiryAdmin i) {
		return aDAO.inquiryAnswer(sqlSession,i);
	}

	@Override
	public ArrayList<InquiryAdmin> inquiryQue() {
		return aDAO.inquiryQue(sqlSession);
	}

	@Override
	public ArrayList<InquiryAdmin> inquiryAns() {
		return aDAO.inuiryAns(sqlSession);
	}

	@Override
	public ArrayList<HashMap<String, Object>> enrollUserSum() {
		return aDAO.enrollUserSum(sqlSession);
	}

	@Override
	public ArrayList<HashMap<String, Object>> viewContentSum() {
		return aDAO.viewContentSum(sqlSession);
	}

	@Override
	public ArrayList<OrderProducts> selectOrderProducts() {
		return aDAO.selectOrderProducts(sqlSession);
	}

	@Override
	public ArrayList<OrderProductDetail> orderProductDetail(int orNo) {
		return aDAO.orderProductDetail(sqlSession,orNo);
	}

	@Override
	public ArrayList<HashMap<String, Object>> loginCount() {
		return aDAO.loginCount(sqlSession);
	}

	@Override
	public ArrayList<HashMap<String, Object>> dailyOrderList() {
		return aDAO.dailyOrderList(sqlSession);
	}

	@Override
	public ArrayList<HashMap<String, Object>> dailySales() {
		return aDAO.dailySales(sqlSession);
	}

	@Override
	public ArrayList<HashMap<String, Object>> dailyTopCate() {
		return aDAO.dailyTopCate(sqlSession);
	}

	@Override
	public int changeDeli(ChangeDeli cd) {
		return aDAO.changeDeli(sqlSession,cd);
	}

	@Override
	public int selectOrderNo(int odNo) {
		return aDAO.selectOrderNo(sqlSession,odNo);
	}

	@Override
	public OrderPerson selectOrderPerson(int orNo) {
		return aDAO.selectOrderPerson(sqlSession,orNo);
	}

	@Override
	public int statusDetailNo(int odNo) {
		return aDAO.statusDetailNo(sqlSession,odNo);
	}

	@Override
	public int statusOrderNo(int orNo) {
		return aDAO.statusOrder(sqlSession,orNo);
	}

	@Override
	public ArrayList<HashMap<String,String>>selectProductDetailNo(int orNo) {
		return aDAO.selectProductDetailNo(sqlSession,orNo);
	}






	





}
