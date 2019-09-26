 package com.gcj.domain;
 
 import java.sql.Date;
 
 public class OrderInfo
 {
   private int userid;
   private String username;
   private String truename;
   private String sex;
   private String passwd;
   private String email;
   private String phone;
   private String address;
   private String postcode;
   private int grade;
   private int score;
   private int id;
   private Date orderDate;
   private String payMode;
   private String isPayed;
   private float totalPrice;
   private String extraInfo;
   private String sendAddress;
   private String tradestate;
 
   public int getUserid()
   {
     return this.userid;
   }
   public void setUserid(int userid) {
     this.userid = userid;
   }
   public String getUsername() {
     return this.username;
   }
   public void setUsername(String username) {
     this.username = username;
   }
   public String getTruename() {
     return this.truename;
   }
   public void setTruename(String truename) {
     this.truename = truename;
   }
   public String getSex() {
     return this.sex;
   }
   public void setSex(String sex) {
     this.sex = sex;
   }
   public String getPasswd() {
     return this.passwd;
   }
   public void setPasswd(String passwd) {
     this.passwd = passwd;
   }
   public String getEmail() {
     return this.email;
   }
   public void setEmail(String email) {
     this.email = email;
   }
   public String getPhone() {
     return this.phone;
   }
   public void setPhone(String phone) {
     this.phone = phone;
   }
   public String getAddress() {
     return this.address;
   }
   public void setAddress(String address) {
     this.address = address;
   }
   public String getPostcode() {
     return this.postcode;
   }
   public void setPostcode(String postcode) {
     this.postcode = postcode;
   }
   public int getGrade() {
     return this.grade;
   }
   public void setGrade(int grade) {
     this.grade = grade;
   }
   public int getScore() {
     return this.score;
   }
   public void setScore(int score) {
     this.score = score;
   }
   public int getId() {
     return this.id;
   }
   public void setId(int id) {
     this.id = id;
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
   public String getIsPayed() {
     return this.isPayed;
   }
   public void setIsPayed(String isPayed) {
     this.isPayed = isPayed;
   }
   public String getTradestate() {
     return this.tradestate;
   }
   public void setTradestate(String tradestate) {
     this.tradestate = tradestate;
   }
 }
 