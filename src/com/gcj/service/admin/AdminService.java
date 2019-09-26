 package com.gcj.service.admin;
 
 import com.gcj.domain.Users;
 import com.gcj.domain.admin.Admin;
 import com.gcj.utils.SqlHelper;
 import java.sql.Connection;
 import java.sql.PreparedStatement;
 import java.sql.ResultSet;
 import java.sql.SQLException;
 import java.util.ArrayList;
 
 public class AdminService
 {
   private ResultSet rs = null;
   private Connection ct = null;
   private PreparedStatement ps = null;
 
   public boolean checkAdmin(String u, String p)
   {
     boolean b = false;
     String sql = "select * from admin where name=? and passwd=?";
     String[] parameters = { u, p };
     ResultSet rs = SqlHelper.executeQuery(sql, parameters);
     try {
       if (rs.next())
         b = true;
     }
     catch (SQLException e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return b;
   }
 
   public Admin getAdminByName(String u) {
     Admin admin = new Admin();
 
     String sql = "select * from admin where name=?";
     String[] parameters = { u };
     ResultSet rs = SqlHelper.executeQuery(sql, parameters);
     try
     {
       if (rs.next())
       {
         admin.setId(rs.getInt(1));
         admin.setName(rs.getString(2));
         admin.setPasswd(rs.getString(3));
         admin.setGrade(rs.getString(4));
       }
     }
     catch (SQLException e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return admin;
   }
 
   public Admin getAdminById(String id)
   {
     Admin admin = new Admin();
 
     String sql = "select * from admin where id=?";
     String[] parameters = { id };
     ResultSet rs = SqlHelper.executeQuery(sql, parameters);
     try
     {
       if (rs.next())
       {
         admin.setId(rs.getInt(1));
         admin.setName(rs.getString(2));
         admin.setPasswd(rs.getString(3));
         admin.setGrade(rs.getString(4));
       }
     }
     catch (SQLException e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return admin;
   }
 
   public boolean updAdmin(Admin admin)
   {
     boolean b = true;
     try
     {
       String sql = "update admin set name=? ,passwd=?,grade=? where id=? ";
       String[] parameters = { admin.getName(), admin.getPasswd(), admin.getGrade(), ""+admin.getId() };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public boolean insertAdmin(Admin admin)
   {
     boolean b = true;
     try
     {
       String sql = "insert into admin(name,passwd,grade) values(?,?,?)";
       String[] parameters = { admin.getName(), admin.getPasswd(), admin.getGrade() };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return b;
   }
 
   public boolean updAdminPwd(Admin admin)
   {
     boolean b = true;
     try
     {
       String sql = "update admin set passwd=? where id=? ";
       String[] parameters = { admin.getPasswd(), ""+admin.getId() };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public int getPageCount(int pageSize)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from admin");
 
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
 
   public ArrayList getAdminsByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from admin limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         Admin admin = new Admin();
         admin.setId(this.rs.getInt(1));
         admin.setName(this.rs.getString(2));
         admin.setPasswd(this.rs.getString(3));
         admin.setGrade(this.rs.getString(4));
         al.add(admin);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public boolean delAdmin(String id)
   {
     boolean b = true;
     String sql = "delete from admin where id=?";
     String[] parameters = { id };
     try {
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
     }
     return b;
   }
 
   public int getPageCount1(int pageSize)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from users");
 
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
 
   public ArrayList getUsersByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from users limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         Users user = new Users();
 
         user.setUserid(this.rs.getInt(1));
         user.setUsername(this.rs.getString(2));
         user.setTruename(this.rs.getString(3));
         user.setSex(this.rs.getString(4));
         user.setPasswd(this.rs.getString(5));
         user.setEmail(this.rs.getString(6));
         user.setPhone(this.rs.getString(7));
         user.setAddress(this.rs.getString(8));
         user.setPostcode(this.rs.getString(9));
         user.setGrade(this.rs.getInt(10));
         user.setScore(this.rs.getInt(11));
 
         al.add(user);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public boolean delUser(String id)
   {
     boolean b = true;
     String sql = "delete from users where userid=?";
     String[] parameters = { id };
     try {
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
     }
     return b;
   }
 }
