package com.E1I4.project.admin.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CancelProductReqDto {
	
	private String merId;
	private String impUid;
	private int orderDetailNo;
	private int orderNo;
	
	
	
	
	
	
	
//	public Product toEntity() {
//		return new Product(this.memId, this.impUid);
//	}
//
//
//	
//	
//	 ex responseDto
//	
//	public CancleProductResDto(Product product) {
//		memId = product.getMemId();
//		impUid = product.getImpUid();
//	}
//	
//	
//	
//	
//	
//	
//	reqDto ㅡ> entity
//	Product product = CancelProductReqDto.toEntity();
//	
//	CancelProductResDto cancelProductResDto = new CancelProductResDto(product); 
}
