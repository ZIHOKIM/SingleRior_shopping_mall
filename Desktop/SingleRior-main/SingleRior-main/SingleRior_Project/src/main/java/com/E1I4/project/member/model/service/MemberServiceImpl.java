package com.E1I4.project.member.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import com.E1I4.project.member.model.dao.MemberDAO;
import com.E1I4.project.member.model.vo.LoginLog;
import com.E1I4.project.member.model.vo.Member;
import com.E1I4.project.member.model.vo.Order;
import com.E1I4.project.member.model.vo.ProductCancel;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service("mService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO mDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Member login(Member m) {
		return mDAO.login(sqlSession,m);
	}

	@Override
	public int checkId(String memberId) {
		return mDAO.checkId(sqlSession, memberId);
	}

	@Override
	public int checkNickName(String nickName) {
		return mDAO.checkNickName(sqlSession, nickName);
	}

	@Override
	public int insertMember(Member m) {
		return mDAO.insertMember(sqlSession, m);
	}

	@Override
	public String findId(Member m) {
		return mDAO.findId(sqlSession,m);
	}

	@Override
	public int findPwd(Member m) {
		return mDAO.findPwd(sqlSession,m);
	}

	@Override
	public int changePwd(Member m) {
		return mDAO.changePwd(sqlSession,m);
	}

	@Override
	public int checkEmailConfirm(String email) {
		return mDAO.checkEmailConfirm(sqlSession,email);
	}

	@Override
	public int updateMember(Member m) {
		return mDAO.updateMember(sqlSession,m);
	}

	@Override
	public int getProfilePhotoCount(String memberId) {
		return mDAO.getProfilePhotoCount(sqlSession,memberId);
	}

	@Override
	public int insertProfile(Attachment a) {
		return mDAO.insertProfile(sqlSession,a);
	}

	@Override
	public int updateProfile(Attachment a) {
		return mDAO.updateProfile(sqlSession,a);
	}

	@Override
	public Attachment selectProfile(String memberId) {
		return mDAO.selectProfile(sqlSession,memberId);
	}

	@Override
	public int deleteProfile(String memberId) {
		return mDAO.deleteProfile(sqlSession,memberId);
	}

	@Override
	public int deleteMember(String memberId) {
		return mDAO.deleteMember(sqlSession,memberId);
	}

	@Override
	public int deleteKakaoMember(String memberId) {
		return mDAO.deleteKakaoMember(sqlSession,memberId);
	}

	@Override
	public int getMyContentListCount(HashMap<String, String> map) {
		return mDAO.getMyContentListCount(sqlSession, map);
	}

	@Override
	public ArrayList<Board> selectBoardList(PageInfo pi, HashMap<String, String> map) {
		return mDAO.selectBoardList(sqlSession,pi,map);
	}

	@Override
	public int getLikeCount(int boardNo) {
		return mDAO.getLikeCount(sqlSession,boardNo);
	}

	@Override
	public int getReplyCount(int boardNo) {
		return mDAO.getReplyCount(sqlSession,boardNo);
	}

	@Override
	public int getMyReplyListCount(HashMap<String, String> map) {
		return mDAO.getMyReplyListCount(sqlSession, map);
	}

	@Override
	public ArrayList<Reply> selectReplyList(PageInfo pi, HashMap<String, String> map) {
		return mDAO.selectReplyList(sqlSession,pi, map);
	}



	@Override
	public Board selectReplyBoardList(HashMap<String, Integer> replyMap) {
		return  mDAO.selectReplyBoardList(sqlSession,replyMap);
	}

	@Override
	public int getMyAskListCount(HashMap<String, String> map) {
		return mDAO.getMyAskListCount(sqlSession,map);
	}

	@Override
	public ArrayList<ProductInquiry> selectMyAskList(PageInfo pi, HashMap<String, String> map) {
		return mDAO.selectMyAskList(sqlSession,map,pi);
	}

	@Override
	public Attachment getImageProduct(int productNo) {
		return mDAO.getImageProduct(sqlSession,productNo);
	}

	@Override
	public Product getDetailProduct(String boardNo) {
		return mDAO.getDetailProduct(sqlSession,boardNo);
	}

	@Override
	public int getWishListCount(HashMap<String, String> map) {
		return mDAO.getWishListCount(sqlSession,map);
	}

	@Override
	public ArrayList<WishList> selectWishList(PageInfo pi, HashMap<String, String> map) {
		return mDAO.selectWishList(sqlSession,map,pi);
	}

	@Override
	public String getImgWishList(HashMap<String, String> map) {
		return mDAO.getImgWishList(sqlSession,map);
	}

	@Override
	public int deleteWishList(WishList wl) {
		return mDAO.deleteWishList(sqlSession,wl);
	}

	@Override
	public ArrayList<Board> selectQna(String category) {
		return mDAO.selectQna(sqlSession,category);
	}

	@Override
	public int getCartListCount(String memberId) {
		return mDAO.getCartListCount(sqlSession,memberId);
	}

	@Override
	public ArrayList<Cart> selectCartList(PageInfo pi, String memberId) {
		return mDAO.selectCartList(sqlSession,memberId,pi);
	}

	@Override
	public String selectCartImg(int productNo) {
		return  mDAO.selectCartImg(sqlSession,productNo);
	}

	@Override
	public int deleteCart(String cartNo) {
		return mDAO.deleteCart(sqlSession,cartNo);
	}

	@Override
	public int getOrderListCount(HashMap<String, String> map) {
		return mDAO.getOrderListCount(sqlSession,map);
	}

	@Override
	public ArrayList<Order> selectCommonList(PageInfo pi, HashMap<String, String> map) {
		return mDAO.selectCommonList(sqlSession,pi,map);
	}

	@Override
	public String getImgOrder(HashMap<String, String> map) {
		return mDAO.getImgOrder(sqlSession,map);
	}

	@Override
	public Review getMyReviewList(int orderNo) {
		return mDAO.getMyReviewList(sqlSession,orderNo);
	}

	@Override
	public String getImgReview(String reviewNoStr) {
		return  mDAO.getImgReview(sqlSession,reviewNoStr);
	}

	@Override
	public int orderStatusCount(HashMap<String, String> map) {
		return mDAO.orderStatusCount(sqlSession,map);
	}

	@Override
	public int orderStatusChange(HashMap<String, Integer> map) {
		return mDAO.orderStatusChange(sqlSession,map);
	}

	@Override
	public int orderCancel(ProductCancel pc) {
		return mDAO.orderCancel(sqlSession,pc);
	}

	@Override
	public int orderProductStatusChange(int orderNo) {
		return mDAO.orderProductStatusChange(sqlSession,orderNo);
	}

	@Override
	public ArrayList<Order> orderDetailList(int orderNo) {
		return mDAO.orderDetailList(sqlSession,orderNo);
	}
	public int insertReview(Review review) {
		return mDAO.insertReview(sqlSession, review);
	}

	@Override
	public int updateReviewStatus(HashMap<String, Object> map) {
		return mDAO.updateReviewStatus(sqlSession, map);
	}

	@Override
	public int changeDeliveryAddress(Order order) {
		return mDAO.changeDeliveryAddress(sqlSession, order);
	}

	@Override
	public int insertReviewAttm(HashMap<String, Object> map) {
		return mDAO.insertReviewAttm(sqlSession, map);
	}

	@Override
	public ArrayList<Attachment> selectReviewAttmList() {
		return mDAO.selectReviewAttmList(sqlSession);
	}

	@Override
	public int deleteReviewAttm(int reviewNo) {
		return mDAO.deleteReviewAttm(sqlSession, reviewNo);
	}

	@Override
	public int updateReview(Review review) {
		return mDAO.updateReview(sqlSession, review);
	}

	@Override
	public int getOrderCancelCount(HashMap<String, String> map) {
		return mDAO.getOrderCancelCount(sqlSession, map);
	}

	@Override
	public ArrayList<Order> orderCancelList(HashMap<String, String> map, PageInfo pi) {
		return mDAO.orderCancelList(sqlSession,pi,map);
	}

	@Override
	public ProductCancel getProductCancel(int orderDetailNo) {
		return mDAO.getProductCancel(sqlSession,orderDetailNo);
	}

	public int deleteReview(int reviewNo) {
		return mDAO.deleteReview(sqlSession, reviewNo);
	}

	@Override
	public int selectAttmCount(String strRNo) {
		return mDAO.selectAttmCount(sqlSession, strRNo);
	}

	@Override
	public int deleteInquiry(int inquiryNo) {
		return mDAO.deleteInquiry(sqlSession, inquiryNo);
	}

	@Override
	public Pay getPayInfo(int orderNo) {
		return mDAO.getPayInfo(sqlSession, orderNo);
	}

	@Override
	public LoginLog searchLog(String memberId) {
		return mDAO.searchLog(sqlSession,memberId);
	}

	@Override
	public int insertTime(String memberId) {
		return mDAO.insertTime(sqlSession,memberId);
	}

	@Override
	public LoginLog loginCheck(String memberId) {
		return mDAO.loginCheck(sqlSession,memberId);
	}

	@Override
	public int updateTime(String memberId) {
		return mDAO.updateTime(sqlSession,memberId);
	}

	@Override
	public int updateCheck(String memberId) {
		return mDAO.updateCheck(sqlSession,memberId);
	}

	@Override
	public String checkKNLogin(String email) {
		return mDAO.checkKNLogin(sqlSession,email);
	}

}
