 package com.gcj.domain;
 
 import java.sql.Date;
 
 public class Order
 {
   private int id;
   private int userid;
   private Date orderDate;
   private String payMode;
   private String isPayed;
   private float totalPrice;
   private String extraInfo;
   private String sendAddress;
   private String tradestate;
 
   public int getId()
   {
     return this.id;
   }
   public void setId(int id) {
     this.id = id;
   }
   public int getUserid() {
     return this.userid;
   }
   public void setUserid(int userid) {
     this.userid = userid;
   }
   public Date getOrderDate() {
     return this.orderDate;
   }
   public void setOrderDate(Date orderDate) {
     this.orderDate = orderDate;
   }
   public String getPayMode() {
     return this.payMode;
   }
   public void setPayMode(String payMode) {
     this.payMode = payMode;
   }
   public float getTotalPrice() {
     return this.totalPrice;
   }
   public void setTotalPrice(float totalPrice) {
     this.totalPrice = totalPrice;
   }
   public String getExtraInfo() {
     return this.extraInfo;
   }
   public void setExtraInfo(String extraInfo) {
     this.extraInfo = extraInfo;
   }
   public String getSendAddress() {
     return this.sendAddress;
   }
   public void setSendAddress(String sendAddress) {
     this.sendAddress = sendAddress;
   }
   public String getTradestate() {
     return this.tradestate;
   }
   public void setTradestate(String tradestate) {
     this.tradestate = tradestate;
   }
   public String getIsPayed() {
     return this.isPayed;
   }
   public void setIsPayed(String isPayed) {
     this.isPayed = isPayed;
   }
 }
 