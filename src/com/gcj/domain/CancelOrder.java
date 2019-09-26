 package com.gcj.domain;
 
 import java.sql.Date;
 
 public class CancelOrder
 {
   private int orderid;
   private String tradestate;
   private String cancelreason;
   private Date canceltime;
 
   public int getOrderid()
   {
     return this.orderid;
   }
   public void setOrderid(int orderid) {
     this.orderid = orderid;
   }
   public String getTradestate() {
     return this.tradestate;
   }
   public void setTradestate(String tradestate) {
     this.tradestate = tradestate;
   }
   public String getCancelreason() {
     return this.cancelreason;
   }
   public void setCancelreason(String cancelreason) {
     this.cancelreason = cancelreason;
   }
   public Date getCanceltime() {
     return this.canceltime;
   }
   public void setCanceltime(Date canceltime) {
     this.canceltime = canceltime;
   }
 }