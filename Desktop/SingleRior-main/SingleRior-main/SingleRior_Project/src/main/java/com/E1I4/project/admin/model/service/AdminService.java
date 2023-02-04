package com.E1I4.project.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.E1I4.project.admin.model.vo.ChangeDeli;
import com.E1I4.project.admin.model.vo.MemberManage;
import com.E1I4.project.admin.model.vo.OrderPerson;
import com.E1I4.project.admin.model.vo.OrderProducts;
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
import com.E1I4.project.member.model.vo.Member;

public interface AdminService {

	int insertProduct(Product p);

	int insertAttm(ArrayList<Attachment> list);

	ArrayList<MemberManage> selectMemberList();

	Member selectMember(String memberId);

	int editMember(Member m);

	ArrayList<ProductList> selectProductList(int i);

	ArrayList<Attachment> selectAttmList(int i);

	ProductList selectProductDetail(int productNo);

	ArrayList<Attachment> selectAttmListDetail(int bId);

	int deleteAttm(ArrayList<String> delRename);

	void updateAttmLevel(String bId );

	int updateProduct(Product p);

	int deleteProduct(int productNo);

	int getListCount(int i);

	int enrollNotice(Notice n);

	ArrayList<Notice> selectNoticeList(PageInfo pi, int i);

	Notice detailNotice(int bNo, boolean yn);

	int editeNotice(Notice n);

	int deleteNotice(int bNo);

	int enrollQNA(Qna q);

	ArrayList<Qna> selectQNAList(PageInfo pi, int i);

	Qna selectQNADetail(int bNo);

	int editQNA(Qna q);

	int deleteQNA(int bNo);

	int insertBannerBoard(Board b);

	ArrayList<Board> selectBanner(int i);

	ArrayList<Attachment> selectBannerAttm(int i);

	Board selectBannerDetail(int boardNo);

	ArrayList<Attachment> selectBannerAttmList(String bId);

	int deleteBannerBoard(int boardNo);

	int deleteBannerAttm(String imgKey);

	int successProduct(int productNo);

	ArrayList<Report> selectReportList();

	int statusBoard(int rNo);

	int reportBoard(int rNo);

	int cancelStatusBoard(int rNo);

	ArrayList<Report> selectReporReplytList();

	int statusReply(int rNo);

	int reportTableReply(int rNo);

	int cancelStatusReply(int rNo);

	ArrayList<InquiryAdmin> manageInquiry();

	int inquiryAnswer(InquiryAdmin i);

	ArrayList<InquiryAdmin> inquiryQue();

	ArrayList<InquiryAdmin> inquiryAns();

	ArrayList<HashMap<String, Object>> enrollUserSum();

	ArrayList<HashMap<String, Object>> viewContentSum();

	ArrayList<OrderProducts> selectOrderProducts();

	ArrayList<OrderProductDetail> orderProductDetail(int orNo);

	ArrayList<HashMap<String, Object>> loginCount();

	ArrayList<HashMap<String, Object>> dailyOrderList();

	ArrayList<HashMap<String, Object>> dailySales();

	ArrayList<HashMap<String, Object>> dailyTopCate();

	int changeDeli(ChangeDeli cd);

	int selectOrderNo(int odNo);

	OrderPerson selectOrderPerson(int orNo);

	int statusDetailNo(int odNo);

	int statusOrderNo(int orNo);

	ArrayList<HashMap<String,String>> selectProductDetailNo(int orNo);







}
