 package com.gcj.service;
 
 import com.gcj.domain.Comment;
 import com.gcj.domain.FlowerBean;
 import com.gcj.domain.OrderInfo;
 import com.gcj.domain.Users;
 import com.gcj.utils.SqlHelper;
 import java.sql.Connection;
 import java.sql.PreparedStatement;
 import java.sql.ResultSet;
 import java.sql.SQLException;
 import java.sql.Statement;
 import java.util.ArrayList;
 
 public class CommentService
 {
   private ResultSet rs = null;
   private Connection ct = null;
   private PreparedStatement ps = null;
 
   public boolean insertComments(OrderInfo orderInfo, ArrayList floweral, Users user, String[] comments)
   {
     boolean b = true;
     try
     {
       this.ct = SqlHelper.getConnection();
 
       Statement sm = this.ct.createStatement();
       for (int i = 0; i < floweral.size(); i++) {
         FlowerBean flower = (FlowerBean)floweral.get(i);
         sm.addBatch("insert into comment(orderid,username,usercomment,commenttime,flowerid) values(" + orderInfo.getId() + ",'" + user.getUsername() + "','" + comments[i] + "',now()," + flower.getFlowerid() + ")");
       }
 
       sm.executeBatch();
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
     return b;
   }
 
   public boolean isComment(OrderInfo orderInfo, Users user) {
     boolean b = true;
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from comment where orderid=? and username=?");
       this.ps.setInt(1, orderInfo.getId());
       this.ps.setString(2, user.getUsername());
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next())
         b = false;
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public ArrayList getAllFlowerCommentById(String flowerid)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from comment where flowerid=?");
       this.ps.setString(1, flowerid);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         Comment comment = new Comment();
         comment.setOrderid(this.rs.getInt(1));
         comment.setUsername(this.rs.getString(2));
         comment.setUsercomment(this.rs.getString(3));
         comment.setCommenttime(this.rs.getDate(4));
         comment.setAdmincomment(this.rs.getString(5));
         comment.setFlowerid(this.rs.getInt(6));
         al.add(comment);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public ArrayList getCommentByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from comment limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         Comment comment = new Comment();
         comment.setOrderid(this.rs.getInt(1));
         comment.setUsername(this.rs.getString(2));
         comment.setUsercomment(this.rs.getString(3));
         comment.setCommenttime(this.rs.getDate(4));
         comment.setAdmincomment(this.rs.getString(5));
         comment.setFlowerid(this.rs.getInt(6));
         al.add(comment);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public int getPageCount(int pageSize)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from comment");
 
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
 
   public Comment getCommentByOrderFlowerid(String orderid, String flowerid)
   {
     Comment comment = new Comment();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from comment where orderid=? and flowerid=?");
       this.ps.setString(1, orderid);
       this.ps.setString(2, flowerid);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         comment.setOrderid(this.rs.getInt(1));
         comment.setUsername(this.rs.getString(2));
         comment.setUsercomment(this.rs.getString(3));
         comment.setCommenttime(this.rs.getDate(4));
         comment.setAdmincomment(this.rs.getString(5));
         comment.setFlowerid(this.rs.getInt(6));
       }
     }
     catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return comment;
   }
 
   public boolean updComment(String content, String orderid, String flowerid) {
     boolean b = true;
     try
     {
       String sql = "update comment set admincomment=? where orderid=? and flowerid=?";
       String[] parameters = { content, orderid, flowerid };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public boolean isZhuiJia(String orderid, String flowerid)
   {
     boolean b = true;
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select admincomment from comment where orderid=? and flowerid=?");
       this.ps.setString(1, orderid);
       this.ps.setString(2, flowerid);
       this.rs = this.ps.executeQuery();
 
       if ((this.rs.next()) && 
         (this.rs.getString(1) == null)) {
         b = false;
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return b;
   }
 }
