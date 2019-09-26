 package com.gcj.domain;
 
 import java.sql.Date;
 
 public class RestoreFlower
 {
   private int id;
   private int userid;
   private int flowerid;
   private String flowername;
   private String photo;
   private double flowerprice;
   private double marketprice;
   private Date restoretime;
 
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
   public int getFlowerid() {
     return this.flowerid;
   }
   public void setFlowerid(int flowerid) {
     this.flowerid = flowerid;
   }
   public String getFlowername() {
     return this.flowername;
   }
   public void setFlowername(String flowername) {
     this.flowername = flowername;
   }
   public String getPhoto() {
     return this.photo;
   }
   public void setPhoto(String photo) {
     this.photo = photo;
   }
   public double getFlowerprice() {
     return this.flowerprice;
   }
   public void setFlowerprice(double flowerprice) {
     this.flowerprice = flowerprice;
   }
   public double getMarketprice() {
     return this.marketprice;
   }
   public void setMarketprice(double marketprice) {
     this.marketprice = marketprice;
   }
   public Date getRestoretime() {
     return this.restoretime;
   }
   public void setRestoretime(Date restoretime) {
     this.restoretime = restoretime;
   }
 }
 