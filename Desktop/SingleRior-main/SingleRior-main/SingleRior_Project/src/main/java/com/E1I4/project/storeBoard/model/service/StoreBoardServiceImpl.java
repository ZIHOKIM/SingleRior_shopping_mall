package com.E1I4.project.storeBoard.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.E1I4.project.common.model.vo.Attachment;
import com.E1I4.project.common.model.vo.Cart;
import com.E1I4.project.common.model.vo.OrderProductDetail;
import com.E1I4.project.common.model.vo.PageInfo;
import com.E1I4.project.common.model.vo.Pay;
import com.E1I4.project.common.model.vo.ProductInquiry;
import com.E1I4.project.common.model.vo.WishList;
import com.E1I4.project.member.model.vo.Member;
import com.E1I4.project.storeBoard.model.dao.StoreBoardDAO;
import com.E1I4.project.storeBoard.model.vo.OrderDetail;
import com.E1I4.project.storeBoard.model.vo.OrderItem;
import com.E1I4.project.storeBoard.model.vo.OrderResult;
import com.E1I4.project.storeBoard.model.vo.ProductReview;
import com.E1I4.project.storeBoard.model.vo.StoreBoard;
import com.E1I4.project.storeBoard.model.vo.TotalReview;

@Service("sService")
public class StoreBoardServiceImpl implements StoreBoardService{
	@Autowired
	private StoreBoardDAO sDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	

	@Override
	public int getStoreListCount(HashMap<String, Integer> map) {
		return sDAO.getStoreListCount(sqlSession, map);
	}

	@Override
	public ArrayList<StoreBoard> selectStoreBoardList(PageInfo pi, HashMap<String, Integer> map) {
		return sDAO.selectStoreBoardList(sqlSession, pi, map);
	}

	@Override
	public Attachment selectAttmList(String strBoardNo) {
		return sDAO.selectAttmList(sqlSession,strBoardNo);
	}

	@Override
	public ArrayList<StoreBoard> selectProduct(int productNo, int boardNo) {
		int result = 0;
		result = sDAO.addCount(sqlSession, boardNo);
		return sDAO.selectProduct(sqlSession,productNo);
	}

	@Override
	public int wishListOn(WishList wl) {
		return sDAO.wishListOn(sqlSession, wl);
	}

	@Override
	public int wishListOff(WishList wl) {
		return sDAO.wishListOff(sqlSession, wl);
	}

	@Override
	public int wishListCount(WishList wl) {
		return sDAO.wishListCount(sqlSession, wl);
	}

	@Override
	public int insertCart(Cart cart) {
		return sDAO.insertCart(sqlSession, cart);
	}

	@Override
	public int insertInquiry(ProductInquiry productInquiry) {
		return sDAO.insertInquiry(sqlSession, productInquiry);
	}

	@Override
	public int InquiryCount(ProductInquiry pi) {
		return sDAO.InquiryCount(sqlSession, pi);
	}

	@Override
	public ArrayList<ProductInquiry> selectInquiryList(int productNo) {
		return sDAO.selectInquiryList(sqlSession, productNo);
	}

	@Override
	public Member getUserInfo(String id) {
		return sDAO.getUserInfo(sqlSession, id);
	}

	@Override
	public OrderItem getCartInfo(int i) {
		return sDAO.getCartInfo(sqlSession, i);
	}

	@Override
	public String getImgRename(String boardNo) {
		return sDAO.getImgRename(sqlSession, boardNo);
	}

	@Override
	public int InsertOrderProduct(OrderResult r){
		return sDAO.InsertOrderProduct(sqlSession, r);
	}

	@Override
	public Cart selectCartInfo(int i) {
		return sDAO.selectCartInfo(sqlSession, i);
	}

	@Override
	public int getMoreInquiryCount(int productNo) {
		return sDAO.getMoreInquiryCount(sqlSession, productNo);
	}

	@Override
	public ArrayList<ProductInquiry> selectMoreInquiryList(PageInfo pi, int productNo) {
		return sDAO.selectMoreInquiryList(sqlSession, productNo,pi);
	}

	@Override
	public ArrayList<ProductReview> selectReviewList(int productNo) {
		return sDAO.selectReviewList(sqlSession,productNo);

	}

	@Override
	public int insertProductDetail(Cart cart) {
		return sDAO.insertProductDetail(sqlSession, cart);
	}


	@Override
	public int deleteCart(Cart cart) {
		return sDAO.deleteCart(sqlSession, cart);
	}

	@Override
	public ArrayList<TotalReview> selectTotalReview(int productNo) {
		return sDAO.selectTotalReview(sqlSession,productNo);
	}

	public int insertPayment(Pay pay) {
		return  sDAO.insertPayment(sqlSession, pay);
	}

	@Override
	public int getMoreReviewCount(int productNo) {
		return sDAO.getMoreReviewCount(sqlSession,productNo);
	}

	@Override
	public ArrayList<ProductReview> selectMoreReviewList(PageInfo pi, int productNo) {
		return sDAO.selectMoreReviewList(sqlSession,pi,productNo);
	}

	@Override
	public String getSubCateName(HashMap<String, Integer> map) {
		return sDAO.getSubCateName(sqlSession,map);
	}

	@Override
	public String getTopCateName(HashMap<String, Integer> map) {
		return sDAO.getTopCateName(sqlSession,map);
	}

	@Override
	public String getTopCateName2(HashMap<String, Integer> map) {
		return sDAO.getTopCateName2(sqlSession,map);
	}

	@Override
	public int deleteInquiry(int inquiryNo) {
		return sDAO.deleteInquiry(sqlSession,inquiryNo);
	}

	@Override
	public double getReviewRating(int bNo) {
		return sDAO.getReviewRating(sqlSession,bNo);
	}

	@Override
	public int getReviewCount(int bNo) {
		return sDAO.getReviewCount(sqlSession,bNo);
	}

	@Override
	public int getWishCount(int bNo) {
		return sDAO.getWishCount(sqlSession,bNo);
	}


}
