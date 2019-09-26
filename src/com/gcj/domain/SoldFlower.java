 package com.gcj.domain;
 
 import java.sql.Date;
 
 public class SoldFlower
 {
   private int id;
   private int flowerid;
   private String flowername;
   private Date reservetime;
   private int soldnum;
   private String flowerunit;
   private String tradestate;
 
   public int getId()
   {
     return this.id;
   }
   public void setId(int id) {
     this.id = id;
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
   public Date getReservetime() {
     return this.reservetime;
   }
   public void setReservetime(Date reservetime) {
     this.reservetime = reservetime;
   }
   public int getSoldnum() {
     return this.soldnum;
   }
   public void setSoldnum(int soldnum) {
     this.soldnum = soldnum;
   }
   public String getFlowerunit() {
     return this.flowerunit;
   }
   public void setFlowerunit(String flowerunit) {
     this.flowerunit = flowerunit;
   }
   public String getTradestate() {
     return this.tradestate;
   }
   public void setTradestate(String tradestate) {
     this.tradestate = tradestate;
   }
 }
 