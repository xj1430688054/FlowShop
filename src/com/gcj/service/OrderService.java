 package com.gcj.service;
 
 import com.gcj.domain.CancelOrder;
 import com.gcj.domain.ExtraInfo;
 import com.gcj.domain.FlowerBean;
 import com.gcj.domain.Order;
 import com.gcj.domain.OrderInfo;
 import com.gcj.domain.OrderItem;
 import com.gcj.domain.Users;
 import com.gcj.utils.SqlHelper;
 import java.io.PrintStream;
 import java.sql.Connection;
 import java.sql.PreparedStatement;
 import java.sql.ResultSet;
 import java.sql.SQLException;
 import java.sql.Statement;
 import java.util.ArrayList;
 
 public class OrderService
 {
   private ResultSet rs = null;
   private Connection ct = null;
   private PreparedStatement ps = null;
 
   public OrderInfo addOrder(FlowerBean flower, FlowerService flowerService, Users user, ExtraInfo extraInfo)
   {
     boolean b = true;
     OrderInfo orderInfo = new OrderInfo();
     try
     {
       this.ct = SqlHelper.getConnection();
 
       this.ct.setAutoCommit(false);
       System.out.println("=====程序执行到这里了1====");
 
       this.ct.setTransactionIsolation(8);
 
       this.ps = this.ct.prepareStatement("insert into orders(userid,orderDate,paymode,extrainfo,totalprice,sendaddress,ispayed) values(?,null,?,?,?,?)");
 
       this.ps.setInt(1, user.getUserid());
       this.ps.setString(2, extraInfo.getPaymode());
       this.ps.setString(3, extraInfo.getExtrainfo());
       this.ps.setDouble(4, flowerService.getSinglePrice(flower));
       this.ps.setString(5, extraInfo.getSendaddress());
       this.ps.setString(5, extraInfo.getIspayed());
 
       int a = this.ps.executeUpdate();
       if (a == 1)
       {
         String sql1 = "select LAST_INSERT_ID() from orders";
         this.ps = this.ct.prepareStatement(sql1);
         this.rs = this.ps.executeQuery();
         int orderId = 0;
         if (this.rs.next()) {
           orderId = this.rs.getInt(1);
         }
 
         this.ps = this.ct.prepareStatement("insert into ordersitem(ordersid,flowerid,flowernum) values('" + orderId + "','" + flower.getFlowerid() + "','" + flower.getReservenums() + "')");
         this.ps.executeUpdate();
 
         this.ct.commit();
 
         String sql = "select id,truename,address,postcode,phone,totalprice,username,email,orderDate from users,orders where id=? and users.userid=(select orders.userid from orders where id=?)";
 
         this.ps = this.ct.prepareStatement(sql);
         this.ps.setInt(1, orderId);
         this.ps.setInt(2, orderId);
         this.rs = this.ps.executeQuery();
 
         if (this.rs.next())
         {
           orderInfo.setId(this.rs.getInt(1));
           orderInfo.setTruename(this.rs.getString(2));
           orderInfo.setAddress(this.rs.getString(3));
           orderInfo.setPostcode(this.rs.getString(4));
           orderInfo.setPhone(this.rs.getString(5));
           orderInfo.setTotalPrice(this.rs.getFloat(6));
           orderInfo.setUsername(this.rs.getString(7));
           orderInfo.setEmail(this.rs.getString(8));
           orderInfo.setOrderDate(this.rs.getDate(9));
         }
       }
     }
     catch (Exception e)
     {
       b = false;
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
 
     if (b) {
       return orderInfo;
     }
     return null;
   }
 
   public int addOrder1(FlowerBean flower, FlowerService flowerService, Users user, ExtraInfo extraInfo)
   {
     boolean b = true;
     int orderId = 0;
     try
     {
       this.ct = SqlHelper.getConnection();
 
       this.ct.setAutoCommit(false);
       System.out.println("=====程序执行到这里了1====");
 
       this.ct.setTransactionIsolation(8);
 
       this.ps = this.ct.prepareStatement("insert into orders(userid,orderDate,paymode,extrainfo,totalprice,sendaddress,ispayed) values(?,null,?,?,?,?,?)");
 
       this.ps.setInt(1, user.getUserid());
       this.ps.setString(2, extraInfo.getPaymode());
       this.ps.setString(3, extraInfo.getExtrainfo());
       this.ps.setDouble(4, flowerService.getSinglePrice(flower));
       this.ps.setString(5, extraInfo.getSendaddress());
       this.ps.setString(6, extraInfo.getIspayed());
 
       int a = this.ps.executeUpdate();
       if (a == 1)
       {
         String sql1 = "select LAST_INSERT_ID() from orders";
         this.ps = this.ct.prepareStatement(sql1);
         this.rs = this.ps.executeQuery();
 
         if (this.rs.next()) {
           orderId = this.rs.getInt(1);
         }
 
         this.ps = this.ct.prepareStatement("insert into ordersitem(ordersid,flowerid,flowernum) values('" + orderId + "','" + flower.getFlowerid() + "','" + flower.getReservenums() + "')");
         this.ps.executeUpdate();
 
         this.ct.commit();
       }
 
     }
     catch (Exception e)
     {
       b = false;
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
 
     if (b) {
       return orderId;
     }
     return -1;
   }
 
   public OrderInfo getOrderInfoById(String id)
   {
     OrderInfo orderInfo = new OrderInfo();
     int orderid = Integer.parseInt(id);
     this.ct = SqlHelper.getConnection();
 
     String sql = "select id,truename,address,postcode,phone,totalprice,username,email,orderDate,paymode,ispayed,sendaddress,extraInfo,tradestate from users,orders where id=? and users.userid=(select orders.userid from orders where id=?)";
     try
     {
       this.ps = this.ct.prepareStatement(sql);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try {
       this.ps.setInt(1, orderid);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try {
       this.ps.setInt(2, orderid);
     }
     catch (SQLException e) {
       e.printStackTrace();
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
         orderInfo.setId(this.rs.getInt(1));
         orderInfo.setTruename(this.rs.getString(2));
         orderInfo.setAddress(this.rs.getString(3));
         orderInfo.setPostcode(this.rs.getString(4));
         orderInfo.setPhone(this.rs.getString(5));
         orderInfo.setTotalPrice(this.rs.getFloat(6));
         orderInfo.setUsername(this.rs.getString(7));
         orderInfo.setEmail(this.rs.getString(8));
         orderInfo.setOrderDate(this.rs.getDate(9));
         orderInfo.setPayMode(this.rs.getString(10));
         orderInfo.setIsPayed(this.rs.getString(11));
         orderInfo.setSendAddress(this.rs.getString(12));
         orderInfo.setExtraInfo(this.rs.getString(13));
         orderInfo.setTradestate(this.rs.getString(14));
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
 
     return orderInfo;
   }
 
   public ArrayList getAllOrdersByUserId(String id)
   {
     ArrayList al = new ArrayList();
     int userid = Integer.parseInt(id);
     this.ct = SqlHelper.getConnection();
 
     String sql = "select orders.id,truename,address,postcode,phone,totalprice,username,email,orderDate,paymode,ispayed,sendaddress,extraInfo,tradestate from users,orders where users.userid=? and users.userid=orders.userid";
     try
     {
       this.ps = this.ct.prepareStatement(sql);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try {
       this.ps.setInt(1, userid);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try {
       this.rs = this.ps.executeQuery();
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try
     {
       while (this.rs.next())
       {
         OrderInfo orderInfo = new OrderInfo();
         orderInfo.setId(this.rs.getInt(1));
         orderInfo.setTruename(this.rs.getString(2));
         orderInfo.setAddress(this.rs.getString(3));
         orderInfo.setPostcode(this.rs.getString(4));
         orderInfo.setPhone(this.rs.getString(5));
         orderInfo.setTotalPrice(this.rs.getFloat(6));
         orderInfo.setUsername(this.rs.getString(7));
         orderInfo.setEmail(this.rs.getString(8));
         orderInfo.setOrderDate(this.rs.getDate(9));
         orderInfo.setPayMode(this.rs.getString(10));
         orderInfo.setIsPayed(this.rs.getString(11));
         orderInfo.setSendAddress(this.rs.getString(12));
         orderInfo.setExtraInfo(this.rs.getString(13));
         orderInfo.setTradestate(this.rs.getString(14));
         al.add(orderInfo);
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
 
   public int addOrderByMyCart(MyCart myCart, Users user, ExtraInfo extraInfo)
   {
     boolean b = true;
     int orderId = 0;
     try
     {
       this.ct = SqlHelper.getConnection();
 
       this.ct.setAutoCommit(false);
       System.out.println("=====程序执行到这里了,通过购物车提交订单====");
 
       this.ct.setTransactionIsolation(8);
 
       this.ps = this.ct.prepareStatement("insert into orders(userid,orderDate,paymode,extrainfo,totalprice,sendaddress,ispayed) values(?,null,?,?,?,?,?)");
 
       this.ps.setInt(1, user.getUserid());
       this.ps.setString(2, extraInfo.getPaymode());
       this.ps.setString(3, extraInfo.getExtrainfo());
       this.ps.setDouble(4, myCart.getTotalPrice());
       this.ps.setString(5, extraInfo.getSendaddress());
       this.ps.setString(6, extraInfo.getIspayed());
 
       int a = this.ps.executeUpdate();
       if (a == 1)
       {
         String sql1 = "select LAST_INSERT_ID() from orders";
         this.ps = this.ct.prepareStatement(sql1);
         this.rs = this.ps.executeQuery();
 
         if (this.rs.next()) {
           orderId = this.rs.getInt(1);
         }
 
         ArrayList al = myCart.showMyCart();
 
         Statement sm = this.ct.createStatement();
         for (int i = 0; i < al.size(); i++) {
           FlowerBean flower = (FlowerBean)al.get(i);
           sm.addBatch("insert into ordersItem(ordersid,flowerid,flowernum) values('" + orderId + "','" + flower.getFlowerid() + "','" + myCart.getFlowerNumById(""+flower.getFlowerid()) + "')");
         }
 
         sm.executeBatch();
         this.ct.commit();
       }
     }
     catch (Exception e) {
       b = false;
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
 
     if (b) {
       return orderId;
     }
     return -1;
   }
 
   public ArrayList getOrderDetailById(String id)
   {
     ArrayList al = new ArrayList();
     int orderid = Integer.parseInt(id);
     this.ct = SqlHelper.getConnection();
 
     String sql = "select ordersid,flowerid,flowernum from ordersitem where ordersid=?";
     try
     {
       this.ps = this.ct.prepareStatement(sql);
     }
     catch (SQLException e) {
       e.printStackTrace();
     }
     try {
       this.ps.setInt(1, orderid);
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
       while (this.rs.next()) {
         OrderItem orderItem = new OrderItem();
 
         orderItem.setOrdersid(this.rs.getInt(1));
         orderItem.setFlowerid(this.rs.getInt(2));
         orderItem.setFlowernum(this.rs.getInt(3));
         al.add(orderItem);
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
 
   public boolean updOrders(String orderid, String state)
   {
     boolean b = true;
     try
     {
       String sql = "update orders set tradestate=?,ispayed='是' where id=?";
       String[] parameters = { state, orderid };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public boolean insertCancelorder(String orderid, String reason)
   {
     boolean b = true;
     String state = "交易关闭";
     try
     {
       String sql = "insert into cancelorder(orderid,cancelreason,canceltime,tradestate) values(?,?,now(),?)";
       String[] parameters = { orderid, reason, state };
       SqlHelper.executeUpdate(sql, parameters);
     }
     catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return b;
   }
 
   public CancelOrder getCancelOrderById(String id) {
     CancelOrder cancelOrder = new CancelOrder();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from cancelorder where orderid=?");
       this.ps.setString(1, id);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         cancelOrder.setOrderid(this.rs.getInt(1));
         cancelOrder.setCancelreason(this.rs.getString(2));
         cancelOrder.setCanceltime(this.rs.getDate(3));
         cancelOrder.setTradestate(this.rs.getString(4));
       }
     }
     catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return cancelOrder;
   }
 
   public int getPageCount(int pageSize)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from orders");
 
       this.rs = this.ps.executeQuery();
       if (this.rs.next()) {
         rowCount = this.rs.getInt(1);
       }
       if (rowCount % pageSize == 0)
         pageCount = rowCount / pageSize;
       else
         pageCount = rowCount / pageSize + 1;
     }
     catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return pageCount;
   }
 
   public ArrayList getOrdersByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from orders limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         Order order = new Order();
         order.setId(this.rs.getInt(1));
         order.setUserid(this.rs.getInt(2));
         order.setOrderDate(this.rs.getDate(3));
         order.setPayMode(this.rs.getString(4));
         order.setExtraInfo(this.rs.getString(5));
         order.setTotalPrice(this.rs.getFloat(6));
         order.setSendAddress(this.rs.getString(7));
         order.setIsPayed(this.rs.getString(8));
         order.setTradestate(this.rs.getString(9));
         al.add(order);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public ArrayList getgoingOrdersByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from orders where tradestate='交易中' limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         Order order = new Order();
         order.setId(this.rs.getInt(1));
         order.setUserid(this.rs.getInt(2));
         order.setOrderDate(this.rs.getDate(3));
         order.setPayMode(this.rs.getString(4));
         order.setExtraInfo(this.rs.getString(5));
         order.setTotalPrice(this.rs.getFloat(6));
         order.setSendAddress(this.rs.getString(7));
         order.setIsPayed(this.rs.getString(8));
         order.setTradestate(this.rs.getString(9));
         al.add(order);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public int getGoingPageCount(int pageSize)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from orders where tradestate='交易中'");
 
       this.rs = this.ps.executeQuery();
       if (this.rs.next()) {
         rowCount = this.rs.getInt(1);
       }
       if (rowCount % pageSize == 0)
         pageCount = rowCount / pageSize;
       else
         pageCount = rowCount / pageSize + 1;
     }
     catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return pageCount;
   }
 
   public ArrayList getfinishOrdersByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from orders where tradestate='交易成功' limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         Order order = new Order();
         order.setId(this.rs.getInt(1));
         order.setUserid(this.rs.getInt(2));
         order.setOrderDate(this.rs.getDate(3));
         order.setPayMode(this.rs.getString(4));
         order.setExtraInfo(this.rs.getString(5));
         order.setTotalPrice(this.rs.getFloat(6));
         order.setSendAddress(this.rs.getString(7));
         order.setIsPayed(this.rs.getString(8));
         order.setTradestate(this.rs.getString(9));
         al.add(order);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public int getFinishPageCount(int pageSize)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from orders where tradestate='交易成功'");
 
       this.rs = this.ps.executeQuery();
       if (this.rs.next()) {
         rowCount = this.rs.getInt(1);
       }
       if (rowCount % pageSize == 0)
         pageCount = rowCount / pageSize;
       else
         pageCount = rowCount / pageSize + 1;
     }
     catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return pageCount;
   }
 
   public ArrayList getcancelOrdersByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from cancelorder limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         CancelOrder cancelOrder = new CancelOrder();
         cancelOrder.setOrderid(this.rs.getInt(1));
         cancelOrder.setCancelreason(this.rs.getString(2));
         cancelOrder.setCanceltime(this.rs.getDate(3));
         cancelOrder.setTradestate(this.rs.getString(4));
         al.add(cancelOrder);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public int getCancelPageCount(int pageSize)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from cancelorder");
 
       this.rs = this.ps.executeQuery();
       if (this.rs.next()) {
         rowCount = this.rs.getInt(1);
       }
       if (rowCount % pageSize == 0)
         pageCount = rowCount / pageSize;
       else
         pageCount = rowCount / pageSize + 1;
     }
     catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return pageCount;
   }
 }