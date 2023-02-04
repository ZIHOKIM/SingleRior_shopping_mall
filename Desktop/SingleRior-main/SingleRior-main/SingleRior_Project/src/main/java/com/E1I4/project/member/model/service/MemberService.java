package com.E1I4.project.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

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
import com.E1I4.project.member.model.vo.LoginLog;
import com.E1I4.project.member.model.vo.Member;
import com.E1I4.project.member.model.vo.Order;
import com.E1I4.project.member.model.vo.ProductCancel;

public interface MemberService {

	Member login(Member m);

	int checkId(String memberId);

	int checkNickName(String nickName);

	int insertMember(Member m);

	String findId(Member m);

	int findPwd(Member m);

	int changePwd(Member m);

	int checkEmailConfirm(String email);

	int updateMember(Member m);

	int getProfilePhotoCount(String memberId);

	int insertProfile(Attachment a);

	int updateProfile(Attachment a);

	Attachment selectProfile(String memberId);

	int deleteProfile(String memberId);

	int deleteMember(String memberId);

	int deleteKakaoMember(String memberId);

	int getMyContentListCount(HashMap<String, String> map);

	ArrayList<Board> selectBoardList(PageInfo pi, HashMap<String, String> map);

	int getLikeCount(int boardNo);

	int getReplyCount(int boardNo);

	int getMyReplyListCount(HashMap<String, String> map);

	ArrayList<Reply> selectReplyList(PageInfo pi, HashMap<String, String> map);

	Board selectReplyBoardList(HashMap<String, Integer> replyMap);

	int getMyAskListCount(HashMap<String, String> map);

	ArrayList<ProductInquiry> selectMyAskList(PageInfo pi, HashMap<String, String> map);

	Attachment getImageProduct(int productNo);

	Product getDetailProduct(String boardNo);

	int getWishListCount(HashMap<String, String> map);

	ArrayList<WishList> selectWishList(PageInfo pi, HashMap<String, String> map);

	String getImgWishList(HashMap<String, String> map);

	int deleteWishList(WishList wl);

	ArrayList<Board> selectQna(String category);

	int getCartListCount(String memberId);

	ArrayList<Cart> selectCartList(PageInfo pi, String memberId);

	String selectCartImg(int productNo);

	int deleteCart(String cartNo);

	int getOrderListCount(HashMap<String, String> map);

	ArrayList<Order> selectCommonList(PageInfo pi, HashMap<String, String> map);

	String getImgOrder(HashMap<String, String> map);

	Review getMyReviewList(int orderNo);

	String getImgReview(String reviewNoStr);

	int orderStatusCount(HashMap<String, String> map);

	int orderStatusChange(HashMap<String, Integer> map);

	int orderCancel(ProductCancel pc);

	int orderProductStatusChange(int orderNo);

	int insertReview(Review review);

	int updateReviewStatus(HashMap<String, Object> map);

	ArrayList<Order> orderDetailList(int orderNo);

	int insertReviewAttm(HashMap<String, Object> map);

	int changeDeliveryAddress(Order order);

	ArrayList<Attachment> selectReviewAttmList();

	int deleteReviewAttm(int reviewNo);

	int updateReview(Review review);

	int getOrderCancelCount(HashMap<String, String> map);

	ArrayList<Order> orderCancelList(HashMap<String, String> map, PageInfo pi);

	ProductCancel getProductCancel(int orderDetailNo);

	int deleteReview(int reviewNo);

	int selectAttmCount(String strRNo);

	int deleteInquiry(int inquiryNo);

	Pay getPayInfo(int orderNo);

	LoginLog searchLog(String memberId);

	int insertTime(String memberId);

	LoginLog loginCheck(String memberId);

	int updateTime(String memberId);

	int updateCheck(String memberId);

	String checkKNLogin(String email);



}
