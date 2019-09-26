 package com.gcj.domain;
 
 public class OrderItem
 {
   private int id;
   private int ordersid;
   private int flowerid;
   private int flowernum;
 
   public int getId()
   {
     return this.id;
   }
   public void setId(int id) {
     this.id = id;
   }
   public int getOrdersid() {
     return this.ordersid;
   }
   public void setOrdersid(int ordersid) {
     this.ordersid = ordersid;
   }
   public int getFlowerid() {
     return this.flowerid;
   }
   public void setFlowerid(int flowerid) {
     this.flowerid = flowerid;
   }
   public int getFlowernum() {
     return this.flowernum;
   }
   public void setFlowernum(int flowernum) {
     this.flowernum = flowernum;
   }
 }
 