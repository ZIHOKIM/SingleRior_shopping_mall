package com.E1I4.project.storeBoard.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class OrderResult {
 private String recipient;
 private String address; //address+address_detail
 private String recipient_phone;
 private int finalPrice;
 private String memberId;
 private String deliveryMsg;
 

}
  

