package com.E1I4.project.common.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Pay {
	private int payNo;
	private int payAmount;
	private Date payDate;
	private String payStatus;
	private int orderNo;
	private String merchantuid;
	private String impuid;
}
