 package com.gcj.service;
 
 import com.gcj.domain.HotFlower;
 import com.gcj.domain.SoldFlower;
 import com.gcj.utils.SqlHelper;
 import java.sql.Connection;
 import java.sql.PreparedStatement;
 import java.sql.ResultSet;
 import java.sql.SQLException;
 import java.util.ArrayList;
 
 public class OrderItemService
 {
   private ResultSet rs = null;
   private Connection ct = null;
   private PreparedStatement ps = null;
 
   public ArrayList getOrderItemFlower()
   {
     ArrayList al = new ArrayList();
 
     this.ct = SqlHelper.getConnection();
 
     String sql = "select ordersitem.flowerid,flowername,sum(ordersitem.flowernum) as totalnum,flowerunit from flower,ordersitem,orders where flower.flowerid=ordersitem.flowerid and orders.id=ordersitem.ordersid and orders.tradestate='交易成功' group by flowerid order by totalnum desc";
     try
     {
       this.ps = this.ct.prepareStatement(sql);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       this.rs = this.ps.executeQuery();
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       while (this.rs.next())
       {
         HotFlower hotFlower = new HotFlower();
 
         hotFlower.setFlowerid(this.rs.getInt(1));
         hotFlower.setFlowername(this.rs.getString(2));
         hotFlower.setTotalnum(this.rs.getInt(3));
         hotFlower.setFlowerunit(this.rs.getString(4));
 
         al.add(hotFlower);
       }
     }
     catch (SQLException e) {
       e.printStackTrace();
 
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e1) {
           e1.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e2) {
           e2.printStackTrace();
         }
       }
       if (this.ct != null)
         try {
           this.ct.close();
         }
         catch (SQLException e3) {
           e3.printStackTrace();
         }
     }
     finally
     {
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ct != null) {
         try {
           this.ct.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
     }
 
     return al;
   }
 
   public ArrayList getOrderedFlowerByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
 
     this.ct = SqlHelper.getConnection();
 
     String sql = "select ordersitem.flowerid,flowername,sum(ordersitem.flowernum) as totalnum,orderdate,flowerunit from flower,ordersitem,orders where flower.flowerid=ordersitem.flowerid and orders.id=ordersitem.ordersid group by flowerid order by totalnum desc limit " + (pageNow - 1) * pageSize + "," + pageSize;
     try
     {
       this.ps = this.ct.prepareStatement(sql);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       this.rs = this.ps.executeQuery();
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       while (this.rs.next())
       {
         SoldFlower soldFlower = new SoldFlower();
 
         soldFlower.setFlowerid(this.rs.getInt(1));
         soldFlower.setFlowername(this.rs.getString(2));
         soldFlower.setSoldnum(this.rs.getInt(3));
         soldFlower.setReservetime(this.rs.getDate(4));
         soldFlower.setFlowerunit(this.rs.getString(5));
         al.add(soldFlower);
       }
     }
     catch (SQLException e) {
       e.printStackTrace();
 
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e1) {
           e1.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e2) {
           e2.printStackTrace();
         }
       }
       if (this.ct != null)
         try {
           this.ct.close();
         }
         catch (SQLException e3) {
           e3.printStackTrace();
         }
     }
     finally
     {
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ct != null) {
         try {
           this.ct.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
     }
 
     return al;
   }
 
   public ArrayList getAllOrderedFlower()
   {
     ArrayList al = new ArrayList();
 
     this.ct = SqlHelper.getConnection();
 
     String sql = "select ordersitem.flowerid,flowername,sum(ordersitem.flowernum) as totalnum,orderdate,flowerunit from flower,ordersitem,orders where flower.flowerid=ordersitem.flowerid and orders.id=ordersitem.ordersid group by flowerid order by totalnum desc";
     try
     {
       this.ps = this.ct.prepareStatement(sql);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       this.rs = this.ps.executeQuery();
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       while (this.rs.next())
       {
         SoldFlower soldFlower = new SoldFlower();
 
         soldFlower.setFlowerid(this.rs.getInt(1));
         soldFlower.setFlowername(this.rs.getString(2));
         soldFlower.setSoldnum(this.rs.getInt(3));
         soldFlower.setReservetime(this.rs.getDate(4));
         soldFlower.setFlowerunit(this.rs.getString(5));
         al.add(soldFlower);
       }
     }
     catch (SQLException e) {
       e.printStackTrace();
 
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e1) {
           e1.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e2) {
           e2.printStackTrace();
         }
       }
       if (this.ct != null)
         try {
           this.ct.close();
         }
         catch (SQLException e3) {
           e3.printStackTrace();
         }
     }
     finally
     {
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ct != null) {
         try {
           this.ct.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
     }
 
     return al;
   }
 
   public ArrayList getAllReservedFlowerByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
 
     this.ct = SqlHelper.getConnection();
 
     String sql = "select ordersitem.flowerid,flowername,ordersitem.flowernum,orderdate,flowerunit from flower,ordersitem,orders where flower.flowerid=ordersitem.flowerid and orders.id=ordersitem.ordersid order by orderdate limit " + (pageNow - 1) * pageSize + "," + pageSize;
     try
     {
       this.ps = this.ct.prepareStatement(sql);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       this.rs = this.ps.executeQuery();
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       while (this.rs.next())
       {
         SoldFlower soldFlower = new SoldFlower();
 
         soldFlower.setFlowerid(this.rs.getInt(1));
         soldFlower.setFlowername(this.rs.getString(2));
         soldFlower.setSoldnum(this.rs.getInt(3));
         soldFlower.setReservetime(this.rs.getDate(4));
         soldFlower.setFlowerunit(this.rs.getString(5));
         al.add(soldFlower);
       }
     }
     catch (SQLException e) {
       e.printStackTrace();
 
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e1) {
           e1.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e2) {
           e2.printStackTrace();
         }
       }
       if (this.ct != null)
         try {
           this.ct.close();
         }
         catch (SQLException e3) {
           e3.printStackTrace();
         }
     }
     finally
     {
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ct != null) {
         try {
           this.ct.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
     }
 
     return al;
   }
 
   public ArrayList getAllReservedFlower()
   {
     ArrayList al = new ArrayList();
 
     this.ct = SqlHelper.getConnection();
 
     String sql = "select ordersitem.flowerid,flowername,ordersitem.flowernum,orderdate,flowerunit from flower,ordersitem,orders where flower.flowerid=ordersitem.flowerid and orders.id=ordersitem.ordersid order by orderdate";
     try {
       this.ps = this.ct.prepareStatement(sql);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       this.rs = this.ps.executeQuery();
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       while (this.rs.next())
       {
         SoldFlower soldFlower = new SoldFlower();
 
         soldFlower.setFlowerid(this.rs.getInt(1));
         soldFlower.setFlowername(this.rs.getString(2));
         soldFlower.setSoldnum(this.rs.getInt(3));
         soldFlower.setReservetime(this.rs.getDate(4));
         soldFlower.setFlowerunit(this.rs.getString(5));
         al.add(soldFlower);
       }
     }
     catch (SQLException e) {
       e.printStackTrace();
 
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e1) {
           e1.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e2) {
           e2.printStackTrace();
         }
       }
       if (this.ct != null)
         try {
           this.ct.close();
         }
         catch (SQLException e3) {
           e3.printStackTrace();
         }
     }
     finally
     {
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ct != null) {
         try {
           this.ct.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
     }
 
     return al;
   }
 
   public ArrayList getFinishFlowerByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
 
     this.ct = SqlHelper.getConnection();
 
     String sql = "select ordersitem.flowerid,flowername,sum(ordersitem.flowernum) as totalnum,orderdate,tradestate,flowerunit from flower,ordersitem,orders where flower.flowerid=ordersitem.flowerid and orders.id=ordersitem.ordersid and orders.tradestate='交易成功' group by flowerid order by totalnum desc limit " + (pageNow - 1) * pageSize + "," + pageSize;
     try
     {
       this.ps = this.ct.prepareStatement(sql);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       this.rs = this.ps.executeQuery();
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       while (this.rs.next())
       {
         SoldFlower soldFlower = new SoldFlower();
 
         soldFlower.setFlowerid(this.rs.getInt(1));
         soldFlower.setFlowername(this.rs.getString(2));
         soldFlower.setSoldnum(this.rs.getInt(3));
         soldFlower.setReservetime(this.rs.getDate(4));
         soldFlower.setTradestate(this.rs.getString(5));
         soldFlower.setFlowerunit(this.rs.getString(6));
         al.add(soldFlower);
       }
     }
     catch (SQLException e) {
       e.printStackTrace();
 
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e1) {
           e1.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e2) {
           e2.printStackTrace();
         }
       }
       if (this.ct != null)
         try {
           this.ct.close();
         }
         catch (SQLException e3) {
           e3.printStackTrace();
         }
     }
     finally
     {
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ct != null) {
         try {
           this.ct.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
     }
 
     return al;
   }
 
   public ArrayList getAllFinishFlower()
   {
     ArrayList al = new ArrayList();
 
     this.ct = SqlHelper.getConnection();
 
     String sql = "select ordersitem.flowerid,flowername,sum(ordersitem.flowernum) as totalnum,orderdate,tradestate from flower,ordersitem,orders where flower.flowerid=ordersitem.flowerid and orders.id=ordersitem.ordersid and orders.tradestate='交易成功' group by flowerid order by totalnum desc";
     try {
       this.ps = this.ct.prepareStatement(sql);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       this.rs = this.ps.executeQuery();
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       while (this.rs.next())
       {
         SoldFlower soldFlower = new SoldFlower();
 
         soldFlower.setFlowerid(this.rs.getInt(1));
         soldFlower.setFlowername(this.rs.getString(2));
         soldFlower.setSoldnum(this.rs.getInt(3));
         soldFlower.setReservetime(this.rs.getDate(4));
         soldFlower.setFlowerunit(this.rs.getString(5));
         al.add(soldFlower);
       }
     }
     catch (SQLException e) {
       e.printStackTrace();
 
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e1) {
           e1.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e2) {
           e2.printStackTrace();
         }
       }
       if (this.ct != null)
         try {
           this.ct.close();
         }
         catch (SQLException e3) {
           e3.printStackTrace();
         }
     }
     finally
     {
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ct != null) {
         try {
           this.ct.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
     }
 
     return al;
   }
 
   public int getTradeOkFlowerById(String flowerid)
   {
     int flowernum = 0;
 
     this.ct = SqlHelper.getConnection();
 
     String sql = "select ordersitem.flowerid,flowername,sum(ordersitem.flowernum) as totalnum,orderdate,tradestate from flower,ordersitem,orders where flower.flowerid=ordersitem.flowerid  and flower.flowerid=? and orders.id=ordersitem.ordersid and orders.tradestate='交易成功' group by flowerid";
     try {
       this.ps = this.ct.prepareStatement(sql);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try {
       this.ps.setString(1, flowerid);
     }
     catch (SQLException e1) {
       e1.printStackTrace();
     }
     try {
       this.rs = this.ps.executeQuery();
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       if (this.rs.next())
       {
         flowernum = this.rs.getInt(3);
       }
     }
     catch (SQLException e) {
       e.printStackTrace();
 
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e1) {
           e1.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e2) {
           e2.printStackTrace();
         }
       }
       if (this.ct != null)
         try {
           this.ct.close();
         }
         catch (SQLException e3) {
           e3.printStackTrace();
         }
     }
     finally
     {
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ct != null) {
         try {
           this.ct.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
     }
 
     return flowernum;
   }
 }
