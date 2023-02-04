package com.E1I4.project.admin.dto;

import javax.annotation.Generated;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Generated("jsonschema2pojo")
public class CancelHistory {

@SerializedName("pg_tid")
@Expose
private String pgTid;
@SerializedName("amount")
@Expose
private Integer amount;
@SerializedName("cancelled_at")
@Expose
private Integer cancelledAt;
@SerializedName("reason")
@Expose
private String reason;
@SerializedName("receipt_url")
@Expose
private String receiptUrl;

public String getPgTid() {
return pgTid;
}

public void setPgTid(String pgTid) {
this.pgTid = pgTid;
}

public Integer getAmount() {
return amount;
}

public void setAmount(Integer amount) {
this.amount = amount;
}

public Integer getCancelledAt() {
return cancelledAt;
}

public void setCancelledAt(Integer cancelledAt) {
this.cancelledAt = cancelledAt;
}

public String getReason() {
return reason;
}

public void setReason(String reason) {
this.reason = reason;
}

public String getReceiptUrl() {
return receiptUrl;
}

public void setReceiptUrl(String receiptUrl) {
this.receiptUrl = receiptUrl;
}

}