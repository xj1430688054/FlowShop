 package com.gcj.domain;
 
 import java.sql.Date;
 
 public class Comment
 {
   private int orderid;
   private String username;
   private String usercomment;
   private Date commenttime;
   private String admincomment;
   private int flowerid;
 
   public int getOrderid()
   {
     return this.orderid;
   }
   public void setOrderid(int orderid) {
     this.orderid = orderid;
   }
   public String getUsername() {
     return this.username;
   }
   public void setUsername(String username) {
     this.username = username;
   }
   public String getUsercomment() {
     return this.usercomment;
   }
   public void setUsercomment(String usercomment) {
     this.usercomment = usercomment;
   }
   public Date getCommenttime() {
     return this.commenttime;
   }
   public void setCommenttime(Date commenttime) {
     this.commenttime = commenttime;
   }
   public String getAdmincomment() {
     return this.admincomment;
   }
   public void setAdmincomment(String admincomment) {
     this.admincomment = admincomment;
   }
   public int getFlowerid() {
     return this.flowerid;
   }
   public void setFlowerid(int flowerid) {
     this.flowerid = flowerid;
   }
 }
 