 package com.gcj.service;
 
 import com.gcj.domain.FlowerBean;
 import com.gcj.utils.SqlHelper;
 import java.io.PrintStream;
 import java.sql.Connection;
 import java.sql.PreparedStatement;
 import java.sql.ResultSet;
 import java.sql.Statement;
 import java.util.ArrayList;
 import java.util.HashMap;
 import java.util.Iterator;
 import java.util.LinkedHashMap;
 import java.util.Set;
 
 public class MyCart
 {
   private ResultSet rs = null;
   private Connection ct = null;
   private PreparedStatement ps = null;
   private Statement sm = null;
   private double totalPrice = 0.0D;
 
   HashMap<String, String> hm = new LinkedHashMap();
 
   public String getFlowerNumById(String flowerId)
   {
     return (String)this.hm.get(flowerId);
   }
 
   public void addFlower(String flowerId, String flowerNum)
   {
     this.hm.put(flowerId, flowerNum);
   }
 
   public void delFlower(String flowerId) {
     this.hm.remove(flowerId);
   }
 
   public void clearFlower()
   {
     this.hm.clear();
   }
 
   public void upFlower(String flowerId, String newNum)
   {
     this.hm.put(flowerId, newNum);
   }
 
   public ArrayList showMyCart()
   {
     ArrayList al = new ArrayList();
     try {
       this.ct = SqlHelper.getConnection();
 
       String sql = "select * from flower where flowerid in ";
 
       Iterator iterator = this.hm.keySet().iterator();
       if (iterator.hasNext()) {
         String sub = "(";
         while (iterator.hasNext())
         {
           String flowerId = (String)iterator.next();
           System.out.println("flowerId=" + flowerId);
           if (iterator.hasNext())
             sub = sub + flowerId + ",";
           else {
             sub = sub + flowerId + ")";
           }
         }
         sql = sql + sub;
       } else {
         sql = sql + "('')";
       }
       System.out.println("sql=" + sql);
       this.ps = this.ct.prepareStatement(sql);
       this.rs = this.ps.executeQuery();
 
       this.totalPrice = 0.0D;
       while (this.rs.next()) {
         FlowerBean flower = new FlowerBean();
         flower.setFlowerid(this.rs.getInt(1));
         flower.setFlowername(this.rs.getString(2));
         flower.setFlowerintro(this.rs.getString(3));
         flower.setFlowerprice(this.rs.getDouble(4));
         flower.setFlowernum(this.rs.getInt(5));
         flower.setPhoto(this.rs.getString(6));
         flower.setFlowertype(this.rs.getString(7));
         flower.setMarketprice(this.rs.getDouble(8));
         flower.setStartsale(this.rs.getInt(9));
         flower.setFlowerunit(this.rs.getString(10));
         flower.setFlowerfield(this.rs.getString(11));
         int flowerId = this.rs.getInt(1);
         double price = this.rs.getDouble(4);
         this.totalPrice += price * Integer.parseInt(getFlowerNumById(""+flowerId));
         al.add(flower);
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     }
 
     return al;
   }
 
   public double getTotalPrice()
   {
     this.totalPrice = (Math.round(this.totalPrice * 100000.0D) / 100000.0D);
     return this.totalPrice;
   }
 }
