package com.E1I4.project.admin.dto;

import java.util.List;
import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("jsonschema2pojo")
public class Response {

@SerializedName("imp_uid")
@Expose
private String impUid;
@SerializedName("merchant_uid")
@Expose
private String merchantUid;
@SerializedName("pay_method")
@Expose
private String payMethod;
@SerializedName("channel")
@Expose
private String channel;
@SerializedName("pg_provider")
@Expose
private String pgProvider;
@SerializedName("emb_pg_provider")
@Expose
private String embPgProvider;
@SerializedName("pg_tid")
@Expose
private String pgTid;
@SerializedName("pg_id")
@Expose
private String pgId;
@SerializedName("escrow")
@Expose
private Boolean escrow;
@SerializedName("apply_num")
@Expose
private String applyNum;
@SerializedName("bank_code")
@Expose
private String bankCode;
@SerializedName("bank_name")
@Expose
private String bankName;
@SerializedName("card_code")
@Expose
private String cardCode;
@SerializedName("card_name")
@Expose
private String cardName;
@SerializedName("card_quota")
@Expose
private Integer cardQuota;
@SerializedName("card_number")
@Expose
private String cardNumber;
@SerializedName("card_type")
@Expose
private String cardType;
@SerializedName("vbank_code")
@Expose
private String vbankCode;
@SerializedName("vbank_name")
@Expose
private String vbankName;
@SerializedName("vbank_num")
@Expose
private String vbankNum;
@SerializedName("vbank_holder")
@Expose
private String vbankHolder;
@SerializedName("vbank_date")
@Expose
private Integer vbankDate;
@SerializedName("vbank_issued_at")
@Expose
private Integer vbankIssuedAt;
@SerializedName("name")
@Expose
private String name;
@SerializedName("amount")
@Expose
private Integer amount;
@SerializedName("cancel_amount")
@Expose
private Integer cancelAmount;
@SerializedName("currency")
@Expose
private String currency;
@SerializedName("buyer_name")
@Expose
private String buyerName;
@SerializedName("buyer_email")
@Expose
private String buyerEmail;
@SerializedName("buyer_tel")
@Expose
private String buyerTel;
@SerializedName("buyer_addr")
@Expose
private String buyerAddr;
@SerializedName("buyer_postcode")
@Expose
private String buyerPostcode;
@SerializedName("custom_data")
@Expose
private String customData;
@SerializedName("user_agent")
@Expose
private String userAgent;
@SerializedName("status")
@Expose
private String status;
@SerializedName("started_at")
@Expose
private Integer startedAt;
@SerializedName("paid_at")
@Expose
private Integer paidAt;
@SerializedName("failed_at")
@Expose
private Integer failedAt;
@SerializedName("cancelled_at")
@Expose
private Integer cancelledAt;
@SerializedName("fail_reason")
@Expose
private String failReason;
@SerializedName("cancel_reason")
@Expose
private String cancelReason;
@SerializedName("receipt_url")
@Expose
private String receiptUrl;
@SerializedName("cancel_history")
@Expose
private List<CancelHistory> cancelHistory = null;
@SerializedName("cancel_receipt_urls")
@Expose
private List<String> cancelReceiptUrls = null;
@SerializedName("cash_receipt_issued")
@Expose
private Boolean cashReceiptIssued;
@SerializedName("customer_uid")
@Expose
private String customerUid;
@SerializedName("customer_uid_usage")
@Expose
private String customerUidUsage;

public String getImpUid() {
return impUid;
}

public void setImpUid(String impUid) {
this.impUid = impUid;
}

public String getMerchantUid() {
return merchantUid;
}

public void setMerchantUid(String merchantUid) {
this.merchantUid = merchantUid;
}

public String getPayMethod() {
return payMethod;
}

public void setPayMethod(String payMethod) {
this.payMethod = payMethod;
}

public String getChannel() {
return channel;
}

public void setChannel(String channel) {
this.channel = channel;
}

public String getPgProvider() {
return pgProvider;
}

public void setPgProvider(String pgProvider) {
this.pgProvider = pgProvider;
}

public String getEmbPgProvider() {
return embPgProvider;
}

public void setEmbPgProvider(String embPgProvider) {
this.embPgProvider = embPgProvider;
}

public String getPgTid() {
return pgTid;
}

public void setPgTid(String pgTid) {
this.pgTid = pgTid;
}

public String getPgId() {
return pgId;
}

public void setPgId(String pgId) {
this.pgId = pgId;
}

public Boolean getEscrow() {
return escrow;
}

public void setEscrow(Boolean escrow) {
this.escrow = escrow;
}

public String getApplyNum() {
return applyNum;
}

public void setApplyNum(String applyNum) {
this.applyNum = applyNum;
}

public String getBankCode() {
return bankCode;
}

public void setBankCode(String bankCode) {
this.bankCode = bankCode;
}

public String getBankName() {
return bankName;
}

public void setBankName(String bankName) {
this.bankName = bankName;
}

public String getCardCode() {
return cardCode;
}

public void setCardCode(String cardCode) {
this.cardCode = cardCode;
}

public String getCardName() {
return cardName;
}

public void setCardName(String cardName) {
this.cardName = cardName;
}

public Integer getCardQuota() {
return cardQuota;
}

public void setCardQuota(Integer cardQuota) {
this.cardQuota = cardQuota;
}

public String getCardNumber() {
return cardNumber;
}

public void setCardNumber(String cardNumber) {
this.cardNumber = cardNumber;
}

public String getCardType() {
return cardType;
}

public void setCardType(String cardType) {
this.cardType = cardType;
}

public String getVbankCode() {
return vbankCode;
}

public void setVbankCode(String vbankCode) {
this.vbankCode = vbankCode;
}

public String getVbankName() {
return vbankName;
}

public void setVbankName(String vbankName) {
this.vbankName = vbankName;
}

public String getVbankNum() {
return vbankNum;
}

public void setVbankNum(String vbankNum) {
this.vbankNum = vbankNum;
}

public String getVbankHolder() {
return vbankHolder;
}

public void setVbankHolder(String vbankHolder) {
this.vbankHolder = vbankHolder;
}

public Integer getVbankDate() {
return vbankDate;
}

public void setVbankDate(Integer vbankDate) {
this.vbankDate = vbankDate;
}

public Integer getVbankIssuedAt() {
return vbankIssuedAt;
}

public void setVbankIssuedAt(Integer vbankIssuedAt) {
this.vbankIssuedAt = vbankIssuedAt;
}

public String getName() {
return name;
}

public void setName(String name) {
this.name = name;
}

public Integer getAmount() {
return amount;
}

public void setAmount(Integer amount) {
this.amount = amount;
}

public Integer getCancelAmount() {
return cancelAmount;
}

public void setCancelAmount(Integer cancelAmount) {
this.cancelAmount = cancelAmount;
}

public String getCurrency() {
return currency;
}

public void setCurrency(String currency) {
this.currency = currency;
}

public String getBuyerName() {
return buyerName;
}

public void setBuyerName(String buyerName) {
this.buyerName = buyerName;
}

public String getBuyerEmail() {
return buyerEmail;
}

public void setBuyerEmail(String buyerEmail) {
this.buyerEmail = buyerEmail;
}

public String getBuyerTel() {
return buyerTel;
}

public void setBuyerTel(String buyerTel) {
this.buyerTel = buyerTel;
}

public String getBuyerAddr() {
return buyerAddr;
}

public void setBuyerAddr(String buyerAddr) {
this.buyerAddr = buyerAddr;
}

public String getBuyerPostcode() {
return buyerPostcode;
}

public void setBuyerPostcode(String buyerPostcode) {
this.buyerPostcode = buyerPostcode;
}

public String getCustomData() {
return customData;
}

public void setCustomData(String customData) {
this.customData = customData;
}

public String getUserAgent() {
return userAgent;
}

public void setUserAgent(String userAgent) {
this.userAgent = userAgent;
}

public String getStatus() {
return status;
}

public void setStatus(String status) {
this.status = status;
}

public Integer getStartedAt() {
return startedAt;
}

public void setStartedAt(Integer startedAt) {
this.startedAt = startedAt;
}

public Integer getPaidAt() {
return paidAt;
}

public void setPaidAt(Integer paidAt) {
this.paidAt = paidAt;
}

public Integer getFailedAt() {
return failedAt;
}

public void setFailedAt(Integer failedAt) {
this.failedAt = failedAt;
}

public Integer getCancelledAt() {
return cancelledAt;
}

public void setCancelledAt(Integer cancelledAt) {
this.cancelledAt = cancelledAt;
}

public String getFailReason() {
return failReason;
}

public void setFailReason(String failReason) {
this.failReason = failReason;
}

public String getCancelReason() {
return cancelReason;
}

public void setCancelReason(String cancelReason) {
this.cancelReason = cancelReason;
}

public String getReceiptUrl() {
return receiptUrl;
}

public void setReceiptUrl(String receiptUrl) {
this.receiptUrl = receiptUrl;
}

public List<CancelHistory> getCancelHistory() {
return cancelHistory;
}

public void setCancelHistory(List<CancelHistory> cancelHistory) {
this.cancelHistory = cancelHistory;
}

public List<String> getCancelReceiptUrls() {
return cancelReceiptUrls;
}

public void setCancelReceiptUrls(List<String> cancelReceiptUrls) {
this.cancelReceiptUrls = cancelReceiptUrls;
}

public Boolean getCashReceiptIssued() {
return cashReceiptIssued;
}

public void setCashReceiptIssued(Boolean cashReceiptIssued) {
this.cashReceiptIssued = cashReceiptIssued;
}

public String getCustomerUid() {
return customerUid;
}

public void setCustomerUid(String customerUid) {
this.customerUid = customerUid;
}

public String getCustomerUidUsage() {
return customerUidUsage;
}

public void setCustomerUidUsage(String customerUidUsage) {
this.customerUidUsage = customerUidUsage;
}

}