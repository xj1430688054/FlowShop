 package com.gcj.service;
 
 import com.gcj.domain.UserMessage;
 import com.gcj.utils.SqlHelper;
 import java.sql.Connection;
 import java.sql.PreparedStatement;
 import java.sql.ResultSet;
 import java.sql.SQLException;
 import java.sql.Statement;
 import java.util.ArrayList;
 
 public class UserMessageService
 {
   private ResultSet rs = null;
   private Connection ct = null;
   private PreparedStatement ps = null;
   private Statement sm = null;
 
   public boolean insertMessage(UserMessage usermessage)
   {
     boolean b = true;
     try
     {
       String sql = "insert into usermessage(username,messagetime,title,content,ischecked) value(?,now(),?,?,?)";
       String[] parameters = { usermessage.getUsername(), usermessage.getTitle(), usermessage.getContent(), usermessage.getIschecked() };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return b;
   }
 
   public ArrayList getMessagesByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from usermessage limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         UserMessage userMessage = new UserMessage();
         userMessage.setId(this.rs.getInt(1));
         userMessage.setUsername(this.rs.getString(2));
         userMessage.setMessagetime(this.rs.getDate(3));
         userMessage.setTitle(this.rs.getString(4));
         userMessage.setContent(this.rs.getString(5));
         userMessage.setIschecked(this.rs.getString(6));
         al.add(userMessage);
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
       this.ps = this.ct.prepareStatement("select count(*) from usermessage");
 
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
 
   public boolean updMessage(String id)
   {
     boolean b = true;
     try
     {
       String sql = "update usermessage set ischecked='是' where id=?";
       String[] parameters = { id };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public UserMessage getUserMessageById(String id)
   {
     UserMessage userMessage = new UserMessage();
 
     String sql = "select * from usermessage where id=?";
     String[] parameters = { id };
     ResultSet rs = SqlHelper.executeQuery(sql, parameters);
     try
     {
       if (rs.next())
       {
         userMessage.setId(rs.getInt(1));
         userMessage.setUsername(rs.getString(2));
         userMessage.setMessagetime(rs.getDate(3));
         userMessage.setTitle(rs.getString(4));
         userMessage.setContent(rs.getString(5));
         userMessage.setIschecked(rs.getString(6));
       }
     }
     catch (SQLException e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return userMessage;
   }
 
   public ArrayList getMessages()
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from usermessage where ischecked='是' order by id desc limit 8");
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         UserMessage userMessage = new UserMessage();
         userMessage.setId(this.rs.getInt(1));
         userMessage.setUsername(this.rs.getString(2));
         userMessage.setMessagetime(this.rs.getDate(3));
         userMessage.setTitle(this.rs.getString(4));
         userMessage.setContent(this.rs.getString(5));
         userMessage.setIschecked(this.rs.getString(6));
         al.add(userMessage);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public ArrayList getOtherMessage(String id)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from usermessage where ischecked='是' and id !=?");
       this.ps.setString(1, id);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         UserMessage userMessage = new UserMessage();
         userMessage.setId(this.rs.getInt(1));
         userMessage.setUsername(this.rs.getString(2));
         userMessage.setMessagetime(this.rs.getDate(3));
         userMessage.setTitle(this.rs.getString(4));
         userMessage.setContent(this.rs.getString(5));
         userMessage.setIschecked(this.rs.getString(6));
         al.add(userMessage);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 }
