package com.E1I4.project.admin.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class CancelTotalProductReqDto {
	private String merId;
	private String impUid;
	private int orderNo;
}
